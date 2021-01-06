import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:todo/screens/homePage.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0),
            child: Container(
              color: Colors.tealAccent,
              child: Center(
                child: Text(
                  "Todo App",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.home),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          //About Us
          ListTile(
            onTap: () {},
            leading: Icon(Icons.info_outline),
            title: Text(
              "About Us",
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          //Rate us
          ListTile(
            onTap: () {
              launch("https://github.com/Ayush-Jung/Flutter-data");
            },
            leading: Icon(Icons.star),
            title: Text(
              "Rate us",
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          //Share us
          ListTile(
            onTap: () {
              Share.share(
                  "Hi download this app from https://github.com/Ayush-Jung/Flutter-data");
            },
            leading: Icon(Icons.share),
            title: Text(
              "Share",
              style: TextStyle(fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }
}
