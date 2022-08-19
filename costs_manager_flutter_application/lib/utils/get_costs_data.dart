// ignore_for_file: prefer_const_constructors

import 'package:costs_manager_flutter_application/utils/general_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GetCostData extends StatelessWidget {
  final String documentId;

  GetCostData({required this.documentId});

  @override
  Widget build(BuildContext context) {
    // get the collection
    CollectionReference costs = FirebaseFirestore.instance.collection('costs');

    return FutureBuilder<DocumentSnapshot>(
      future: costs.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return CostsCard(
            title: data['place'],
            subtitle:
                DateFormat('dd-MM-yyyy KK:mm').format(data['time'].toDate()),
            leading: data['category'],
            trailing: "${data['cost'].toString()} грн",
            documentId: documentId,
          );
        }
        return CostsCard(
          title: "Loading...",
          subtitle: "Loading...",
          leading: "Loading...",
          trailing: "Loading...",
          documentId: "",
        );
      },
    );
  }
}
