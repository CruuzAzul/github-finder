import 'package:flutter/material.dart';
import 'package:github_search/screens/widgets/formInputField.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GitHub Profiles Finder',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none,
                hintText: 'Enter user here',
                contentPadding: EdgeInsets.all(15),
              ),
              onChanged: (text) {
                print("Text field: $text");
              },
            ),
          ),
        ),
      ),
    );
  }
}
