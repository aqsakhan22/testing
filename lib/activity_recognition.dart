import 'dart:async';
import 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class ActivityRecognitionEx extends StatefulWidget {
  @override
  _ActivityRecognitionExState createState() => new _ActivityRecognitionExState();
}

class _ActivityRecognitionExState extends State<ActivityRecognitionEx> {
  StreamSubscription<ActivityEvent>? activityStreamSubscription;
  List<ActivityEvent> _events = [];
  ActivityRecognition activityRecognition = ActivityRecognition();

  @override
  void initState() {
    super.initState();
    _init();
    _events.add(ActivityEvent.unknown());
  }
  @override
  void dispose() {
    activityStreamSubscription?.cancel();
    super.dispose();
  }

  void _init() async {
    /// Android requires explicitly asking permission
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.isGranted) {
        print("permission is granted");
        _startTracking();

      }
    }

    /// iOS does not
    else {
      _startTracking();
    }
  }

  void _startTracking() {
    print("start tracking");


     activityStreamSubscription = activityRecognition.activityStream(runForegroundService: true).listen(onData, onError: onError);
         // .activityStream(runForegroundService: true)
         // .listen(onData, onError: onError);

  }
  void onError(Object error) {
    print('ERROR - $error');
  }

  void onData(ActivityEvent activityEvent) {
    print(activityEvent.toString());
    setState(() {
      _events.add(activityEvent);
    });
  }
  Icon _activityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.WALKING:
        return Icon(Icons.directions_walk);
      case ActivityType.IN_VEHICLE:
        return Icon(Icons.car_rental);
      case ActivityType.ON_BICYCLE:
        return Icon(Icons.pedal_bike);
      case ActivityType.ON_FOOT:
        return Icon(Icons.directions_walk);
      case ActivityType.RUNNING:
        return Icon(Icons.run_circle);
      case ActivityType.STILL:
        return Icon(Icons.cancel_outlined);
      case ActivityType.TILTING:
        return Icon(Icons.redo);
      default:
        return Icon(Icons.device_unknown);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:  Scaffold(
        appBar:  AppBar(
          title:  Text('Activity Recognition Demo'),
        ),
        body:  Center(
            child:  ListView.builder(
                itemCount: _events.length,
                reverse: true,
                itemBuilder: (BuildContext context, int idx) {
                  final activity = _events[idx];
                  return ListTile(

                    leading: _activityIcon(activity.type),
                    title: Text(
                        '${activity.type.toString().split('.').last} (${activity.confidence}%)'),
                    trailing: Text(activity.timeStamp
                        .toString()
                        .split(' ')
                        .last
                        .split('.')
                        .first),
                  );
                })),
      ),
    );
  }
}