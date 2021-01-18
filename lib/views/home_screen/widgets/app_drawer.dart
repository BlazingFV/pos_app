import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/views/cart_screen/check_outscreen/cart_screen.dart';
import 'package:pos_app/views/categories_screen.dart/categories_screen.dart';
import 'package:pos_app/views/user_screens/addresses_screen.dart';
import 'package:pos_app/views/user_screens/profile_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          FlatButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => ProfileScreen()));
              },
              child: Text('profile')),
          FlatButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => AddressesScreen()));
            },
            child: Text('addressesScreen'),
          ),
          FlatButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => CartScreen()));
              },
              child: Text('CartScreen')),
               FlatButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => CategoriesScreen()));
              },
              child: Text('Categories')),
        ],
      ),
    );
  }
}
