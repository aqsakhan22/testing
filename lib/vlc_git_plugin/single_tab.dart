import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:path_provider/path_provider.dart';


import 'video_data.dart';
import 'vlc_player_with_controls.dart';

class SingleTab extends StatefulWidget {
  final String videoURL;
  const SingleTab({Key? key,required this.videoURL}) : super(key: key);
  @override
  _SingleTabState createState() => _SingleTabState();
}

class _SingleTabState extends State<SingleTab> {
  late VlcPlayerController _controller;
  final _key = GlobalKey<VlcPlayerWithControlsState>();

  //
  late List<VideoData> listVideos;
  late int selectedVideoIndex;

  void fillVideos() {
    listVideos = <VideoData>[];
    //
    listVideos.add(VideoData(
      name: 'Network Video 1',
      path:
      '${widget.videoURL}',
      type: VideoType.network,
    ));

  }

  @override
  void initState() {
    super.initState();

    //
    fillVideos();
    selectedVideoIndex = 0;
    //
    var initVideo = listVideos[selectedVideoIndex];
    print("initVideo.type ${initVideo.type}");
    switch (initVideo.type) {

      case VideoType.network:_controller = VlcPlayerController.network(
          initVideo.path,
          hwAcc: HwAcc.full,
          options: VlcPlayerOptions(
            advanced: VlcAdvancedOptions([
              VlcAdvancedOptions.networkCaching(2000),
            ]),
            subtitle: VlcSubtitleOptions([
              VlcSubtitleOptions.boldStyle(true),
              VlcSubtitleOptions.fontSize(30),
              VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
              VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
              // works only on externally added subtitles
              VlcSubtitleOptions.color(VlcSubtitleColor.navy),
            ]),
            http: VlcHttpOptions([
              VlcHttpOptions.httpReconnect(true),
            ]),
            rtp: VlcRtpOptions([
              VlcRtpOptions.rtpOverRtsp(true),
            ]),
          ),
        );
        break;
      case VideoType.recorded:
        break;
    }
    _controller.addOnInitListener(() async {
      await _controller.startRendererScanning();
    });
    _controller.addOnRendererEventListener((type, id, name) {
      print('OnRendererEventListener $type $id $name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 400,
          child: VlcPlayerWithControls(
            key: _key,
            controller: _controller,
            onStopRecording: (recordPath) {
              setState(() {

              });


            },
          ),
        ),

      ],
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _controller.stopRecording();
    await _controller.stopRendererScanning();
    await _controller.dispose();
  }
}