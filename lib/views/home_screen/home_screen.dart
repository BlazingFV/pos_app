import 'package:flutter/material.dart';
import 'package:pos_app/views/home_screen/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: TextFormField(
          decoration: InputDecoration(
            hintText: 'Search for a Product',
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
