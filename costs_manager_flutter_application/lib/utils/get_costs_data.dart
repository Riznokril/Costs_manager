import 'package:costs_manager_flutter_application/utils/general_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              title: data['place'], subtitle: data['cost'].toString());
        }
        return CostsCard(title: "Loading...", subtitle: "Loading...");
      },
    );
  }
}
