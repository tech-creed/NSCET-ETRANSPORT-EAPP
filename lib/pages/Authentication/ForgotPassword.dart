// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:etransport_nscet/services/auth.dart';
import 'package:etransport_nscet/utils/SnackBar.dart';

class ForgotPassword extends StatefulWidget {
  final Function toggleView;
  const ForgotPassword({Key? key, required this.toggleView}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  bool showOTP = false;
  bool showForm = true;
  bool showGetResetPassword = false;

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
      child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          children: <Widget>[
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
            const Text(
              "RESET PASSWORD",
              style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 32,
                  color: Color.fromRGBO(9, 83, 145, 1)),
              textAlign: TextAlign.center,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10.0),
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
                            TextStyle(color: Color.fromRGBO(0, 45, 77, 1)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(78, 138, 186, 1),
                              width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(9, 83, 145, 1),
                              width: 1.5),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      }),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(35, 123, 196, 1),
                          padding: const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          dynamic result =
                              await _auth.sendPasswordResetEmail(email);

                          if (result == null) {
                            ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                                "Password reset link sent to your registered mail address ."));
                            widget.toggleView(2);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar(result.message.toString()));
                          }
                        }
                      },
                      child: const Text(
                        "Send Link",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Times New Roman',
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
                                color: Color(0xff4C4C4C)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            widget.toggleView(2);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: 'Times New Roman',
                                fontSize: 14,
                                color: Color(0xff4C4C4C)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]),
    ));
  }
}
