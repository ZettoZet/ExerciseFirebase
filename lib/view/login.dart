import 'package:firebasepaml/controller/auth_controller.dart';
import 'package:firebasepaml/model/user_model.dart';
import 'package:firebasepaml/view/contact.dart';
import 'package:firebasepaml/view/register.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  final authCtr = AuthController();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(39.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 39, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  onChanged: (value) => email = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email must not empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  onChanged: (value) => password = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password must not empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: const Text('Log In'),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      UserModel? loginUser =
                          await authCtr.signInWithEmailAndPassword(
                        email!,
                        password!,
                      );
                      if (loginUser != null) {
                        // login success
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Login'),
                              content: const Text('Login Successfully'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const Contact();
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Login failed
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Login'),
                              content:
                                  const Text('An error occured during login'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Doesn't have an account yet? "),
                      InkWell(
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const Register(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ], // Children
            ),
          ),
        ),
      ),
    );
  }
}
