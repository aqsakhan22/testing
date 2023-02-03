import 'package:flutter/material.dart';
class Secondscree extends StatefulWidget {
  const Secondscree({Key? key}) : super(key: key);

  @override
  State<Secondscree> createState() => _SecondscreeState();
}

class _SecondscreeState extends State<Secondscree> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SECOND SCREEN"),
      ),
      body: Column(
        children: [

          ElevatedButton(onPressed: (){
            Navigator.pop(context,"nEW TEXT FROM SECOND SCREEN");
          }, child: Text("second"))
        ],
      )


    );
  }
}
