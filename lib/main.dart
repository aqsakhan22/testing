import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:testing/SpotifyProvider.dart';
import 'package:testing/UserPreferences.dart';
import 'package:testing/activity_recognition.dart';
import 'package:testing/provider_utility.dart';
import 'package:testing/spotify_Ex.dart';
import 'package:testing/video_player_Ex.dart';
import 'package:testing/vlc_git_plugin/main.dart';
import 'package:uni_links/uni_links.dart';
//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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializePreferences();
  askPermission();

  // hiveBox = await Hive.openBox(hiveBoxName);

  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;
  Uri? _latestUri;
  bool _initialURILinkHandled = false;

  StreamSubscription? sub;
  Future<void> _initURIHandler() async {
    // 1
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      // 2
      Fluttertoast.showToast(
          msg: "Invoked _initURIHandler",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white
      );
      try {
        // 3
        final initialURI = await getInitialUri();
        // 4
        if (initialURI != null) {
          debugPrint("Initial URI received $initialURI");
          if (!mounted) {
            return;
          }
          setState(() {
            _initialURI = initialURI;
          });
        } else {
          debugPrint("Null Initial URI received");
        }
      } on PlatformException { // 5
        debugPrint("Failed to receive initial uri");
      } on FormatException catch (err) { // 6
        if (!mounted) {
          return;
        }
        debugPrint('Malformed Initial URI received');
        setState(() => _err = err);
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    // _handleIncomingLinks();
    // _handleInitialUri();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _handleIncomingLinks();
    // });

    super.initState();

  }

  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  void _handleIncomingLinks() {
    //   if (!kIsWeb) {
    // It will handle app links while the app is already started - be it in
    // the foreground or in the background.
    sub = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      print('got uri: $uri');
      setState(() {
        _latestUri = uri;
        _err = null;
      });
      String token = uri?.queryParameters['token'] ?? '';
      showToast(token);
      UserPreferences.spotifyToken = token;
      spotifyProvider.initSpotify();
    }, onError: (Object err) {
      if (!mounted) return;
      print('got err: $err');
      setState(() {
        _latestUri = null;
        if (err is FormatException) {
          _err = err;
        } else {
          _err = null;
        }
      });
    });
    //  }
  }

  bool _initialUriIsHandled = false;
  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      // _showSnackBar('_handleInitialUri called');
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
        }
        if (!mounted) return;
        setState(() => _initialURI = uri);
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => SpotifyProvider()),


      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home:Home() ,
      ),

    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("hello world"),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>Spotify() ));
            }, child: Text("check spotify")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>Video_player_Ex() ));
            }, child: Text("Video_player_Ex")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>Videoplayer_Ex() ));
            }, child: Text("Videoplayer_Ex")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>ActivityRecognitionEx() ));
            }, child: Text("Activity")),

          ],
        )
      ),
    );
  }
}

askPermission() async{
  print("Ask permission");


  Permission.location.status.isDenied.then((value) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.contacts,
      Permission.sms,
      Permission.phone,
      Permission.microphone,
      Permission.camera,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.mediaLibrary,
      Permission.audio ,
      Permission.activityRecognition,
      Permission.locationWhenInUse,


    ].request();
    print(statuses[Permission.location]);
    print(statuses[Permission.contacts]);
    print(statuses[Permission.sms]);
    print(statuses[Permission.phone]);
    print(statuses[Permission.microphone]);
    print(statuses[Permission.camera]);
    print(statuses[Permission.bluetooth]);
    print(statuses[Permission.bluetoothConnect]);
    print(statuses[Permission.bluetoothScan]);
    print(statuses[Permission.audio]);
    //Navigator.pop(context);
  });
  // if (await Permission.camera.isPermanentlyDenied || await Permission.camera.isDenied ) {
  //
  //   print("Denied settings");
  //
  //   // The user opted to never again see the permission request dialog for this
  //   // app. The only way to change the permission's status now is to let the
  //   // user manually enable it in the system settings.
  //   AppSettings.openAppSettings();
  // }
}











