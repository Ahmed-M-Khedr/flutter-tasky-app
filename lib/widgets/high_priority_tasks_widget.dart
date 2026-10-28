import 'package:flutter/material.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/screens/high_priority_tasks_screen.dart';

class HighPriorityTasks extends StatelessWidget {
  const HighPriorityTasks({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final Function(bool? value, int? index) onTap;
  final Function() refresh;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: Text(
                    'High Priority Tasks',
                    style: TextStyle(
                      color: Color(0xFF15B86C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ...tasks.reversed.where((e) => e.isHighPriority).take(4).map((
                  element,
                ) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        activeColor: Color(0xFF15B86C),
                        checkColor: Color(0XFFFFFCFC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: element.isDone,
                        onChanged: (value) {
                          final index = tasks.indexWhere(
                            (e) => e.id == element.id,
                          );
                          onTap(value, index);
                        },
                      ),
                      Expanded(
                        child: Text(
                          element.taskName,
                          style: TextStyle(
                            color: element.isDone
                                ? Color(0xFFC6C6C6)
                                : Color(0XFFFFFCFC),
                            decoration: element.isDone
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: Color(0xFF6C6C6C),
                            decorationThickness: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.pushNamed(context, HighPriorityTasksScreen.route);
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF282828),
                  border: Border.all(width: 2, color: Color(0xFF6E6E6E)),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_outward_outlined,
                  color: Color(0xFFC6C6C6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
