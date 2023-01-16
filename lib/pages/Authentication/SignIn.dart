// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:etransport_nscet/services/auth.dart';
import 'package:etransport_nscet/services/userDB.dart';
import 'package:etransport_nscet/utils/SnackBar.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/blue.png"),
            fit: BoxFit.cover,
          ),
        ),
        // use any child here
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          children: [
            const SizedBox(height: 150.0),
            const Text(
              "NSCET",
              style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 40,
                  color: Color.fromRGBO(0, 45, 77, 1)),
              textAlign: TextAlign.center,
            ),
            const Text(
              "E-TRANSPORT",
              style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 40,
                  color: Color.fromRGBO(0, 45, 77, 1)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a valid email address' : null,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.email_outlined,
                            color: Color.fromRGBO(78, 138, 186, 1),
                          ),
                          labelText: 'Email Address',
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(9, 46, 94, 1)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(78, 138, 186, 1),
                                width: 1.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(9, 46, 94, 1),
                                width: 1.5),
                          )),
                      cursorColor: const Color.fromRGBO(9, 46, 94, 1),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      }),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    validator: (val) => val!.length < 6
                        ? 'Enter a password with 6+ characters'
                        : null,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.lock_outline,
                        color: Color.fromRGBO(78, 138, 186, 1),
                      ),
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(9, 46, 94, 1)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(78, 138, 186, 1), width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(9, 46, 94, 1), width: 1.5),
                      ),
                    ),
                    cursorColor: const Color.fromRGBO(9, 46, 94, 1),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(78, 138, 186, 1),
                          padding: const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          dynamic result = await _auth.signIn(email, password);
                          if (result != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar(result.message.toString()));
                          } else {
                            UserData userData = UserData();
                            userData.loadData2Local();
                          }
                        }
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily: 'Times New Roman',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      )),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: TextButton(
                          onPressed: () {
                            widget.toggleView(0);
                          },
                          child: const Text(
                            "New User ?",
                            style: TextStyle(
                                fontFamily: 'Times New Roman',
                                fontSize: 14,
                                color: Color.fromRGBO(27, 27, 27, 1)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            widget.toggleView(1);
                          },
                          child: const Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                fontFamily: 'Times New Roman',
                                fontSize: 14,
                                color: Color.fromRGBO(27, 27, 27, 1)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
