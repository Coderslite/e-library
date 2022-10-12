import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_library/screens/authentication/pass_auth.dart';
import 'package:e_library/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
// import 'package:flash/flash.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      // ignore: prefer_const_constructors
      backgroundColor: Color.fromARGB(255, 31, 31, 44),

      body: Container(
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                name: 'email',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                ),
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     label: Text("Email"),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  handleRegister();
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 2, 50)),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Register"),
              ),
              const SizedBox(
                height: 29,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account ?"),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const LoginScreen();
                      }));
                    },
                    child: const Text(
                      "login",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      final formData = _formKey.currentState!.value;
      print(formData);
      // print("object");
      var response = await http.post(
        Uri.parse(
          "https://activeglobalfx.com/e-library/register.php",
        ),
        body: {
          "email": formData['email'].toString(),
        },
      );

      var userData = jsonDecode(response.body);
      // print(userData);
      if (userData['message'] != 'email already exist') {
        setState(() {
          isLoading = false;
        });
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return PasswordAuth(email: formData['email']);
            },
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Registration Failed',
          desc: userData['message'],
          btnCancelOnPress: () {},
          // btnOkOnPress: () {},
        )..show();
      }
    }
  }
}
