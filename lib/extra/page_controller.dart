// import 'package:flutter/material.dart';
// // import 'package:video_player/video_player.dart';
// //https://medium.flutterdevs.com/video-player-in-flutter-22202be72d6e
// //https://blog.logrocket.com/flutter-video-player/
// //https://pub.dev/packages/flick_video_player
// //https://pub.dev/packages/youtube_api
// //https://stackoverflow.com/questions/72292232/how-to-play-multiple-videos-with-player-video-package
// //https://pub.dev/packages/video_player
// //https://pub.dev/packages/appinio_video_player
// //https://www.fluttercampus.com/guide/269/play-video-from-assets-url-flutter/
// //https://morioh.com/p/43a30d02f567
// //https://www.fluttercampus.com/guide/268/play-video-flutter-example/
// //https://www.google.com/search?q=Video+player+in+flutter&rlz=1C5CHFA_enPK918PK918&sxsrf=ALiCzsZnXhkSR0U4HigeQIr2Wjg16CWJoQ%3A1670933936329&ei=sG2YY-6yE-aukdUPscasqAw&ved=0ahUKEwjuyt79yfb7AhVmV6QEHTEjC8UQ4dUDCA8&uact=5&oq=Video+player+in+flutter&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQAzIFCAAQgAQyBQgAEIAEMgUIABCABDIGCAAQFhAeMgYIABAWEB4yBggAEBYQHjIGCAAQFhAeMgYIABAWEB4yBggAEBYQHjIGCAAQFhAeOgoIABBHENYEELADOgQIIxAnOgQIABBDOgUIABCRAjoHCAAQsQMQQzoLCAAQgAQQsQMQgwE6EAgAEIAEEIcCELEDEIMBEBQ6CggAELEDEIMBEEM6CAgAEIAEELEDOgoIABCABBCHAhAUOggIABAWEB4QD0oECEEYAEoECEYYAFD2Cli1KmC4LWgBcAF4AIAByQKIAbQokgEIMC45LjEyLjKYAQCgAQHIAQjAAQE&sclient=gws-wiz-serp#fpstate=ive&vld=cid:753dac48,vid:P3l9o31AoeQ
// //https://www.geeksforgeeks.org/flutter-handling-videos/
// //https://pub.dev/packages/appinio_video_player
//
// class PageControllerEx extends StatefulWidget {
//   const PageControllerEx({Key? key}) : super(key: key);
//
//   @override
//   State<PageControllerEx> createState() => _PageControllerExState();
// }
//
// class _PageControllerExState extends State<PageControllerEx> {
//   PageController pageController = PageController();
//   late VideoPlayerController controller;
//
//   int pageChanged=0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadVideoPlayerAsset();
//   }
//   loadVideoPlayerAsset(){
//     controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
//     controller.addListener(() {
//       setState(() {});
//     });
//     controller.initialize().then((value){
//       setState(() {});
//     });
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Controller"),
//         actions: [
//           IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
//             pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
//           }),
//           IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
//             pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
//
//           }),
//
//
//         ],
//       ),
//       body: PageView(
//         pageSnapping: true,
//         controller: pageController,
//         onPageChanged: (index) {
//           setState(() {
//             pageChanged = index;
//           });
//           print(pageChanged);
//         },
//         children: [
//           Container(
//
//             color: Colors.indigo,
//             child: Container(
//
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,), onPressed: (){
//                     pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
//                   }),
//
//
//                   // Text("hello",style: TextStyle(color: Colors.white,fontSize: 32),),
//                   // Text("world",style: TextStyle(color: Colors.white,fontSize: 32),),
//                   IconButton(icon: Icon(Icons.arrow_forward_ios,color: Colors.white,), onPressed: (){
//                     pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
//
//                   }),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             // color: Colors.red,
//             child:   Column(
//               children: [
//                 AspectRatio(
//                   aspectRatio: controller.value.aspectRatio,
//                   child: VideoPlayer(controller),
//                 ),
//                 // Container( //duration of video
//                 //   child: Text("Total Duration: " + controller.value.duration.toString()),
//                 // ),
//                 Container(
//                     child: VideoProgressIndicator(
//                         controller,
//                         allowScrubbing: true,
//                         colors:VideoProgressColors(
//                           backgroundColor: Colors.redAccent,
//                           playedColor: Colors.green,
//                           bufferedColor: Colors.purple,
//                         )
//                     )
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       IconButton(
//                           onPressed: (){
//                             if(controller.value.isPlaying){
//                               controller.pause();
//                             }else{
//                               controller.play();
//                             }
//
//                             setState(() {
//
//                             });
//                           },
//                           icon:Icon(controller.value.isPlaying?Icons.pause:Icons.play_arrow)
//                       ),
//
//                       IconButton(
//                           onPressed: (){
//                             controller.seekTo(Duration(seconds: 0));
//
//                             setState(() {
//
//                             });
//                           },
//                           icon:Icon(Icons.stop)
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             color: Colors.brown,
//           ),
//         ],
//       ),
//     );
//   }
// }
