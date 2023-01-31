import 'dart:io';
import 'dart:typed_data';
import 'package:spotify_sdk/models/player_options.dart' as player_options;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:spotify_sdk/models/image_uri.dart';

import 'package:spotify_sdk/models/player_restrictions.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/track.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:testing/Constants.dart';
import 'package:testing/UserPreferences.dart';
import 'package:testing/provider_utility.dart';


// Stream<PlayerState>? playerStateStream;
String callBackUrlSpotify = 'spotify-ios-quick-start://spotify-login-callback';
class SpotifyProvider extends ChangeNotifier {
  bool showPlayer = false;
  bool authenticationTried = false;
  ImageUri? currentTrackImageUri;
  late Widget oldImage;
  PlayerState playerState = PlayerState(
    null,
    1,
    0,
    player_options.PlayerOptions(player_options.RepeatMode.off, isShuffling: false),
    PlayerRestrictions(canSkipNext: true, canSkipPrevious: true, canRepeatTrack: true, canRepeatContext: true, canToggleShuffle: true, canSeek: true),
    isPaused: false,
  );
  Track? track;
  initSpotify() async{
    try{
      bool result = false;
      if(Platform.isAndroid || UserPreferences.spotifyToken.isEmpty){
        result = await SpotifySdk.connectToSpotifyRemote(

          clientId: '00062cf894414e29b5158c040fbc96b5',
          // redirectUrl: 'https://ansariacademy.com/Run-With-KT/spotify.php'
          redirectUrl: callBackUrlSpotify,
        );
      }
      else{

        //00062cf894414e29b5158c040fbc96b5
        result = await SpotifySdk.connectToSpotifyRemote(
          clientId: '00062cf894414e29b5158c040fbc96b5',
          accessToken: UserPreferences.spotifyToken,
          //  redirectUrl: 'https://ansariacademy.com/Run-With-KT/spotify.php'
          redirectUrl: callBackUrlSpotify,
        );
      }

      if(!result && !authenticationTried){
        getAccessToken().then((value) {
          print(value);
          authenticationTried = true;
          initSpotify();
        });
      } else if(result){
        showPlayer = true;
        hiveBox.put(Constants.keyShowSpotifyPlayer, true);
        refreshStream();
      } else{
        print('Spotify could not be initiated');
      }
    } on PlatformException catch (e) {
      //  initSpotify();
      print('Spotify could not be initiated');
      print(e);
    } on MissingPluginException {
      print('error spotify');
    }
  }

  refreshStream(){
    print('subscribing spotify stream...');
    // playerStateStream = SpotifySdk.subscribePlayerState();
    notifyListeners();
  }

  Future<String> getAccessToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: '00062cf894414e29b5158c040fbc96b5',
          //   redirectUrl: 'https://ansariacademy.com/Run-With-KT/spotify.php',
          //    redirectUrl: 'https://evam.handabots.com/',
          redirectUrl: callBackUrlSpotify,
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public, '
              'user-read-currently-playing');
      return authenticationToken;
    } on PlatformException catch (e) {
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      return Future.error('not implemented');
    }
  }

  Future<void> disconnect() async {
    try {
      var result = await SpotifySdk.disconnect();
      if(result){
        showPlayer = false;
        hiveBox.put(Constants.keyShowSpotifyPlayer, true);
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print(e);
    } on MissingPluginException {
      print('error spotify');
    }
  }

  /*Widget _buildPlayerStateWidget() {
    return Visibility(
      visible: showPlayer,
        child: StreamBuilder<PlayerState>(
      stream: playerStateStream,
      builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
        var track = snapshot.data?.track;
        var playerState = snapshot.data;
        // String totalTime = Calculations.timeFromSeconds((track!.duration/60).toInt());

        if (playerState == null || track == null) {
          // initSpotify();
          return Center(
            child: Container(child: Text('Player not loaded. select a playlist from spotify app'),),
          );
        }

        return Stack(
          children: [
            currentTrackImageUri==track.imageUri ?
            oldImage :
            spotifyImageWidget(track.imageUri),
            Padding(padding: EdgeInsets.only(top: 10),
              child:  Column(
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(width: 20,),
                      RunTag(name: track.name),
                      //  Text('${track.name}', overflow: TextOverflow.ellipsis,),
                      Spacer(),
                      //  Text(totalTime),
                      FutureBuilder(
                        builder: (ctx, snapshot) {
                          // Displaying LoadingSpinner to indicate waiting state
                          if (!snapshot.hasData) {
                            return Text('');
                          }
                          return(RunTag(name: snapshot.data.toString()));
                        },
                        future: Calculations.timeFromSecondsFuture(track.duration~/1000),
                      ),
                      SizedBox(width: 20,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RoundIconBtn(iconData: Icons.skip_previous, onClicked: skipPrevious,),
                      *//*IconButton(
                     //  width: 50,
                     icon: Icon(Icons.skip_previous),
                     onPressed: skipPrevious,
                   ),*//*
                      playerState.isPaused
                          ? RoundIconBtn(iconData: Icons.play_arrow, onClicked: resume,)
                          : RoundIconBtn(iconData: Icons.pause, onClicked: pause,),
                      RoundIconBtn(iconData: Icons.skip_next, onClicked: skipNext,),
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            )
          ],
        );
      },
    )
    );
  }*/

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
      notifyListeners();
    } on PlatformException catch (e) {
      resume();
    } on MissingPluginException {

    }
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
      notifyListeners();
    } on PlatformException catch (e) {
      pause();
    } on MissingPluginException {

    }
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {

    } on MissingPluginException {

    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {

    } on MissingPluginException {

    }
  }

  Widget spotifyImageWidget(ImageUri image) {
    return FutureBuilder(
        future: SpotifySdk.getImage(
          imageUri: image,
          dimension: ImageDimension.large,
        ),
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            oldImage = Image.memory(snapshot.data!, height: 90, width: screenWidth, fit: BoxFit.cover,);
            currentTrackImageUri = image;
            return oldImage;
          } else if (snapshot.hasError) {

            return Text('');
          } else {
            return Text('');
          }
        });
  }

}