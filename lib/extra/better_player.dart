// //https://www.youtube.com/watch?v=qkkO4Fzkd-Q&t=8s
// //https://www.google.com/search?q=how+to+get+thumbnai+from+video+in+flutter&rlz=1C5CHFA_enPK918PK918&oq=how+to+get+thumbnai+from+video+in+flutter&aqs=chrome..69i57j0i271l3j69i60l3j69i65.7620j0j7&sourceid=chrome&ie=UTF-8#fpstate=ive&vld=cid:965f226c,vid:46jWmzXLabQ
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:novus_guard_pro_flutter/extra/videoScreen.dart';
// // import 'package:video_thumbnail/video_thumbnail.dart';
// import 'dart:io' as Io;
// class BetterPlayer extends StatefulWidget {
//   const BetterPlayer({Key? key}) : super(key: key);
//
//   @override
//   State<BetterPlayer> createState() => _BetterPlayerState();
// }
//
// class _BetterPlayerState extends State<BetterPlayer> {
//    late File file;
//   var videoList=[
//     {
//       'name':'Big Buck Bunny',
//       'media_url':'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       'thumb_url':'https://i.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg'
//
//     },
//     {
//       'name':'Blender Open Movie',
//       'media_url':'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
//       'thumb_url':'https://i.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg'
//
//     },
//     {
//       'name':'ForBiggerBlazes',
//       'media_url':'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
//       'thumb_url':'https://i.ytimg.com/vi/aqz-KE-bpKQ/maxresdefault.jpg'
//
//     },
//
//   ];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     //  videothumbnai();
//     super.initState();
//
//
//   }
// //   void videothumbnai() async{
// //     print("THUMBNAI IS");
// //     final uint8list = await VideoThumbnail.thumbnailFile(
// //       video: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
// //       imageFormat: ImageFormat.JPEG,
// //
// //       maxWidth: 60, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
// //       quality: 25,
// //     );
// //     print("uint8list ${uint8list}");
// //
// //     setState(() {
// //                           file = File(uint8list!);
// //     });
// // print("file is ${file} ${file.runtimeType}");
//
//
//
//
//   // }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Multiple Videos"),
//       ),
//       body: ListView(
//         children: videoList.map((e) {
//            return Container(
//              height: 250,
//              child: GestureDetector(
//                onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(
//                    name: e['name']!,
//                      mediaUrl:e['media_url']!
//                  )
//                  ));
//                },
//                child: Container(
//
//                  child: Stack(
//                    children: [
//                      Image.network("${e['thumb_url']}"),
//
//                    // Container(
//                    //   color: Colors.red,
//                    //   width: MediaQuery.of(context).size.width * 1,
//                    //
//                    //
//                    //   child:   Image.file(file,fit: BoxFit.cover,)             ,
//                    // )                       ,
//                    //
//                      Container(
//
//                        alignment: Alignment.center,
//                        child: CircleAvatar(
//                          radius: 30,
//                            backgroundColor: Colors.greenAccent,
//                            // color: Colors.red,
//
//                              child: Icon(Icons.play_arrow,size: 60,color: Colors.black,)),
//                      )
//
//
//                    ],
//                  ),
//                ),
//
//              ),
//            );
//
//         }).toList(),
//       )
//     );
//   }
// }
