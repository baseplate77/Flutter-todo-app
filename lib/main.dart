import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_da/screen/task_screen.dart';
import 'provider/tasks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Tasks(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Color(0xFFFFFAFA),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black45
            )
          ),
          unselectedWidgetColor: Colors.transparent,

        ),
//      routes: {
//
//        WorkTask.id : (context) => WorkTask()
//      },
        home: TaskScreen()),

    );
  }
}
