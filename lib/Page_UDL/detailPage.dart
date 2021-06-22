
import 'package:projeck_uas/widget/fieldForm_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  DetailPage(
      {required this.username,
      required this.nim,
      required this.konsentrasi,
      required this.jenisKelamin,
      required this.tanggalLahir,
      required this.tempat,
      required this.urlImage,
      required this.id});
  late String username = '', nim = '', urlImage = '';
  late String id = '',
      tempat = '',
      konsentrasi = '',
      jenisKelamin = '',
      tanggalLahir = '';

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.arrowLeft),
                        onPressed: () {
                          Get.back();
                        }),
                    SizedBox(
                      width: 54,
                    ),
                    Text(
                      "SisFo Mahasiswa",
                      style: GoogleFonts.montserrat(
                          color: Colors.greenAccent[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(() => DetailImage(
                          image: widget.urlImage,
                          nama: widget.username,
                        ));
                  },
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(160 / 2),
                      image: DecorationImage(
                          image: NetworkImage(widget.urlImage),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CreadDetail(
                text: "Nama",
                data: widget.username,
              ),
              SizedBox(
                height: 15,
              ),
              CreadDetail(
                text: "Nim",
                data: widget.nim,
              ),
              SizedBox(
                height: 15,
              ),
              CreadDetail(data: widget.konsentrasi, text: "Konsentrasi"),
              SizedBox(
                height: 15,
              ),
              CreadDetail(data: widget.jenisKelamin, text: "Jenis Kelamin"),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 172,
                    child: CreadDetailTTL(
                        data: widget.tempat, text: "Tempat Lahir"),
                  ),
                  Container(
                    width: 177,
                    child: CreadDetailTTL(
                        data: widget.tanggalLahir, text: "Tanggal Lahir"),
                  ),
                  SizedBox(
                    width: 11,
                  )
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailImage extends StatefulWidget {
  DetailImage({required this.image, required this.nama});
  late String image, nama;
  @override
  _DetailImageState createState() => _DetailImageState();
}

class _DetailImageState extends State<DetailImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nama),
        centerTitle: true,
      ),
      body: Center(child: Image.network(widget.image)),
    );
  }
}
