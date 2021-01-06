import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/cloudDatabase/database.dart';
import 'package:todo/model/task.dart';
import 'package:todo/screens/taskpage.dart';
import 'package:todo/widgets/drawer.dart';
import 'package:todo/widgets/taskcard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String _title, _desc;
  CloudDatabase cloudDatabase = CloudDatabase();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: cloudDatabase.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final dataList = snapshot.data.docs;
                    return ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final Task task = Task.fromMap(dataList[index].data());
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskPage(
                                  id: task.id,
                                  title: task.title,
                                  desc: task.description,
                                  isEdit: true,
                                ),
                              ),
                            );
                          },
                          child: TaskCard(
                            title: task.title,
                            desc: task.description,
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),

              //Add todo button.
              Positioned(
                right: 2.0,
                bottom: 20.0,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskPage(
                                isEdit: false,
                              )),
                    );
                  },
                  child: Text(
                    "New",
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
