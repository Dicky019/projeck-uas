import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool eye = false;
  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmController = TextEditingController();

  void singIn() async {
    if (_fromkey.currentState!.validate()) {
      try {
        await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) =>
          showDialog(
              context: this.context,
              builder: (context) {
                return AlertDialog(
                    content: Container(
                        height: 250,
                        child: SvgPicture.asset(
                          "assets/svg/checked.svg",
                          color: Colors.greenAccent,
                        )));
              }));
          Get.back();
        
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          return print('The account already exists for that email.');
        }
      } catch (e) {
        return print("error apa =" + e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _fromkey,
          // ignore: deprecated_member_use
          autovalidate: true,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: Text(
                          'Signup',
                          style: GoogleFonts.montserrat(
                              fontSize: 65.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(245.0, 125.0, 0.0, 0.0),
                        child: Text(
                          '.',
                          style: GoogleFonts.montserrat(
                              fontSize: 65.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    padding:
                        EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(errorText: "must be filled"),
                            EmailValidator(
                                errorText: 'enter a valid email address'),
                          ]),
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              // hintText: 'EMAIL',
                              // hintStyle: ,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          validator: MultiValidator([
                            MinLengthValidator(6,
                                errorText:
                                    'password must be at least 6 digits long'),
                            PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                errorText:
                                    'passwords must have at least one special character')
                          ]),
                          controller: _passwordController,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                splashRadius: 2,
                                color: Colors.black,
                                icon: Icon((eye == true)
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  setState(() {
                                    eye = !eye;
                                  });
                                },
                              ),
                              labelText: 'PASSWORD ',
                              labelStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          obscureText: eye,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _confirmController,
                          validator: (val) {
                            if (val!.isEmpty) return 'Empty';
                            if (val != _passwordController.text)
                              return 'Not Match';
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'CONFIRM PASSWORD',
                              labelStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                        SizedBox(height: 50.0),
                        Container(
                            height: 40.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                              child: InkWell(
                                onTap: singIn,
                                child: Center(
                                  child: Text(
                                    'SIGNUP',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 20.0),
                        Container(
                          height: 40.0,
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                Get.back();
                              },
                              child: Center(
                                child: Text('Go Back',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
        ),
      ),
    ));
  }
}
