// import 'dart:io';

// import 'package:ai_exam_analysis/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';

// import 'storageManager.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final Storage storage = Storage();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cloud Storage'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//               onPressed: () async {
//                 final ImagePicker _picker = ImagePicker();
//                 final image =
//                     await _picker.pickImage(source: ImageSource.camera);

//                 if (image == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('No file was picked')));
//                   return;
//                 }

//                 // final file = File();

//                 storage
//                     .uploadFile(image.path, image.name)
//                     .then((value) => print('Done'));
//               },
//               child: Text('Upload File'))
//         ],
//       ),
//     );
//   }
// }
