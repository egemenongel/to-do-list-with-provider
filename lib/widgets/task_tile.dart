import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/widgets/dialogs/edit_task_dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
    required this.index,
    required this.taskTitle,
    required this.startTime,
    required this.finishTime,
    required this.duration,
    required this.isCompleted,
    required this.checkboxCallback,
    required this.deleteCallback,
    required this.sortedList,
  });

  final int index;
  final Query sortedList;
  final String taskTitle;
  final String startTime;
  final String finishTime;
  final String duration;
  final bool isCompleted;
  final void Function(bool?)? checkboxCallback;
  final void Function()? deleteCallback;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: (index % 2) == 1 ? Colors.blue[100] : Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10), topLeft: Radius.circular(10))),
        child: ListTile(
            title: Text(
              taskTitle,
              style: TextStyle(
                  color: (index % 2) == 1 ? Colors.indigo : Colors.blue[900],
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor:
                      (index % 2) == 1 ? Colors.orange : Colors.deepOrange),
            ),
            leading: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: isCompleted,
              onChanged: checkboxCallback,
              activeColor: (index % 2) == 1 ? Colors.orange : Colors.deepOrange,
            ),
            trailing: Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  duration != ""
                      ? Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "$duration mins",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SizedBox(),
                  startTime != ""
                      ? Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            startTime,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SizedBox(),
                  finishTime != "" && startTime != ""
                      ? SizedBox(
                          width: 5.0,
                        )
                      : SizedBox(),
                  finishTime != ""
                      ? Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            finishTime,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            )),
      ),
      actionPane: const SlidableStrechActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        Container(
          child: SlideAction(
            onTap: () => showDialog(
              context: context,
              builder: (_) => EditTaskDialog(
                index: index,
                sortedList: sortedList,
              ),
            ),
            child: Icon(
              Icons.mode_edit_outlined,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                top: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: SlideAction(
              onTap: deleteCallback,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  top: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
