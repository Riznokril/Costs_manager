// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:costs_manager_flutter_application/utils/general_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewCostPage extends StatefulWidget {
  AddNewCostPage({Key? key}) : super(key: key);

  @override
  State<AddNewCostPage> createState() => _AddNewCostPageState();
}

class _AddNewCostPageState extends State<AddNewCostPage> {
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
  DateTime dateTime = DateTime(2000, 1, 1, 0, 0);

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

  // add new cost
  Future addNewCost() async {
    await FirebaseFirestore.instance.collection("costs").add({
      'category': _categoryController.text.trim(),
      'cost': _costController.text.trim(),
      'place': _placeController.text.trim(),
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
          addNewCost();
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
                  "Add new cost",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 56,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  "Put some datails please",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 12),
                GeneralTextField(
                  controller: _categoryController,
                  hintText: "Category",
                  isPassword: false,
                ),
                SizedBox(height: 8),
                GeneralTextField(
                  controller: _costController,
                  hintText: "Cost",
                  isPassword: false,
                ),
                SizedBox(height: 8),
                GeneralTextField(
                  controller: _placeController,
                  hintText: "Place",
                  isPassword: false,
                ),
                SizedBox(height: 8),
                DateAndTimeTextField(
                  controller: _dateAndTimeController,
                  hintText:
                      '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}',
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

class DateAndTimeTextField extends StatelessWidget {
  const DateAndTimeTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final VoidCallback onTap;

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
          readOnly: true,
          onTap: onTap,
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
