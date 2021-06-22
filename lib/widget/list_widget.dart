import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCard extends StatelessWidget {
  final String image, nama;
  final VoidCallback onTap;
  const ListCard({
    required this.image,
    required this.onTap,
    required this.nama,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.20),
              spreadRadius: 3,
              blurRadius: 8,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 11.2, horizontal: 15),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            highlightColor: Colors.greenAccent.withOpacity(0.20),
            splashColor: Colors.greenAccent.withOpacity(0.35),
            onTap: onTap,
            child: Row(
              children: [
                Image.asset(
                  'assets/image/$image',
                  height: 115,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    nama,
                    style: GoogleFonts.montserrat(
                        color: Colors.greenAccent[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ListUser extends StatelessWidget {
  final String image, nama, nim,imagedetail;
  final VoidCallback onPressed, onUpdate, onDelete;
  const ListUser({
    required this.onUpdate,
    required this.onDelete,
    required this.imagedetail,
    required this.onPressed,
    required this.image,
    required this.nama,
    required this.nim,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: 0.15,
      showAllActionsThreshold: 0.5,
      secondaryActions: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: IconSlideAction(
              color: Colors.lightBlue,
              iconWidget: Container(
                  margin: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/pencil.svg",
                        height: 24,
                        color: Colors.white,
                      ),
                      Text(
                        "Update",
                        style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white),
                      )
                    ],
                  )),
              onTap: onUpdate,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: onDelete,
            ),
          ),
        ),
      ],
      actionPane: SlidableDrawerActionPane(),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.20),
                spreadRadius: 3,
                blurRadius: 8,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              highlightColor: Colors.greenAccent.withOpacity(0.20),
              splashColor: Colors.greenAccent.withOpacity(0.35),
              onTap: onPressed,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                content: Container(
                                    height: 250,
                                    child: Image.network(
                                      imagedetail,fit: BoxFit.cover,
                                    )));
                          });
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama,
                          style: GoogleFonts.montserrat(
                              color: Colors.greenAccent[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          nim,
                          style: GoogleFonts.montserrat(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 19),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
