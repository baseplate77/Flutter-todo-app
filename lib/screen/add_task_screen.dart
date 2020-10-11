import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tasks.dart';
import 'package:to_da/constant.dart';

class AddTaskScreen extends StatelessWidget {
  final _textController = TextEditingController();
  final taskType;
  final int index;

  AddTaskScreen({this.taskType,this.index});

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<Tasks>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'New Task',
          style: TextStyle(color: Colors.black54),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(
          top: 80.0,
        ),
        child: Column(
          children: <Widget>[
            Text(
              'What task are you planing to perform?',
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: TextField(
                controller: _textController,
                cursorColor: Colors.grey,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontWeight: FontWeight.w400),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(width: 1, color: Colors.black38),
                  ),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38)),
                  hintText: 'Enter your task',
                  focusColor: Colors.black54,
                  hoverColor: Colors.black38,
                ),
                showCursor: true,
                autofocus: true,
              ),
            ),
            const SizedBox(
              height: 20.0,
              width: 320.0,
              child: Divider(
                thickness: 1,
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Divider(),
                  Icon(
                    Icons.calendar_today,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Today',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Hero(
              tag: 'button',
              child: ButtonTheme(
                minWidth: double.infinity,
                child: Container(
                  padding: EdgeInsets.only(left: 20.0),
                  width: double.infinity,
                  height: 60.0,
                  child: FlatButton(
                    onPressed: () {
                      taskData.addTask(_textController.text, taskType);
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: appColor[index],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
