import 'package:flutter/material.dart';
import 'multiple_tab.dart';
import 'single_tab.dart';



class Videoplayer_Ex extends StatefulWidget {
  @override
  _Videoplayer_ExState createState() => _Videoplayer_ExState();
}

class _Videoplayer_ExState extends State<Videoplayer_Ex> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Vlc Player Example'),

        ),
        body:  SingleTab(
          videoURL: "http://samples.mplayerhq.hu/MPEG-4/embedded_subs/1Video_2Audio_2SUBs_timed_text_streams_.mp4",

        ),
      ),
    );
  }
}