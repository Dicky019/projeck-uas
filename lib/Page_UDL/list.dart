import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeck_uas/Page_UDL/update.dart';
import 'package:projeck_uas/widget/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detailPage.dart';

class ListPage extends StatefulWidget {
  final String konsentasi;
  ListPage({required this.konsentasi});
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _searchController = TextEditingController();
  static String search = '', newSearch = '';
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SisFo Mahasiswa"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 180,
                left: MediaQuery.of(context).size.width / 2 - 75,
                child: Container(
                  width: 150,
                  child: Center(
                      child: Text(_searchController.text != ''
                          ? "Data Kosong : " + _searchController.text
                          : "")),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.konsentasi,
                      style: GoogleFonts.montserrat(
                          color: Colors.greenAccent[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                        border: Border.all(
                          width: 2.5,
                          color: _searchController.text == ''
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
                        onChanged: (val) => initiateSearch(val),
                        controller: _searchController,
                        style: GoogleFonts.montserrat(fontSize: 22, color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle:
                              GoogleFonts.montserrat(fontSize: 22, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                      // ignore: unnecessary_null_comparison
                      stream: collectionReference
                          .where('konsentrasi', isEqualTo: widget.konsentasi)
                          .where("search", arrayContains: search)
                          .snapshots(),                         
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: new CircularProgressIndicator(
                                    strokeWidth: 8,
                                    backgroundColor: Colors.greenAccent,
                                  ),
                                ),
                              );
                            default:
                              return ListView(
                                children: snapshot.data!.docs
                                    .map((e) => ListUser(imagedetail: e['url_image'],
                                          onDelete: () {
                                            collectionReference
                                                .doc(e.id)
                                                .delete();
                                          },
                                          onUpdate: () =>
                                              Get.to(() => UpdatePage(
                                                    username: e['nama'],
                                                    tempat: e['tempat'],
                                                    nim: e['nim'],
                                                    tanggalLahir:
                                                        e['tanggal_lahir'],
                                                    konsentrasi:
                                                        e['konsentrasi'],
                                                    jenisKelamin:
                                                        e['jenisKelasmin'],
                                                    urlImage: e['url_image'],
                                                    id: e.id,
                                                  )),
                                          image: e['url_image'],
                                          nama: e['nama'],
                                          nim: e['nim'],
                                          onPressed: () {
                                            Get.to(() => DetailPage(
                                                  username: e['nama'],
                                                  tempat: e['tempat'],
                                                  nim: e['nim'],
                                                  tanggalLahir:
                                                      e['tanggal_lahir'],
                                                  konsentrasi: e['konsentrasi'],
                                                  jenisKelamin:
                                                      e['jenisKelasmin'],
                                                  urlImage: e['url_image'],
                                                  id: e.id,
                                                ));
                                          },
                                        ))
                                    .toList(),
                              );
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.greenAccent,
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initiateSearch(String val) {
    setState(() {
      RegExp regExp = new RegExp(r"\s+");

      newSearch = val.replaceAll(regExp, "");

      search = newSearch.toLowerCase().trim();
      print(search);
    });
  }
}
