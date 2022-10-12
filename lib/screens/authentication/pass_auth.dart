import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_library/screens/authentication/full_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordAuth extends StatefulWidget {
  final String email;
  const PasswordAuth({Key? key, required this.email}) : super(key: key);

  @override
  State<PasswordAuth> createState() => _PasswordAuthState();
}

class _PasswordAuthState extends State<PasswordAuth> {
  final _formKey = GlobalKey<FormBuilderState>();
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
              "Create Password",
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
                      name: 'password',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6),
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'c_password',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6),
                      ]),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        handleConfirmPassword();
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width * 2, 50)),
                      child: const Text("Continue"),
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

  handleConfirmPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var formData = _formKey.currentState!.value;
      if (formData['password'] != formData['c_password']) {
        // print("password is incorrect");
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Password does not match',
          // desc:"Pa",
          btnCancelOnPress: () {},
          // btnOkOnPress: () {},
        )..show();
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return FullNameAuth(
            email: widget.email,
            password: formData['password'],
          );
        }));
      }
    }
  }
}
