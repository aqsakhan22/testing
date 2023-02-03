import 'package:flutter/material.dart';
import 'package:testing/extra/check.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  String text="OLD TEXT";
  void goToSecondScreen(BuildContext context) async{
    String datafromSecondScreen= await Navigator.push(context, MaterialPageRoute(builder: (context) =>  Secondscree()));
    // print("datafromSecondScreen ${datafromSecondScreen}");
    setState(() {
      text = datafromSecondScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FIRST"),
        ),
        body: Column(
          children: [
            Text("${text}"),
            ElevatedButton(onPressed: (){
              goToSecondScreen(context);
            }, child: Text("first screen"))
          ],
        )


    );
  }
}
