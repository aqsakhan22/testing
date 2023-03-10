import 'package:flutter/material.dart';
class SeacthFilter extends StatefulWidget {
  const SeacthFilter({Key? key}) : super(key: key);

  @override
  State<SeacthFilter> createState() => _SeacthFilterState();
}

class _SeacthFilterState extends State<SeacthFilter> {
  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  @override
  void initState() {
    // TODO: implement initState
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child:
    _foundUsers.isNotEmpty ?
                ListView.builder(
              itemCount: _foundUsers.length,
              itemBuilder: (BuildContext context,int index){
                return Card(

                  color: Colors.orangeAccent,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5),
                      child: Text("${_foundUsers[index]['name']}")),
                );
              },


            )
            :

    const Text(
      'No results found',
      style: TextStyle(fontSize: 24),
    ),



            )



          ],
        ),
      )

    );
  }
}
