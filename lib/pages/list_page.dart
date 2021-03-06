import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/services/database_service.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';
import 'package:to_do_list_with_provider/services/size_helper.dart';
import 'package:to_do_list_with_provider/widgets/dialogs/add_task_dialog.dart';
import 'package:to_do_list_with_provider/widgets/dialogs/delete_task_dialog.dart';
import 'package:to_do_list_with_provider/widgets/task_tile.dart';

class ListPage extends StatelessWidget {
  ListPage({Key? key, this.list}) : super(key: key);
  final DocumentSnapshot? list;
  @override
  Widget build(BuildContext context) {
    var firestore = DatabaseService();
    return StreamBuilder(
      stream: firestore.orderedTasks(list!.reference).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          body: Container(
            color: Colors.orange[700],
            child: Column(
              children: [
                Container(
                    height: appBarHeight(context),
                    child: Center(
                      child: Text(
                        "${list!["title"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var task = snapshot.data.docs[index];
                                  return TaskTile(
                                      index: index,
                                      sortedList: firestore
                                          .orderedTasks(list!.reference),
                                      taskTitle: task["title"],
                                      startTime: task["startTime"],
                                      finishTime: task["finishTime"],
                                      duration: task["duration"],
                                      isCompleted: task["isCompleted"],
                                      checkboxCallback: (checkboxState) =>
                                          firestore.checkboxToggle(
                                              task, checkboxState!),
                                      deleteCallback: () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                DeleteTaskDialog(task: task),
                                          ));
                                },
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider(
                                    height: 10,
                                    color: Colors.transparent,
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: bottomBar(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Colors.indigoAccent,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.blueGrey,
                                    heroTag: null,
                                    child: Icon(
                                      Icons.add,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  AddTaskDialog(list: list!),
                                                ],
                                              ));
                                    },
                                  ),
                                  FloatingActionButton(
                                    backgroundColor: Colors.blueGrey,
                                    heroTag: null,
                                    child: Icon(
                                      Icons.add_box_outlined,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListTitlePage()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        );
      },
    );
  }
}
