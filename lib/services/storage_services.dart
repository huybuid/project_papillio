import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageServices extends ChangeNotifier {
  StorageServices();
  static Future<String> getImageURL(BuildContext context, String img) async {
    return await FirebaseStorage.instance.ref().child(img).getDownloadURL();
  }


}