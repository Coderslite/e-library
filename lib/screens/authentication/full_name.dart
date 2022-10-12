import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_library/screens/homepage.dart';
import 'package:e_library/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FullNameAuth extends StatefulWidget {
  final String email;
  final String password;
  const FullNameAuth({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  State<FullNameAuth> createState() => _FullNameAuthState();
}

class _FullNameAuthState extends State<FullNameAuth> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter Full Name",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'fullName',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6),
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Full Name"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderDropdown(
                      name: 'department',
                      isExpanded: true,
                      initialValue: "Computer Science",
                      items: [
                        "Computer Science",
                        "Engineering",
                        "Maths and Statistics",
                        "Business Admin",
                        "Accounting",
                        "Banking and Finance"
                      ].map((option) {
                        return DropdownMenuItem(
                          child: Text(option),
                          value: option,
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),
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
                          ? CircularProgressIndicator()
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
                          onTap: () {},
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
                )),
          ],
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
          "email": widget.email.toString(),
          "full_name": formData['fullName'].toString(),
          "password": widget.password.toString(),
          "department": formData['department'].toString()
        },
      );

      var userData = jsonDecode(response.body);
      // print(userData);
      if (userData['status'] = true) {
        setState(() {
          isLoading = false;
        });
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('email', widget.email);
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Registration Successful',
          desc: userData['message'],
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return SidebarXExampleApp();
                },
              ),
            );
          },
        )..show();
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
