import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_da/screen/add_task_screen.dart';
import '../widgets/card_task.dart';
import '../provider/tasks.dart';
import '../constant.dart';
import 'add_new_task_screen.dart';

class TaskPageScreen extends StatefulWidget {
  final index;

  TaskPageScreen({this.index});

  @override
  _TaskPageScreenState createState() => _TaskPageScreenState();
}

class _TaskPageScreenState extends State<TaskPageScreen> {
  PageController _pageController;
  var currentIndex;
  var taskTyps;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: widget.index, viewportFraction: 0.9);
    currentIndex = widget.index;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(currentIndex);
    final tasksProvider = Provider.of<Tasks>(context, listen: false);
    final taskType = tasksProvider.taskType;
    if (currentIndex != -1) {
      taskTyps = taskType[currentIndex].taskType;
    }
    if (currentIndex == -1) {
      currentIndex = 0;
    }
    final tasks = tasksProvider.typeTask(taskTyps);
    final taskData = Provider.of<Tasks>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'Task',
            style: TextStyle(
                fontFamily: 'Baloo Tammudu 2',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                height: 4,
                textBaseline: TextBaseline.ideographic),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton(
              elevation: 3,
              onSelected: (i) {
                if (i == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddNewTaskScreen(
                              editing: true, id: taskType[currentIndex].id)));
                } else if (i == 1) {
                  currentIndex--;
                  if (currentIndex < 0) {
                    Navigator.pop(context);
                  }
                  tasksProvider.deleteTaskType(taskTyps);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddNewTaskScreen(),),);
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      value: 0,
                      child: Text(
                        'Edit',
                        style: kTaskTextStyle,
                      )),
                  PopupMenuItem(
                      value: 1, child: Text('Delete', style: kTaskTextStyle)),
                  PopupMenuItem(
                      value: 2, child: Text('Add', style: kTaskTextStyle)),
                ];
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Hero(
                    tag: 'task-$currentIndex',
                    child: Material(
                      type: MaterialType.transparency,
                      child: PageView.builder(
                          onPageChanged: (i) {
                            setState(() {
                              currentIndex = i;
                              print(currentIndex);
                            });
                          },
                          controller: _pageController,
                          itemCount: taskType.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: EdgeInsets.only(right: 20, bottom: 20),
                              height: 200,
                              child: CardTask(
                                index: i,
                                tasksData: tasksProvider,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Tasks ',
                          style: kCardTaskStyle.copyWith(color: Colors.black),
                        ),
                        Expanded(
                          child: tasks.length == 0
                              ? Text(
                                  'You have no task to do',
                                  style: kCardTaskStyle.copyWith(
                                      color: Colors.black45, fontSize: 26),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.only(left: 0),
                                  itemCount: tasks.length,
                                  itemBuilder: (ctx, i) => ListTile(
                                        contentPadding: EdgeInsets.only(
                                            left: 10, right: 10.0),
                                        leading: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          child: Container(
                                            width: Checkbox.width,
                                            height: Checkbox.width,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 3,
                                                  color: Colors.black38),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Checkbox(
                                              activeColor: Colors.blue,
                                              value: tasks[i].isDone,
                                              onChanged: (_) {
                                                taskData.toggleIsDone(tasks[i]);
                                              },
                                            ),
                                          ),
                                        ),
                                        title: tasks.isEmpty
                                            ? const Text(
                                                'you have no task to do may be you should chill',
                                                style: kCardTaskStyle,
                                              )
                                            : Text(
                                                tasks[i].task,
                                                style: tasks[i].isDone
                                                    ? kCardTaskStyle.copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.black54)
                                                    : kCardTaskStyle.copyWith(
                                                        color: Colors.black87
                                                            .withOpacity(0.7)),
                                              ),
                                        trailing: tasks[i].isDone
                                            ? IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.black38,
                                                  size: 20.0,
                                                ),
                                                onPressed: () {
                                                  taskData
                                                      .removeTask(tasks[i].id);
                                                },
                                              )
                                            : null,
                                      )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        heroTag: 'button',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                    taskType: taskTyps,
                    index: currentIndex,
                  )));
        },
        child: Container(
          width: 60.0,
          height: 60.0,
          child: Icon(Icons.add),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: appColor[currentIndex],
                  begin: Alignment.centerLeft,
                  end: Alignment.topRight),
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
