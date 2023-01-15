// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:etransport_nscet/services/auth.dart';
import 'package:etransport_nscet/utils/SnackBar.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String role = '';
  String dept = '';
  String name = '';
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg4.png"),
          fit: BoxFit.cover,
        ),
      ),
      child:
          ListView(padding: const EdgeInsets.fromLTRB(15, 0, 15, 0), children: [
        const SizedBox(height: 60.0),
        const Text(
          "NSCET AMS",
          style: TextStyle(
              fontFamily: 'Times New Roman',
              fontSize: 40,
              color: Color.fromRGBO(19, 69, 0, 1)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30.0),
        const Text(
          "REGISTER",
          style: TextStyle(
              fontFamily: 'Times New Roman',
              fontSize: 32,
              color: Color.fromRGBO(92, 143, 1, 1)),
          textAlign: TextAlign.center,
        ),
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
                      color: Color.fromRGBO(12, 46, 2, 1),
                    ),
                    labelText: 'Email Address',
                    labelStyle: TextStyle(color: Color.fromRGBO(12, 46, 2, 1)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(143, 197, 46, 1), width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(12, 46, 2, 1), width: 1.5),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  }),
              const SizedBox(height: 10.0),
              TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter your name' : null,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person_outline,
                      color: Color.fromRGBO(12, 46, 2, 1),
                    ),
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Color.fromRGBO(12, 46, 2, 1)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(143, 197, 46, 1), width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(12, 46, 2, 1), width: 1.5),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      name = val;
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
                      color: Color.fromRGBO(12, 46, 2, 1),
                    ),
                    labelText: 'Choose Password',
                    labelStyle: TextStyle(color: Color.fromRGBO(12, 46, 2, 1)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(143, 197, 46, 1), width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(12, 46, 2, 1), width: 1.5),
                    ),
                  ),
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  }),
              const SizedBox(height: 10.0),
              DropdownButtonFormField(
                validator: (val) {
                  if (val == null) {
                    return "Choose your role";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.badge_outlined,
                    color: Color.fromRGBO(12, 46, 2, 1),
                  ),
                  labelText: 'Role',
                  labelStyle: TextStyle(color: Color.fromRGBO(12, 46, 2, 1)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(143, 197, 46, 1), width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(12, 46, 2, 1), width: 1.5),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    child: Text("HOD"),
                    value: "HOD",
                  ),
                  DropdownMenuItem(
                    child: Text("Class Incharge"),
                    value: "CI",
                  )
                ],
                onChanged: (val) {
                  setState(() {
                    role = val.toString();
                  });
                },
              ),
              const SizedBox(height: 10.0),
              DropdownButtonFormField(
                validator: (val) {
                  if (val == null) {
                    return "Choose your department";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: Color.fromRGBO(12, 46, 2, 1),
                  ),
                  labelText: 'Department',
                  labelStyle: TextStyle(color: Color.fromRGBO(12, 46, 2, 1)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(143, 197, 46, 1), width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(12, 46, 2, 1), width: 1.5),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    child: Text("Science and Humanites"),
                    value: "S&H",
                  ),
                  DropdownMenuItem(
                    child: Text("Computer Science & Engineering"),
                    value: "CSE",
                  ),
                  DropdownMenuItem(
                    child: Text("Mechanical Engineering"),
                    value: "MECH",
                  ),
                  DropdownMenuItem(
                    child: Text("Electronics & Communication Engineering"),
                    value: "ECE",
                  ),
                  DropdownMenuItem(
                    child: Text("Civil Engineering"),
                    value: "CIVIL",
                  ),
                  DropdownMenuItem(
                    child: Text("Electrical & Electronics Engineering"),
                    value: "EEE",
                  ),
                ],
                onChanged: (val) {
                  setState(() {
                    dept = val.toString();
                  });
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(92, 143, 1, 1),
                    padding: const EdgeInsets.fromLTRB(25, 8, 25, 8)),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    dynamic result =
                        await _auth.register(email, password, name, role, dept);
                    if (result != null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(getSnackBar(result.message.toString()));
                    }
                  }
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              TextButton(
                onPressed: () {
                  widget.toggleView(2);
                },
                child: const Text(
                  "Already Registered ?",
                  style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 14,
                      color: Color(0xff4C4C4C)),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ]),
    ));
  }
}
