import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_library/screens/authentication/email_auth.dart';
import 'package:e_library/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 44),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome Back",
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
                    border: OutlineInputBorder(), label: Text("Email Address")),
              ),
              const SizedBox(
                height: 20,
              ),
              FormBuilderTextField(
                name: 'password',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Email Address")),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  handleLogin();
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 2, 50)),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Login"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ?"),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const EmailAuthScreen();
                      }));
                    },
                    child: const Text(
                      "create one",
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

  handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      var formData = _formKey.currentState!.value;
      var response = await http.post(
          Uri.parse("https://activeglobalfx.com/e-library/login.php"),
          body: {
            "email": formData['email'],
            "password": formData['password'],
          });
      var userData = jsonDecode(response.body);
      if (userData['status'] == false) {
        setState(() {
          isLoading = false;
        });
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Login Failed',
          desc: userData['message'],
          btnCancelOnPress: () {},
          // btnOkOnPress: () {},
        )..show();
      } else {
        setState(() {
          isLoading = false;
        });
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('email', formData['email']);
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Login Successful',
          desc: userData['message'],
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
              return SidebarXExampleApp();
            }));
          },
        )..show();
      }
    }
  }
}
