import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class DatabaseService {
  CollectionReference listsCollection =
      FirebaseFirestore.instance.collection("lists");

  Future<QuerySnapshot> getTaskList(DocumentReference list) async {
    return await list.collection("tasks").get();
  }

  Future<void> addList(
      String listTitle, TaskListManager taskListManager) async {
    var list = listsCollection.doc();
    list.set({"title": listTitle});
    for (TaskModel task in taskListManager.taskList) {
      list.collection("tasks").doc().set({
        "title": task.title,
        "isCompleted": task.isCompleted,
        "startTime": task.startTime,
        "finishTime": task.finishTime,
        "duration": task.duration,
        "dueDate": task.dueDate,
        "notes": task.notes,
        "timeStamp": Timestamp.now(),
      });
    }
  }

  Future<void> removeList(DocumentSnapshot list) async {
    QuerySnapshot tasks =
        await listsCollection.doc(list.id).collection("tasks").get();
    list.reference.update({"listTitle": FieldValue.delete()});
    for (var task in tasks.docs) {
      task.reference.delete();
    }

    list.reference.delete();
  }

  void editList(DocumentSnapshot doc, String newTitle) {
    doc.reference.update({"title": newTitle});
  }

  Query orderedTasks(DocumentReference doc) {
    return doc.collection("tasks").orderBy("timeStamp");
  }

  Future addTask(DocumentReference list, TaskModel task) async {
    await list.collection("tasks").add(task.toMap());
  }

  removeTask(QueryDocumentSnapshot task) async {
    task.reference.delete();
  }

  void editTask(QueryDocumentSnapshot doc, TaskModel task) {
    doc.reference.update(task.toMap());
  }

  void checkboxToggle(QueryDocumentSnapshot doc, bool checkboxState) {
    doc.reference.update({"isCompleted": checkboxState});
  }

  // // Future<void> newMethod(String listTitle) async {
  // //   CollectionReference lists = FirebaseFirestore.instance.collection("list");
  // //   DocumentSnapshot snapshot = await lists.doc("list1").get();
  // //   var data = snapshot.data() as Map;
  // //   var tasksData = data["tasks"] as List<dynamic>;
  // //   // print(data["tasks"][1]["isCompleted"]);

  // //   CollectionReference myLists =
  // //       FirebaseFirestore.instance.collection("lists");
  // //   DocumentSnapshot list = await myLists.doc("list1").get();
  // //   DocumentSnapshot task = await list.reference
  // //       .collection("tasks")
  // //       .doc("8B7Sv8YUgM36sW2jR6Wf")
  // //       .get();
  // //   CollectionReference col = list.reference.collection("tasks");
  // //   List<dynamic> taskList = await col.snapshots().toList();

  // //   List<DocumentSnapshot> aaa = [];
  // //   // DocumentSnapshot task1 = await col.doc("task1").get();

  // //   // col.get().then((snapshot) => snapshot.docs.forEach((task) {
  // //   //       print(task.data());
  // //   //     }));
  // //   // var t1 = task1.data() as Map;
  // //   // var list1Data = list.data() as Map;

  // //   // print(task["isCompleted"]);
  // // }

}
