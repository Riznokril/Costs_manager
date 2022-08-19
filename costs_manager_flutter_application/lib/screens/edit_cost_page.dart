// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costs_manager_flutter_application/screens/add_new_cost_page.dart';
import 'package:costs_manager_flutter_application/utils/general_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditCostPage extends StatefulWidget {
  EditCostPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.trailing,
    required this.documentId,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String leading;
  final String trailing;
  final String documentId;

  @override
  State<EditCostPage> createState() => _EditCostPageState();
}

class _EditCostPageState extends State<EditCostPage> {
  // text controllers
  final _categoryController = TextEditingController();
  final _costController = TextEditingController();
  final _placeController = TextEditingController();
  final _dateAndTimeController = TextEditingController();

  @override
  void dispose() {
    _categoryController.dispose();
    _costController.dispose();
    _placeController.dispose();
    _dateAndTimeController.dispose();
    super.dispose();
  }

  // create date and time
  late DateTime dateTime =
      DateFormat("dd-MM-yyyy hh:mm").parse(widget.subtitle);

  // pick date
  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

  // pick time
  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );

  // pick date and time
  Future pickDateAndTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() => this.dateTime = dateTime);
  }

  // update cost
  Future updateCost() async {
    // declaring category variable and checking if TextField was changed
    String category;
    if (_categoryController.text.trim() == "") {
      category = widget.leading;
    } else {
      category = _categoryController.text.trim();
    }
    // declaring cost variable and checking if TextField was changed
    double cost;
    if (_costController.text.trim() == "") {
      cost = double.parse(
          widget.trailing.substring(0, widget.trailing.indexOf(" ")));
    } else {
      cost = double.parse(_costController.text.trim());
    }
    // declaring place variable and checking if TextField was changed
    String place;
    if (_placeController.text.trim() == "") {
      place = widget.title;
    } else {
      place = _placeController.text.trim();
    }

    await FirebaseFirestore.instance
        .collection("costs")
        .doc(widget.documentId)
        .update({
      'category': category,
      'cost': cost,
      'place': place,
      'time': dateTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          updateCost();
          Navigator.pop(context);
        }),
        child: Icon(Icons.check),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Edit this cost",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 56,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  "Check and edit please",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                // category
                SizedBox(height: 12),
                GeneralTextField(
                  controller: _categoryController,
                  hintText: widget.leading,
                  isPassword: false,
                ),
                SizedBox(height: 8),

                // cost
                GeneralTextField(
                  controller: _costController,
                  hintText: widget.trailing,
                  isPassword: false,
                ),
                SizedBox(height: 8),

                // place
                GeneralTextField(
                  controller: _placeController,
                  hintText: widget.title,
                  isPassword: false,
                ),
                SizedBox(height: 8),
                // time
                DateAndTimeTextField(
                  controller: _dateAndTimeController,
                  hintText: DateFormat("dd-MM-yyyy hh:mm").format(dateTime),
                  onTap: pickDateAndTime,
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
