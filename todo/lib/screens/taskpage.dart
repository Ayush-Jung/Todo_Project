import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/cloudDatabase/database.dart';
import 'package:todo/model/task.dart';
import 'package:todo/screens/homePage.dart';
import 'package:uuid/uuid.dart';

class TaskPage extends StatefulWidget {
  final String id, title, desc;
  final bool isEdit;

  TaskPage({this.id, this.desc, this.title, this.isEdit});
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  CloudDatabase cd = CloudDatabase();
  FocusNode _titlefocus;
  FocusNode _descriptionfocus;
  bool _contentVisible = true;
  final Uuid uuid = Uuid();

  @override
  void initState() {
    if (widget.isEdit) {
      _titleController.text = widget.title;
      _descController.text = widget.desc;
    }
    _contentVisible = true;
    _titlefocus = FocusNode();
    _descriptionfocus = FocusNode();
    super.initState();
  }

  _addData(String text1, String text2, String id) async {
    if (widget.isEdit) {
      await cd.updateData(id, text1, text2);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      final id = uuid.v4();
      Task task = Task(id: id, title: text1, description: text2);
      await cd.addData(task);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _titlefocus.dispose();
    _descriptionfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image(
                            image:
                                AssetImage("assets/images/ack_arrow_icon.png"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: _titlefocus,
                          onSubmitted: (value) async {
                            //check if the field isnot null
                            if (value != "") {
                              _descriptionfocus.requestFocus();
                            }
                          },
                          controller: _titleController,
                          decoration: InputDecoration(
                              hintText: "Enter Task Title!",
                              border: InputBorder.none,
                              fillColor: Colors.black38),
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: TextField(
                          controller: _descController,
                          onSubmitted: (value) {
                            if (value != "") {}
                          },
                          focusNode: _descriptionfocus,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Write your description here!!"),
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 200.0),
                  Center(
                    child: FlatButton(
                      color: Colors.blue,
                      onPressed: () async => _addData(_titleController.text,
                          _descController.text, widget.isEdit ? widget.id : ''),
                      child: Text(
                        widget.isEdit ? 'update' : "save",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
