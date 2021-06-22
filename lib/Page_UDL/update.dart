import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:projeck_uas/widget/fieldForm_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import '../api/firebase_api.dart';

class Konsentasi {
  late final String title;

  Konsentasi(
    this.title,
  );
}

class JenisKelamin {
  late final String title;

  JenisKelamin(
    this.title,
  );
}

// ignore: must_be_immutable
class UpdatePage extends StatefulWidget {
  UpdatePage(
      {required this.username,
      required this.nim,
      required this.konsentrasi,
      required this.jenisKelamin,
      required this.tanggalLahir,
      required this.tempat,
      required this.urlImage,
      required this.id});
  late String username = '', nim = '', urlImage;
  late String? id, tempat, konsentrasi = '', jenisKelamin = '', tanggalLahir;

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  static final List<String> items = <String>[
    'HARDWARE',
    'PROGRAM',
    'MULTIMEDIA',
    'NETWORK',
  ];
  // Konsentasi? _valueKonsentrasi = items.last;

  static final List<String> jenis = <String>[
    'Laki - Laki',
    'Perempuan',
  ];

  UploadTask? task;
  File? file;
  late File imagefile;
  late String imageurl = 'null', tanggaLahir = '';
  late int age = 0;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _tempatController = TextEditingController();
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user');
  late DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  void dispose() {
    _namaController.text;
    _tempatController.text;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    if (_namaController.text == '') {
      _namaController.text = widget.username;
    }
    if (_nimController.text == '') {
      _nimController.text = widget.nim;
    }
    if (_tempatController.text == '') {
      _tempatController.text = widget.tempat!;
    }
    if (imageurl == "null") {
      imageurl = widget.urlImage;
    }
    if (tanggaLahir == '') {
      tanggaLahir = widget.tanggalLahir!;
    }

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
                      width: 97.3,
                    ),
                    Text(
                      "Update",
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
              _showImage(),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Cread(
                    text: "Nama",
                    textEditingController: _namaController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Cread(
                    text: "Nim",
                    textEditingController: _nimController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 11),
                    child: Text(
                      "Konsentrasi",
                      style: GoogleFonts.montserrat(
                          color: Colors.greenAccent[400],
                          fontWeight: FontWeight.w600,
                          fontSize: 19),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 11),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: (widget.konsentrasi == '')
                            ? null
                            : widget.konsentrasi,
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  child: Row(
                                    children: [
                                      Text(
                                        item,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: item,
                                ))
                            .toList(),
                        onChanged: (value) => setState(() {
                          this.widget.konsentrasi = value!;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Text(
                  "Jenis Kelamin",
                  style: GoogleFonts.montserrat(
                      color: Colors.greenAccent[400],
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: 11,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: (widget.jenisKelamin == '')
                        ? null
                        : widget.jenisKelamin,
                    items: jenis
                        .map((j) => DropdownMenuItem<String>(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      j,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              value: j,
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      this.widget.jenisKelamin = value!;
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 165,
                    child: Cread(
                        textEditingController: _tempatController,
                        text: "Tempat Lahir"),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tanggal Lahir",
                        style: GoogleFonts.montserrat(
                            color: Colors.greenAccent[400],
                            fontWeight: FontWeight.w600,
                            fontSize: 19),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 11),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: Offset(1, 3),
                            )
                          ],
                        ),
                        height: 56,
                        width: 184,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 5),
                          child: InkWell(
                            onTap: _pickDate,
                            child: Row(
                              children: [
                                Text(
                                  tanggaLahir == '' ? '' : tanggaLahir,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 35),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    padding: const EdgeInsets.only(left: 11.0),
                    // ignore: deprecated_member_use
                    child: OutlineButton(
                      borderSide:
                          BorderSide(width: 2, color: Colors.greenAccent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.greenAccent,
                      highlightColor: Colors.greenAccent.withOpacity(0.20),
                      splashColor: Colors.greenAccent.withOpacity(0.35),
                      highlightedBorderColor: Colors.greenAccent,
                      onPressed: () {
                        setState(() {
                          tanggaLahir = '';
                          _namaController.text = '';
                          _nimController.text = '';
                          _tempatController.text = '';
                          file = null;
                          imageurl = 'null';
                          widget.tanggalLahir = '';
                          widget.username = '';
                          widget.nim = '';
                          widget.urlImage = 'null';
                          widget.tempat = '';
                          widget.jenisKelamin = '';
                          widget.konsentrasi = '';
                        });
                      },
                      child: Text(
                        "HAPUS",
                        style: GoogleFonts.montserrat(
                            color: Colors.greenAccent[400],
                            fontWeight: FontWeight.w600,
                            fontSize: 19),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.greenAccent[400]),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2 - 12,
                    margin: const EdgeInsets.only(left: 11.0, right: 11),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent[400],
                      child: InkWell(
                        highlightColor: Colors.greenAccent.withOpacity(0.20),
                        splashColor: Colors.greenAccent.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(10),
                        // splashColor: Colors.white,
                        onTap: uploadFile,
                        child: Center(
                          child: Text(
                            "UPDATE",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = (await showDatePicker(
        initialDate: DateTime(pickedDate.year - 20, DateTime.august),
        firstDate: DateTime(pickedDate.year - 25),
        lastDate: DateTime(pickedDate.year + 2),
        context: this.context))!;
    // ignore: unnecessary_null_comparison
    if (date != null) {
      List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      var tes = months.asMap();
      var bulan = tes[date.month - 1];
      setState(() {
        tanggaLahir = "${date.year}, $bulan, ${date.day}";
        print("tanggal : $tanggaLahir");
        age = pickedDate.year - date.year;
        int month1 = pickedDate.month;
        int month2 = date.month;
        if (month2 > month1) {
          age--;
        } else if (month1 == month2) {
          int day1 = pickedDate.day;
          int day2 = date.day;
          if (day2 > day1) {
            age--;
          }
        }
        print("umur $age");
      });
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      imagefile = File(path);
    });
    print(file.toString());
  }

  _showImage() {
    if (file == null && imageurl == 'null') {
      return Center(
        child: Container(
            height: 150,
            width: 150,
            decoration:
                BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
            child: Material(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(150 / 2),
              child: InkWell(
                borderRadius: BorderRadius.circular(150 / 2),
                highlightColor: Colors.greenAccent.withOpacity(0.20),
                splashColor: Colors.greenAccent.withOpacity(0.35),
                onTap: selectFile,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            )),
      );
    } else if (file != null) {
      return Center(
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(160 / 2),
            image:
                DecorationImage(image: FileImage(imagefile), fit: BoxFit.cover),
          ),
          child: Center(
            // ignore: deprecated_member_use
            child: FlatButton(
              padding: EdgeInsets.all(10),
              color: Colors.black.withOpacity(0.3),
              child: Text(
                'Change Image',
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () => selectFile(),
            ),
          ),
        ),
      );
    } else if (imageurl != 'null') {
      return Center(
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(160 / 2),
            image: DecorationImage(
                image: NetworkImage(imageurl), fit: BoxFit.cover),
          ),
          child: Center(
            // ignore: deprecated_member_use
            child: FlatButton(
              padding: EdgeInsets.all(10),
              color: Colors.black.withOpacity(0.3),
              child: Text(
                'Change Image',
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () => selectFile(),
            ),
          ),
        ),
      );
    }
  }

  Future uploadFile() async {
    RegExp regExp = new RegExp(r"\s+");
    String oldtext = _namaController.text + "a";
    var newSearch = oldtext.replaceAll(regExp, "");
    List<String> splitList = newSearch.split(' ');
    List<String> indeList = [];

    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + i; j++) {
        indeList.add(splitList[i].substring(0, j).toLowerCase());
      }

      print(indeList);
    }
    if (file == null)
      return await collectionReference.doc(widget.id).update({
        'nama': _namaController.text,
        'nim': _nimController.text,
        'konsentrasi': widget.konsentrasi,
        'jenisKelasmin': widget.jenisKelamin,
        'url_image': (imageurl != "null")
            ? imageurl
            : "https://cdn.dribbble.com/users/1355613/screenshots/15252730/media/28f348daf9654c440f5dcf398d8e097a.jpg?compress=1&resize=1000x750",
        'tanggal_lahir': tanggaLahir,
        'tempat': _tempatController.text,
        'search': indeList,
      }).then((value) {
        setState(() {
          widget.tanggalLahir = tanggaLahir;
          widget.username = _namaController.text;
          widget.nim = _nimController.text;
          widget.tempat = _tempatController.text;
          file = null;
          imageurl = 'null';
        });
        _berhasil();
      });

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});

    imageurl = await snapshot.ref.getDownloadURL();

    print('Download-Link: $imageurl');

    await collectionReference.doc(widget.id).update({
      'nama': _namaController.text,
      'nim': _nimController.text,
      'konsentrasi': widget.konsentrasi,
      'jenisKelasmin': widget.jenisKelamin,
      'url_image': (imageurl != "null")
          ? imageurl
          : "https://cdn.dribbble.com/users/1355613/screenshots/15252730/media/28f348daf9654c440f5dcf398d8e097a.jpg?compress=1&resize=1000x750",
      'tanggal_lahir': tanggaLahir,
      'tempat': _tempatController.text,
      'search': indeList,
    }).then((value) {
      setState(() {
        widget.tanggalLahir = tanggaLahir;
        widget.username = _namaController.text;
        widget.nim = _nimController.text;
        widget.urlImage = imageurl;
        widget.tempat = _tempatController.text;
        file = null;
        imageurl = 'null';
      });
      _berhasil();
    });
  }

  _berhasil() {
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
        });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text("$percentage %");
          } else {
            return Container();
          }
        },
      );
}
