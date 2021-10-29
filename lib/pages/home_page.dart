import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var _taskListManager = Provider.of<TaskListManager>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListTitlePage()));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "TO DO LIST",
              style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      Text(
                        "${_taskListManager.listTitle}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      Container(
                        width: 300,
                        height: 400,
                        child: ListView.builder(
                            itemCount: _taskListManager.taskList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var task = _taskListManager.taskList[index];
                              return ListTile(
                                  title: Text(task.title),
                                  trailing: Checkbox(
                                    value: task.isCompleted,
                                    onChanged: (value) {
                                      setState(() {
                                        task.isCompleted = value!;
                                      });
                                    },
                                  ));
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
