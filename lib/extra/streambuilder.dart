import 'package:flutter/material.dart';
class Streambuilderex extends StatefulWidget {
  const Streambuilderex({Key? key}) : super(key: key);

  @override
  State<Streambuilderex> createState() => _StreambuilderexState();
}

class _StreambuilderexState extends State<Streambuilderex> {
  // Stream<String> clock() async* {
  //   // This loop will run forever because _running is always true
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //   DateTime now = DateTime.now();
  //   // This will be displayed on the screen as current time
  //   yield "${now.hour} : ${now.minute} : ${now.second}";
  // }
  Future<String> getData() {
    return Future.delayed(Duration(seconds: 1), () {
      return "I am datajgyu";
      // throw Exception("Custom Error");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Builder"),
      ),
      body:
      FutureBuilder(
          future: getData(),
        builder:(ctx, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error} occurred',
              style: TextStyle(fontSize: 18),
            ),
          );

          // if we got our data
        }
        else if (snapshot.hasData) {
          final data = snapshot.data as String;
          return Center(
            child: Text(
              '$data',
              style: TextStyle(fontSize: 18),
            ),
          );

        }
      }
      return Center(
        child: CircularProgressIndicator(),
      );
        }

      )


    //   StreamBuilder(
    //     stream: clock(),
    // builder: (context, AsyncSnapshot<String> snapshot) {
    //   if (snapshot.connectionState == ConnectionState.waiting) {
    //     return const CircularProgressIndicator();
    //   }
    //   return Text(
    //     snapshot.data!,
    //     style: const TextStyle(fontSize: 50, color: Colors.blue),
    //   );
    // }
    //
    //   ),
    );
  }
}
