import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Storge {
  static getData({
    required String collection,
    required VoidCallback onSuccess,
    required List myList,
  }) {
    return FirebaseFirestore.instance.collection(collection).snapshots().listen(
      (event) {
        myList.clear();
        event.docs.forEach((element) {
          myList.add(element.data());
        });
        onSuccess();
      },
    );
  }

  static Future<void> updata_data({
    required String Collection,
    required String doc,
    required Map<String, dynamic> data,
  }) {
    return FirebaseFirestore.instance
        .collection(Collection)
        .doc(doc)
        .update(data);
  }
}
