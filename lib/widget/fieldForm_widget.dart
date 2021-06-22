import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class Cread extends StatelessWidget {
  final TextEditingController textEditingController;
  final String text;
  const Cread({
    Key? key,
    required this.textEditingController,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.montserrat(
                color: Colors.greenAccent[400],
                fontWeight: FontWeight.w600,
                fontSize: 19),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.greenAccent.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            child: TextFormField(
              validator: RequiredValidator(errorText: "must be filled"),
              controller: textEditingController,
              style: GoogleFonts.montserrat(fontSize: 22, color: Colors.black),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreadSearch extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final IconButton iconButton;
  const CreadSearch({
    Key? key,
    required this.iconButton,
    required this.textEditingController,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        border: Border.all(
          width: 2.5,
          color: textEditingController.text == ''
              ? Colors.grey.withOpacity(0.5)
              : Color(0xff00c853).withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: textEditingController,
        style: GoogleFonts.montserrat(fontSize: 22, color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle:
                GoogleFonts.montserrat(fontSize: 22, color: Colors.black),
            suffixIcon: iconButton),
      ),
    );
  }
}

class CreadDetail extends StatelessWidget {
  final String text, data;
  const CreadDetail({
    required this.data,
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.montserrat(
                color: Colors.greenAccent[400],
                fontWeight: FontWeight.w600,
                fontSize: 19),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: Offset(1, 3), // changes position of shadow
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 14.4, 3, 14.4),
                child: Text(
                  data,
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              )),
        ],
      ),
    );
  }
}

class CreadDetailTTL extends StatelessWidget {
  final String text, data;
  const CreadDetailTTL({
    required this.data,
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.montserrat(
                color: Colors.greenAccent[400],
                fontWeight: FontWeight.w600,
                fontSize: 19),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: Offset(1, 3), // changes position of shadow
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 15.4, 3, 14.4),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    data,
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
