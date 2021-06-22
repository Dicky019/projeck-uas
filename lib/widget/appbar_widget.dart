import 'package:projeck_uas/Page_Auth/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppbarCostum extends StatelessWidget {
  const AppbarCostum({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "SisFo Mahasiswa",
                style: GoogleFonts.montserrat(
                    color: Colors.greenAccent[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              SizedBox(
                width: 54,
              ),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.signOutAlt),
                  onPressed: () async {
                    SharedPreferences prefLogin = await SharedPreferences.getInstance();
                    prefLogin.remove("email");
                    Get.offAll(() => LoginPage());
                  }),
              SizedBox(
                width: 4,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
