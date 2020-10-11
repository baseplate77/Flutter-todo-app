import 'package:flutter/foundation.dart';
import '../db/db_helper.dart';



class Task {
  final String id;
  final String task;
  bool isDone;
  final String taskType;

  Task({
    @required this.id,
    @required this.task,
    @required this.taskType,
    this.isDone = false
  });

  static Map<String, Object> toMap(Task task) {
    Map<String, Object> map = {
      'id': task.id,
      'task': task.task,
      'isdone': task.isDone ? 1: 0,
      'type': task.taskType
    };
    return map;
  }

}

class TaskType{
  final String id;
  final String taskType;

  TaskType({this.id, this.taskType});

  static Map<String, Object> toMap(TaskType taskType) {
    Map<String, Object> map = {
      'id': taskType.id,
      'taskType': taskType.taskType,
    };
    return map;
  }
}

class Tasks extends ChangeNotifier {

  List<Task> _tasks = [];
  List<TaskType> _tasktype = [];

  List<Task> get tasks {
    return [..._tasks];
  }
  List<TaskType> get taskType {
    return [..._tasktype];
  }

  void addTask(String task, String taskType) {
    final newTask = Task(
        id: DateTime.now().toString(), task: task, taskType: taskType);
    _tasks.add(newTask);
    notifyListeners();
    DBHelper.insert('tasks', Task.toMap(newTask));
  }
  void addTaskType(String type) {
    final newTaskType = TaskType(
      id: DateTime.now().toString(),
      taskType: type
    );
    _tasktype.add(newTaskType);
    notifyListeners();
    DBHelper.insertTaskType('tasktypes', TaskType.toMap(newTaskType));
  }

  void updateTaskType(String id,String taskType){
    final index = _tasktype.indexWhere((tT) => tT.id == id);
    final updateTaskType = TaskType(id: id,taskType: taskType);
    _tasktype[index] = updateTaskType;
    notifyListeners();
    DBHelper.updateTaskType('tasktypes', TaskType.toMap(updateTaskType), id);
  }
  
 void deleteTaskType(String taskType) async{
    _tasktype.removeWhere((element) => element.taskType == taskType);
    _tasks.removeWhere((element) => element.taskType == taskType);
    notifyListeners();
  await DBHelper.deleteTaskTypeAndTask('tasks','tasktypes', taskType);
       
 }

  Future<void> fetchAndSet() async {
    final data = await DBHelper.getData('tasks');
    final taskTypeData = await DBHelper.getTaskType('tasktypes');
    print(taskTypeData);
    _tasktype = taskTypeData.map((e) => TaskType(id: e['id'],taskType: e['taskType'])).toList();
    print(_tasktype);
    _tasks = data.map((item) =>
        Task(id: item['id'],
            taskType: item['type'],
            isDone: item['isdone'] == 1? true : false,
            task: item['task'])).toList();
  }

  int getTotal() {
    return _tasks.length;
  }

  void removeTask(String id) async{
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    await DBHelper.delete('tasks', id);
  }

  List<Task> doneTaskByType(String taskType) {
    return tasks.where((task) =>
    task.isDone == true && task.taskType == taskType).toList();
  }
  int totalNotDoneTask() {
    int doneTask =  _tasks.where((element) => element.isDone == true).toList().length;
    int allTask = _tasks.length;
    return allTask - doneTask;
  }

  void toggleIsDone(Task task) {
    task.isDone = !task.isDone;
    notifyListeners();
    DBHelper.insert('tasks', {
      'id': task.id,
      'task': task.task,
      'isdone': task.isDone ? 1: 0,
      'type': task.taskType
    });
  }

  List<Task> typeTask(String taskType) {
    return _tasks.where((task) => task.taskType == taskType).toList();
  }


}