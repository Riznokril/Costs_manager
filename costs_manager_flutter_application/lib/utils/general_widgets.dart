// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralTextField extends StatelessWidget {
  const GeneralTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.isPassword,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          obscureText: isPassword,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}

class CostsCard extends StatelessWidget {
  const CostsCard({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey[300],
          ),
          child: Slidable(
            startActionPane: ActionPane(
              motion: DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => {},
                  icon: Icons.phone,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  backgroundColor: Colors.deepOrange,
                ),
                SlidableAction(
                  onPressed: (context) => {},
                  icon: Icons.message,
                  backgroundColor: Colors.deepPurple,
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => {},
                  icon: Icons.delete,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[300]),
              child: ListTile(
                title: Text(
                  title,
                  style: GoogleFonts.roboto(fontSize: 22),
                ),
                subtitle: Text(
                  subtitle,
                  style: GoogleFonts.roboto(fontSize: 22),
                ),
                leading: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
