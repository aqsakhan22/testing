//
// import 'dart:io';
// import 'dart:typed_data';
//
//
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:signature/signature.dart';
//
// class SignatureEx extends StatefulWidget {
//   const SignatureEx({Key? key}) : super(key: key);
//
//   @override
//   State<SignatureEx> createState() => _SignatureExState();
// }
//
// class _SignatureExState extends State<SignatureEx> {
//   File? theChosenImg;
//   Uint8List? uploadedImage;
//   final SignatureController _controller = SignatureController(
//     penStrokeWidth: 5,
//     penColor: Colors.black,
//     exportBackgroundColor: Colors.white,
//   );
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Signature in Flutter"),
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: Colors.orangeAccent,
//             child: Signature(
//               controller: _controller,
//               width: 300,
//               height: 150,
//               backgroundColor: Colors.white,
//             ),
//
//           ),
//           ElevatedButton(onPressed: () async{
//
//
//             print("${_controller.toPngBytes()}");
//             _controller.toPngBytes().then((value) async{
//               Uint8List imageInUnit8List=value!;
//               final tempDir = await getTemporaryDirectory();
//               File file = await File('${tempDir.path}/image.png').create();
//               file.writeAsBytesSync(imageInUnit8List);
//               print("FILE IS ${file}");
//             });
//            // store unit8List image here ;
//
//
//
//
//           }, child: Text("image")),
//           ElevatedButton(onPressed: (){
//
//             _controller.clear();
//
//           }, child: Text("Clear"))
//         ],
//       )
//     );
//   }
// }
