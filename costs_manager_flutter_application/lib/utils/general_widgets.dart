// ignore_for_file: prefer_const_constructors

import 'package:costs_manager_flutter_application/screens/edit_cost_page.dart';
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
    required this.leading,
    required this.trailing,
    required this.documentId,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String leading;
  final String trailing;
  final String documentId;

  IconData chooseLeadingIcon(String leading) {
    if (leading == "Product") {
      return Icons.shopping_cart;
    }
    if (leading == "Restaurant") {
      return Icons.restaurant;
    }
    if (leading == "Home") {
      return Icons.home;
    }
    if (leading == "Gaming") {
      return Icons.sports_esports;
    }
    return Icons.question_mark;
  }

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
                  onPressed: (context) => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCostPage(
                          title: title,
                          subtitle: subtitle,
                          leading: leading,
                          trailing: trailing,
                          documentId: documentId,
                        ),
                      ),
                    )
                  },
                  icon: Icons.edit_rounded,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
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
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
                leading: Icon(
                  chooseLeadingIcon(leading),
                  size: 40,
                ),
                trailing: Text(
                  trailing,
                  style: GoogleFonts.roboto(fontSize: 22),
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
