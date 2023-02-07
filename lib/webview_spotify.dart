import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//https://stackoverflow.com/questions/62399490/missing-required-parameter-client-id-spotify-api-angular-project
class AllWebview extends StatefulWidget {
  final String title, link;

  const AllWebview({Key? key, required this.title, required this.link})
      : super(key: key);

  @override
  State<AllWebview> createState() => _AllWebviewState();
}

// appBar: AppBar(
//   title: Text("${widget.title}"),
//   centerTitle: true,
// ),
class _AllWebviewState extends State<AllWebview> {
  bool isLoading = true;

  @override
  void initState() {
    //print("Name is /// ${ProvidersUtility.userProvider!.user.username} and email ${ProvidersUtility.userProvider!.user.email}");
    super.initState();
    print("WEBVIEW IS ${widget.title} ${widget.link} ");

    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.title}"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                initialUrl: 'https://accounts.spotify.com/authorize',
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  print("Page is loading ${finish}");
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Stack()
            ],
          ),
        ),
        resizeToAvoidBottomInset: false);
  }
}
