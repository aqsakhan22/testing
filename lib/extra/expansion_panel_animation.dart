import 'package:flutter/material.dart';

// sampel link
// https://blog.logrocket.com/expansionpanel-flutter-guide-with-examples/
//https://stackoverflow.com/questions/66488284/animating-title-change-in-expansiontile
// https://pub.dev/packages/flutter_expanded_tile
class Step {
  Step(
      this.title,
      this.body,
      [this.isExpanded = false]
      );
  String title;
  String body;
  bool isExpanded;
}
class ExpansionanelList extends StatefulWidget {
  const ExpansionanelList({Key? key}) : super(key: key);

  @override
  State<ExpansionanelList> createState() => _ExpansionanelListState();
}

class _ExpansionanelListState extends State<ExpansionanelList> {
  final List<Step> _steps = [Step("Step0","decription step0")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expansion tile Animation"),
      ),
      body: Container(
        child:  ExpansionPanelList(
          animationDuration: Duration(microseconds: 50),
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _steps[index].isExpanded = !isExpanded;
            });
          },

          children: _steps.map((Step e){
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(e.title),
                );
              }, body: ListTile(
              title: Text(e.body),
            ),
              isExpanded: e.isExpanded,

            );

          }).toList(),
        ),
      ),
    );
  }
}
