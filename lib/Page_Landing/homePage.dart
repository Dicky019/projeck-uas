
import 'package:projeck_uas/Page_UDL/list.dart';
import 'package:projeck_uas/widget/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:projeck_uas/widget/appbar_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppbarCostum(),
            ListCard(
              onTap: () {
                Get.to(() => ListPage(
                      konsentasi: "HARDWARE",
                    ));
              },
              image: "hardware.png",
              nama: "HARDWARE",
            ),
            ListCard(
              onTap: () {
                Get.to(() => ListPage(
                      konsentasi: "PROGRAM",
                    ));
              },
              image: "program.png",
              nama: "PROGRAM",
            ),
            ListCard(
              onTap: () {
                Get.to(() => ListPage(
                      konsentasi: "MULTIMEDIA",
                    ));
              },
              image: "mulmed.png",
              nama: "MULTIMEDIA",
            ),
            ListCard(
              onTap: () {
                Get.to(() => ListPage(
                      konsentasi: "NETWORK",
                    ));
              },
              image: "jaringan.png",
              nama: "NETWORK",
            ),
          ],
        ),
      ),
    );
  }
}
