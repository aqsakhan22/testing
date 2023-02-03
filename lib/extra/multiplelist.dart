import 'package:flutter/material.dart';
class MultiList extends StatefulWidget {
  const MultiList({Key? key}) : super(key: key);

  @override
  State<MultiList> createState() => _MultiListState();
}

class _MultiListState extends State<MultiList> {
  List org=[
    {
      'clients':[
        {
          "client_id": 1,
          "title": "Novus Altair UK",
           "sites":[
             {
               "site_id": 1,
               "title": "363 North Circular Road Barking IG11 7SD",
             } ,
             {
               "site_id": 2,
               "title": "363 North Circular Road Barking IG11 7SD",
             }
           ]
        },
        // {
        //   "client_id": 2,
        //   "title": "Novus karachi UK",
        // },
      ]
    }

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MultiList"),
      ),
      body: Column(
        children: [
          Text("Clients"),
          Container(
            child:ListView.builder(
              shrinkWrap: true,
              itemCount: org.length,
              itemBuilder: (BuildContext context , int parentIndex){
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: (org[parentIndex]['clients'] as List).length ,
                    itemBuilder: (BuildContext context , int index){
                      return ListTile(
                        leading: Text("${org[parentIndex]['clients'][index]['title']}"),
                      );

                    }

                );
              },
            ) ,
          ),

          Text("Sites"),
          Container(
            child:ListView.builder(
              shrinkWrap: true,
              itemCount: org.length,
              itemBuilder: (BuildContext context , int parentIndex){
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: (org[parentIndex]['clients'] as List).length ,
                    itemBuilder: (BuildContext context , int clientIndex){
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: (org[parentIndex]['clients'][clientIndex]['sites'] as List).length,
                          itemBuilder: (BuildContext context,int siteIndex){
                            return Text("${org[parentIndex]['clients'][clientIndex]['sites'][siteIndex]['title']}");
                          });

                    }

                );
              },
            ) ,
          ),

        ],
      )
    );
  }
}
