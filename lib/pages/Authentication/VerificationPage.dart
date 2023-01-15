// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:etransport_nscet/services/auth.dart';
import 'package:etransport_nscet/utils/SnackBar.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: FractionalOffset.center,
            child: ListView(
              children: [
                const SizedBox(height: 200.0),
                const Text(
                  "Verify your email",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontFamily: 'Times New Roman',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(219, 45, 2, 1),
                      padding: const EdgeInsets.fromLTRB(25, 14, 25, 14)),
                  onPressed: () async {
                    dynamic result = await _auth.sendVerificationEmail();
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                          'Check your registered mail for verification .'));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(getSnackBar(result.toString()));
                    }
                    _auth.signOut();
                  },
                  child: const Text(
                    "Send Verification Link",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                const SizedBox(height: 60.0),
                const Text(
                  "Mail verification link will be sent to your registered mail Id .",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontFamily: 'Times New Roman',
                  ),
                )
              ],
            ),
          )),
    );
  }
}
