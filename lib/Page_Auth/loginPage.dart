import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeck_uas/Page_Landing/landingPage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  void validateLogin() async {
    if (_fromkey.currentState!.validate()) {
      try {
        await _firebaseAuth
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) async {
          SharedPreferences prefLogin = await SharedPreferences.getInstance();
          prefLogin.setString("email", _emailController.text);
          Get.off(() => Landing(), transition: Transition.cupertinoDialog);
        });
        dispose();   
      } on FirebaseAuthException catch (e) {
        print("$e + errornya");
      } catch (e) {
        print("$e + errornya");
        return null;
      }
    } else {
      print("blm valid");
    }
  }

  @override
  void initState() {
    _passwordController.text;
    _emailController.text;
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.text;
    _emailController.text;
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool passView = true, eye = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Form(
              key: _fromkey,
              // ignore: deprecated_member_use
              autovalidate: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 80.0, 0.0, 0.0),
                          child: Text('Hello',
                              style: GoogleFonts.montserrat(
                                  fontSize: 65.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(1, 145.0, 0.0, 0.0),
                          child: Text('There',
                              style: GoogleFonts.montserrat(
                                  fontSize: 65.0, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(188.0, 145.0, 0.0, 0.0),
                          child: Text('.',
                              style: GoogleFonts.montserrat(
                                  fontSize: 65.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "must be filled"),
                      EmailValidator(errorText: 'enter a valid email address'),
                    ]),
                    controller: _emailController,
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: MultiValidator([
                      MinLengthValidator(6,
                          errorText: 'password must be at least 6 digits long'),
                      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                          errorText:
                              'passwords must have at least one special character')
                    ]),
                    controller: _passwordController,
                    obscureText: passView,
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          splashRadius: 2,
                          color: Colors.black,
                          icon: Icon((eye == true)
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined),
                          onPressed: () {
                            setState(() {
                              passView = !passView;
                              eye = !eye;
                            });
                          },
                        ),
                        // contentPadding: EdgeInsets.only(top: 10),
                        labelText: "password",
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: InkWell(
                        onTap: () {
                          validateLogin();
                        },
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "don't have an account  ?",
                        style: GoogleFonts.montserrat(),
                      ),
                      SizedBox(width: 5.0),
                      InkWell(
                        onTap: () {
                          Get.to(() => RegisterPage());
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 4, right: 4, top: 2),
                          height: 20,
                          child: Text(
                            'Register',
                            style: GoogleFonts.montserrat(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
