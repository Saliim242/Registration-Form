import 'package:flutter/material.dart';
import 'package:teacher_registration/screens/home_screen.dart';

import '../database/sql_helper.dart';

class Teachers extends StatefulWidget {
  const Teachers({
    super.key,
  });

  // final bool isLoading;
  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  List<Map<String, dynamic>> _teachers = [];
  List<Map<String, dynamic>> _found = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _getAllData() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _teachers = data;
      _isLoading = false;
      _found = _teachers;
      print("..number of Founds ${_found.length}");
    });
  }

  @override
  void initState() {
    _teachers = _found;
    super.initState();

    _getAllData();
    // Loading the diary when the app starts

    print("Found is ===");
    print(_teachers.length);
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      _getAllData();
      results = _teachers;
    } else {
      results = _teachers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      _found = results;
      print("Yaa Huuuu");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff263159).withOpacity(0.7),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              //margin: EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff495579).withOpacity(0.4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                onChanged: ((value) {
                  setState(() {
                    _runFilter(value);
                  });
                }),
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffD6E4E5).withOpacity(0.8),
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  border: InputBorder.none,
                  hintText: "Search Teacher by Name",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xffD6E4E5).withOpacity(0.8),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    size: 30,
                    color: Color(0xffD6E4E5).withOpacity(0.8),
                  ),
                ),
              ),
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: _found.isNotEmpty
                        ? ListView.builder(
                            itemCount: _found.length,
                            itemBuilder: (context, index) => SizedBox(
                              key: ValueKey(_found[index]["id"]),
                              height: 120,
                              child: Card(
                                color: Color(0xff495579),
                                margin: const EdgeInsets.all(15),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        _found[index]['id'].toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xffD6E4E5)
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,,
                                          children: [
                                            Text(
                                              _found[index]['name'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffD6E4E5)
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            Text(
                                              _found[index]['phone'].toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffD6E4E5)
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            Text(
                                              _found[index]['job'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffD6E4E5)
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Text(
                            textAlign: TextAlign.center,
                            "Sorry No Results Found",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffD6E4E5).withOpacity(0.8),
                            ),
                          ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff495579),
        onPressed: () {
          var route = MaterialPageRoute(builder: (_) => HomePage());

          Navigator.push(context, route);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
