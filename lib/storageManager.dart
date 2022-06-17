import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:intl/intl.dart';

class Storage {
  static DateTime today = DateTime.now();
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  String actualDate = dateFormat.format(today);

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final user = FirebaseAuth.instance.currentUser!;
  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);

    try {
      await storage
          .ref(user.email! + '/' + actualDate + '/$fileName')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
