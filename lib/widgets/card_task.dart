import 'package:flutter/material.dart';
import 'package:to_da/widgets/progress_bar.dart';

import '../constant.dart';
import '../provider/tasks.dart';

class CardTask extends StatelessWidget {
  final int index;
  final Tasks tasksData;
  static final String id = 'card';

  CardTask({@required this.index, this.tasksData});

  @override
  Widget build(BuildContext context) {
    final taskType = tasksData.taskType;
    int allTask = tasksData.typeTask(taskType[index].taskType).length;
    int doneTask = tasksData.doneTaskByType(taskType[index].taskType).length;
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(colors: appColor[index],begin: Alignment.bottomLeft,end: Alignment.topRight),
            boxShadow: [
              BoxShadow(color: Colors.black26,offset: Offset(2,5),blurRadius:5)
            ]
              ),
        ),
        Positioned(
          top: 60,
          left: 10,
          right: 0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                    Text(
                      '${allTask - doneTask} Tasks',
                      style: kCardTaskStyle,
                    ),
                    Text(
                      taskType[index].taskType.toString(),
                      style: kCardCategaryStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20,bottom: 10),
                      child: ProgressBar(
                        value: allTask == 0.0 ? 0.0 : (doneTask / allTask),
                        index: index,
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ],
    );
  }
}

