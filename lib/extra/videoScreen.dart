// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// class VideoScreen extends StatefulWidget {
//   final String name;
//   final String mediaUrl;
//   const VideoScreen({Key? key, required this.name, required this.mediaUrl}) : super(key: key);
//
//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   late BetterPlayerController _betterplayercontroller;
//   GlobalKey _betterplayerkey=GlobalKey();
//   @override
//   void initState() {
//     // TODO: implement initState
//     BetterPlayerConfiguration betterplayerConfiguration = BetterPlayerConfiguration(
//       aspectRatio: 16/9,
//       fit: BoxFit.contain
//
//     );
//     BetterPlayerDataSource dataSource=BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       widget.mediaUrl
//     );
//
//     _betterplayercontroller=BetterPlayerController(betterplayerConfiguration);
//     _betterplayercontroller.setupDataSource(dataSource);
//     _betterplayercontroller.setBetterPlayerGlobalKey(_betterplayerkey);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("video screen"),),
//       body: Column(
//         children: [
//           SizedBox(height: 8,),
//           Expanded(child: AspectRatio(
//             aspectRatio: 16/9,
//             child: BetterPlayer(
//               key: _betterplayerkey,
//                 controller: _betterplayercontroller ,),
//
//           ))
//
//         ],
//       ),
//
//     );
//   }
// }
