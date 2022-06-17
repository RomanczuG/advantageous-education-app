// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../storageManager.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final Storage storage = Storage();

  Future uploadImage() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No file was picked')));

      return;
    }
    storage.uploadFile(image.path, image.name).then((value) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Image was uploaded"),
          );
        }));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(24.0),
            //         color: Colors.white,
            //         boxShadow: [
            //           BoxShadow(
            //               color: Colors.grey.withOpacity(0.5),
            //               spreadRadius: 5,
            //               blurRadius: 7,
            //               offset: Offset(0, 3))
            //         ]),
            //     child: Padding(
            //       padding: const EdgeInsets.all(20.0),
            //       child: Text(
            //         'Welcome to the upload tool!',
            //         style: const TextStyle(
            //             fontSize: 26, fontWeight: FontWeight.bold),
            //       ),
            //       // BREAK
            //     )),
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Please take a picture of your scantron and submit it to our database. Please do not destroy your scantron if the algorithm could not read the answer.',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  // BREAK
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                child: Align(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/scan_example.png',
                            width: MediaQuery.of(context).size.width / 4 * 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Make it look like this.',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      // BREAK
                    ),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    primary: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  onPressed: uploadImage,
                  child: const Center(
                      child: Text(
                    "Take a Picture",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
                )),
          ],
        ),
      ),
    );
  }
}
