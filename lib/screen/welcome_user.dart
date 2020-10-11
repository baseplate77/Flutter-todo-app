import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../constant.dart';
import '../provider/tasks.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<Tasks>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 50.0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Hi, Nayan',
            style: TextStyle(
                fontFamily: "Baloo Tammudu 2",
                color: Colors.black87.withOpacity(0.7),
                fontSize: 45.0,
                height: 1,
                letterSpacing: 1.0),
          ),
          Text(
            'Looks like fell good.',
            style: kTaskTextStyle,
          ),
          Text(
            'You have ${taskData.totalNotDoneTask()} tasks to do today.',
            style: kTaskTextStyle,
          ),
Text('Today:  ${DateFormat.yMMMMEEEEd().format(DateTime.now())}',style: kTaskTextStyle)
        ],
      ),
    );
  }
}
