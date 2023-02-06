// import 'package:flutter/material.dart';
// import 'package:spotify/spotify.dart';
// import 'package:testing/UserPreferences.dart';
// //https://pub.dev/packages/spotify
// //https://github.com/spotify/android-sdk/issues/282
// class ccessToken extends StatefulWidget {
//   const ccessToken({Key? key}) : super(key: key);
//
//   @override
//   State<ccessToken> createState() => _ccessTokenState();
// }
//
// class _ccessTokenState extends State<ccessToken> {
//   String clientId="00062cf894414e29b5158c040fbc96b5";
//   String RedirectUrl="https://ansariacademy.com/RunWith/spotify.php";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("helonckjh"),
//       ),
//       body: Container(
//         child: ElevatedButton(
//           onPressed: () async{
//             print("${UserPreferences.spotifyToken}");
//             final credentials = SpotifyApiCredentials(clientId, clientSecret);
//             final spotify = SpotifyApi(credentials);
//             // final artist = await spotify.artists.get('0OdUWJ0sBjDrqHygGUXeCF');
//             // var spotify = SpotifyApi.withAccessToken("${UserPreferences.spotifyToken}")
//             //
//             // ;
//             // print("spotify is ${spotify}");
//           },
//           child: Text("accesdchj"),
//         ),
//       ),
//     );
//   }
// }
