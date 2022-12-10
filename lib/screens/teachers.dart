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

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _getAllData() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _teachers = data;
      _isLoading = false;
      print("..number of teachers ${_teachers.first}");
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllData(); // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff263159).withOpacity(0.7),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _teachers.length,
                itemBuilder: (context, index) => SizedBox(
                  height: 120,
                  child: Card(
                    color: Color(0xff495579),
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            _teachers[index]['id'].toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffD6E4E5).withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,,
                              children: [
                                Text(
                                  _teachers[index]['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffD6E4E5).withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  _teachers[index]['phone'].toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffD6E4E5).withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  _teachers[index]['job'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffD6E4E5).withOpacity(0.8),
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
