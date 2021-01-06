import 'package:flutter/material.dart';
import 'package:todo/cloudDatabase/database.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String desc;
  TaskCard({this.desc, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          descrip(desc),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  CloudDatabase _cd = CloudDatabase();
                  _cd.deleteData();
                },
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                          colors: [Colors.red[800], Colors.red[500]],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  child: Image(
                    image: AssetImage("assets/images/delete_icon.png"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}

Widget descrip(String desc) {
  return Padding(
    padding: EdgeInsets.only(top: 10.0),
    child: Text(
      desc ?? "(No description Added)",
      style: TextStyle(
        fontSize: 16.0,
        height: 1.5,
      ),
    ),
  );
}
