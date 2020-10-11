import 'package:flutter/material.dart';
import '../provider/tasks.dart';
import 'package:provider/provider.dart';

class AddNewTaskScreen extends StatelessWidget {
  final _textController = TextEditingController();
  final bool editing;
  final String id;
  AddNewTaskScreen({this.editing = false,this.id});

  @override
  Widget build(BuildContext context) {
    if(id != null) {

    }
    final tasksProvider = Provider.of<Tasks>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          editing?'Enter New Task':'New Task',
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
                editing?'Enter New Name' :'Enter the categaory name',
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
                    hintText: editing? 'Enter new task' :'Enter your task',
                    focusColor: Colors.black54,
                    hoverColor: Colors.black38,
                  ),
                  showCursor: true,
                  autofocus: true,
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                constraints: BoxConstraints(minWidth: double.infinity),
                height: 60.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF0e9aa7),Color(0xFF35d0ba)])
                ),

                child: FlatButton(
                  onPressed: () {
                    var type = _textController.value.text;
                    if(editing){
                      tasksProvider.updateTaskType(id,type);
                    }else {
                    tasksProvider.addTaskType(type);

                    }
          Navigator.pop(context);
                  },
                  child: editing ?const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 30.0,
                  ) :const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.0,
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
