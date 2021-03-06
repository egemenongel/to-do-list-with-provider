import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';
import 'package:to_do_list_with_provider/services/database_service.dart';
import 'package:to_do_list_with_provider/services/size_helper.dart';
import 'package:to_do_list_with_provider/widgets/task_list_tile.dart';

class TaskListsPage extends StatelessWidget {
  const TaskListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firestore = DatabaseService();
    return StreamBuilder(
      stream: firestore.listsCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
              color: Colors.blueAccent,
            ),
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      "My Lists",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                  height: appBarHeight(context),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.orange[700],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                      )),
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var list = snapshot.data.docs[index];
                                  return TaskListTile(
                                    list: list,
                                    index: index,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider(
                                      height: 20, color: Colors.transparent);
                                },
                              ),
                            ),
                          ],
                        ))),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepOrange[800],
            heroTag: null,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListTitlePage()));
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
