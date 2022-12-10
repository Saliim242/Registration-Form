import 'package:flutter/material.dart';

import '../database/sql_helper.dart';
import 'teachers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // All journals
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

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  // Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
      int.parse(idController.text),
      nameController.text,
      int.parse(phoneController.text),
      jobController.text,
    );
    _getAllData();

    print("Yess Successfully created");
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Color(0xff263159),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 200),
                Text(
                  textAlign: TextAlign.center,
                  "Please Fill In the Blank With the Teacher Info",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffD6E4E5).withOpacity(0.8),
                  ),
                ),
                // ID Form
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff495579).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Teacher ID';
                      }
                      return null;
                    }),
                    //keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffD6E4E5).withOpacity(0.8),
                    ),
                    controller: idController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Teacher ID",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xffD6E4E5).withOpacity(0.8),
                      ),
                      prefixIcon: Icon(
                        Icons.numbers_outlined,
                        size: 30,
                        color: Color(0xffD6E4E5).withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                // Name Form
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff495579).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Teacher Name';
                      }
                      return null;
                    }),
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffD6E4E5).withOpacity(0.8),
                    ),
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Teacher Name",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xffD6E4E5).withOpacity(0.8),
                      ),
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        size: 30,
                        color: Color(0xffD6E4E5).withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                // Phone Form
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff495579).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Teacher Phone Number';
                      }
                      return null;
                    }),
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffD6E4E5).withOpacity(0.8),
                    ),
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Teacher Phone Number",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xffD6E4E5).withOpacity(0.8),
                      ),
                      prefixIcon: Icon(
                        Icons.phone_android_rounded,
                        size: 30,
                        color: Color(0xffD6E4E5).withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                // Job Form
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff495579).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextFormField(
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Teacher Job';
                      }
                      return null;
                    }),
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffD6E4E5).withOpacity(0.8),
                    ),
                    controller: jobController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Teacher job",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xffD6E4E5).withOpacity(0.8),
                      ),
                      prefixIcon: Icon(
                        Icons.work_outline_rounded,
                        size: 30,
                        color: Color(0xffD6E4E5).withOpacity(0.8),
                      ),
                    ),
                  ),
                ),

                //Button With SAVE Data
                MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _addItem();

                      idController.text = "";
                      nameController.text = "";
                      phoneController.text = "";
                      jobController.text = "";

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Teacher Record Inserted Successfully',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xffD6E4E5),
                            ),
                          ),
                          backgroundColor: Color(0xff495579),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xff495579).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 30,
                          color: Color(0xffD6E4E5).withOpacity(0.8),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Save Info",
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xffD6E4E5).withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                MaterialButton(
                  onPressed: () {
                    var route = MaterialPageRoute(builder: (_) => Teachers());

                    Navigator.push(context, route);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xff495579).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 30,
                          color: Color(0xffD6E4E5).withOpacity(0.8),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Show Info",
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xffD6E4E5).withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
