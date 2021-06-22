import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Page_Auth/loginPage.dart';
import 'content_model.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;
  late bool finis;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  void goHome() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginPage(),
      ),
    );
    finis = true;
    SharedPreferences prefOnboar = await SharedPreferences.getInstance();
    prefOnboar.setBool("Onboarding", finis);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 270),
                child: (currentIndex == contents.length - 1)
                    ? SizedBox(height: 30)
                    : TextButton(
                        onPressed: goHome,
                        child: Text(
                          "Skip",
                          style: GoogleFonts.montserrat(
                              color: Colors.greenAccent[400],
                              fontWeight: FontWeight.bold),
                        ),
                      )),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
                    child: SingleChildScrollView(
                                          child: Column(
                        children: [
                          Image.asset(
                            contents[i].image,
                            height: 300,
                          ),
                          Text(
                            contents[i].title,
                            style: GoogleFonts.montserrat(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            contents[i].discription,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: double.infinity,
              // ignore: deprecated_member_use
              child: FlatButton(
                color: Colors.green,
                child: Text(
                  currentIndex == contents.length - 1 ? "Continue" : "Next",
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
                onPressed: () {
                  if (currentIndex == contents.length - 1) {
                    goHome();
                  }
                  _controller.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                },
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
