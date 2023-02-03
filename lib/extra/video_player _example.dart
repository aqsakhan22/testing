//
// //https://www.youtube.com/watch?v=dXxe7E6WPUM
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// class VideoPlayerEx extends StatefulWidget {
//   const VideoPlayerEx({Key? key}) : super(key: key);
//
//   @override
//   State<VideoPlayerEx> createState() => _VideoPlayerExState();
// }
//
// class _VideoPlayerExState extends State<VideoPlayerEx> {
//   PageController pageController = PageController();
//   late VideoPlayerController _controller;
//   int pageChanged=0;
//
//   @override
//
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     _controller = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
//
//     _controller.addListener(() {
//       setState(() {});
//     });
//     _controller.setLooping(true);
//
//
//     _controller.initialize().then((_) => setState(() {
//
//     }));
//     // _controller.play();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller.value.isPlaying
//                 ? _controller.pause()
//                 : _controller.play();
//           });
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//
//       ),
//       appBar: AppBar(
//         title: Text("Video"),
//       ),
//       body:SingleChildScrollView(
//         child:  Container(
//           height: MediaQuery.of(context).size.height  * 1,
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height  * 0.5,
//                 color: Colors.blueGrey,
//                 child: PageView(
//                     physics:NeverScrollableScrollPhysics(),
//                     pageSnapping: true,
//                     controller: pageController,
//                     onPageChanged: (index) {
//                       setState(() {
//                         pageChanged = index;
//                       });
//                       print(pageChanged);
//                     },
//
//                     children: [1,2,3,4].map((e){
//                       return    Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween ,
//                         children: [
//                           IconButton(icon: Icon(Icons.arrow_back_ios,size: 32,), onPressed: (){
//                             pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
//                           }),
//
//                           Expanded(child: Container(
//                             height: 120,
//                             width: 200,
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             color:Colors.pink ,
//                             child: Center(
//                                 child: Text("Video ${e}",style: TextStyle(color: Colors.white),)),
//                           ),),
//                           SizedBox(width: 10,),
//                           Expanded(child: Container(
//                             height: 120,
//                             width: 200,
//                             padding: EdgeInsets.symmetric(horizontal: 10.0),
//                             color:Colors.orange ,
//                             child: Center(
//                                 child: Text("Video ${e}",style: TextStyle(color: Colors.white),)),
//                           ),),
//                           IconButton(icon: Icon(Icons.arrow_forward_ios,size: 32), onPressed: (){
//                             pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
//
//                           }),
//                         ],
//                       );
//                     } ).toList()
//
//                 ),
//               ),
//
//               SizedBox(height: 10,),
//               Container(
//                 height: 100,
//                 child:ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 10,
//                     itemBuilder: (BuildContext context,int index){
//                       return Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                         color: Colors.orangeAccent,
//                         width: MediaQuery.of(context).size.width * 0.5,
//                         child: Container(
//                           height: 10,
//                           color: Colors.pink,
//                           child: Text("index ${index}"),
//                         ),
//
//                       );
//                     }),
//               ),
//               SizedBox(height: 10,),
//               Expanded(child:    AspectRatio(aspectRatio: _controller.value.aspectRatio,
//                 child:Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: <Widget>[
//                     VideoPlayer(_controller,
//                     ),
//                     // _ControlsOverlay(controller: _controller),
//                     VideoProgressIndicator(_controller, allowScrubbing: true),
//                   ],
//                 ),
//
//               )),
//
//
//
//             ],
//           ),
//         ),
//       )
//
//     );
//   }
// }
