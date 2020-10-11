import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_da/screen/task_page_screen.dart';
import 'package:to_da/widgets/card_task.dart';
import 'welcome_user.dart';
import './add_new_task_screen.dart';
import '../provider/tasks.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  bool isload = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await Provider.of<Tasks>(context, listen: false).fetchAndSet();
      setState(() {
        isload = true;
      });
    });
    super.initState();
  }

  final double progressIndicatorValue = 50;

  @override
  Widget build(BuildContext context) {
    final taskType = Provider.of<Tasks>(context).taskType;
    return Scaffold(
      body:
          !isload
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'TODO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontSize: 26,
                                color: Colors.black87.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                    WelcomeUser(),
                    Expanded(
                      child: Consumer<Tasks>(
                        builder: (
                          BuildContext context,
                          taskData,
                          Widget child,
                        ) =>
                            GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20),

                          scrollDirection: Axis.vertical,
                          itemCount: taskType.length + 1,
                          itemBuilder: (context, index) {
                            return index != (taskType.length)
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => TaskPageScreen(
                                            index: index,

                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: 'task-$index',
                                      child: OverflowBox(
                                        minWidth: 50,
                                        maxWidth: 180,
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: CardTask(
                                            index: index,
                                            tasksData: taskData,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddNewTaskScreen(),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                      elevation: 5,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 32.0,
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
