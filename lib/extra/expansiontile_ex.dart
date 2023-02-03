
import 'package:flutter/material.dart';
class Temp extends StatefulWidget {
  const Temp({Key? key}) : super(key: key);

  @override
  State<Temp> createState() => _TempState();
}

// stores ExpansionPanel state information
class Item {
  Item(bool exp) {
    this.isExpanded = exp;
  }
  late bool isExpanded;
}

List<Item> items = [Item(false), Item(true), Item(true), Item(false)];

class _TempState extends State<Temp> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar:  AppBar(
            title: Text("Exoansiontile"),

          ),

          body: SingleChildScrollView(
            child: Container(
              child: ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    items[index].isExpanded = !isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text("Test", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          leading: Icon(Icons.info),
                          minLeadingWidth : 4,
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                          dense:true,
                        );
                      },
                      body: Column(
                        children: [

                          ExpansionTile(
                            title: const Text('Test 2', style: TextStyle(color: Colors.black87),),
                            leading: Icon(Icons.handshake_outlined, color: Colors.black54,),
                            trailing: Column(),
                            children: <Widget>[
                              ListTile(
                                dense: true,
                                tileColor: Color(0xffffeed4),
                                title: Text('Foo', style: TextStyle (fontSize: 16),),
                                trailing: SizedBox(
                                    child: Text("foo", style: TextStyle (fontSize: 16),)
                                ),
                              ),
                              ListTile(
                                tileColor: Color(0xffffeed4),
                                title: Text('Bar', style: TextStyle (fontSize: 16),),
                                dense: true,
                                trailing: SizedBox(
                                    child: Text("bar", style: TextStyle (fontSize: 16),)
                                ),
                              ),



                            ],
                            onExpansionChanged: (bool expanded) {
                              //setState(() => _customTileExpanded = expanded);
                            },
                          ),
                        ],
                      ),
                      isExpanded: items[1].isExpanded,
                      canTapOnHeader: true
                  ),
                ],

              ),
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: null,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        )
    );

  }
}