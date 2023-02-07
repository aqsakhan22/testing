import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:testing/webview_spotify.dart';
class FlutterWebAuthEx extends StatefulWidget {
  const FlutterWebAuthEx({Key? key}) : super(key: key);

  @override
  State<FlutterWebAuthEx> createState() => _FlutterWebAuthExState();
}

class _FlutterWebAuthExState extends State<FlutterWebAuthEx> {
  Future<void> checkWebAuth() async{

    final callbackUrl = "https://spotifydata.com/callback";

    final url = Uri.https('accounts.spotify.com', '/authorize', {
      'response_type': 'code',
      'client_id': "00062cf894414e29b5158c040fbc96b5",
      'redirect_uri': 'https://ansariacademy.com/RunWith/spotify.php',
      'scope': 'user-read-private user-read-email',
    });

    // final result = await FlutterWebAuth.authenticate(
    //     url: url.toString(), callbackUrlScheme: callbackUrl);
    print("url ${url}");
    Navigator.push(context, MaterialPageRoute(builder: (context) => AllWebview(title: "spotify integration", link: url.toString())));


    //get response
    // final response = await http.get(Uri.parse("https://ansariacademy.com/RunWith/spotify.php"));
    // print("response  ${response}");

    // clientId: '00062cf894414e29b5158c040fbc96b5',
    // redirectUrl: 'https://ansariacademy.com/RunWith/spotify.php',
    // final response = await http.post(Uri.parse("https://accounts.spotify.com/authorize?"), body: {
    //   "response_type": 'code',
    //   "client_id": "00062cf894414e29b5158c040fbc96b5",
    //     "scope": "user-read-private user-read-email",
    //     "redirect_uri": "https://ansariacademy.com/RunWith/spotify.php",
    //      "state": "2234567891548368"
    // });
    // print("response  ${response.headers}");
    // Present the dialog to the user
    // Present the dialog to the user
    // final result = await FlutterWebAuth.authenticate(url: "https://ansariacademy.com/RunWith/spotify.php", callbackUrlScheme: "ansariacademy.com");
    //
    // print("result is ${result}");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter web auth"),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: (){
            checkWebAuth();
          },
          child: Text("check"),
        ),
      ),
    );
  }
}
