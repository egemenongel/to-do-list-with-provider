import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/pages/home_page.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class ListBottomBar extends StatelessWidget {
  const ListBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                onPressed: () {
                  context.read<TaskListManager>().clearList();
                },
                child: Text("Clear List")),
          ),
          Container(
            height: 30,
            child: VerticalDivider(color: Colors.grey),
            width: 0,
          ),
          Expanded(
              child: TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text("Submit")))
        ],
      ),
    );
  }
}