import 'package:flutter/material.dart';
import 'package:tasky_app/models/task_model.dart';

class SliverListTasksWidget extends StatelessWidget {
  const SliverListTasksWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
  });

  final List<TaskModel> tasks;
  final Function(bool? value, int? index) onTap;
  final String emptyMessage;
  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMessage,
                style: TextStyle(color: Color(0XFFFFFCFC), fontSize: 24),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 70),
            sliver: SliverList.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF282828),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      activeColor: Color(0xFF15B86C),
                      checkColor: Color(0XFFFFFCFC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: tasks[index].isDone,
                      onChanged: (bool? value) {
                        onTap(value, index);
                      },
                    ),

                    title: Text(
                      tasks[index].isDone
                          ? tasks[index].taskName
                          : tasks[index].taskName,
                      style: TextStyle(
                        color: tasks[index].isDone
                            ? Color(0xFFC6C6C6)
                            : Color(0XFFFFFCFC),
                        decoration: tasks[index].isDone
                            ? TextDecoration.lineThrough
                            : null,
                        decorationColor: Color(0xFF6C6C6C),
                        decorationThickness: 1.5,
                      ),
                    ),

                    subtitle: tasks[index].taskDescription.trim().isNotEmpty
                        ? Text(
                            tasks[index].isDone
                                ? tasks[index].taskDescription
                                : tasks[index].taskDescription,

                            style: TextStyle(
                              color: tasks[index].isDone
                                  ? Color(0xFF6C6C6C)
                                  : Color(0xFFC6C6C6),
                              fontSize: 12,
                              decoration: tasks[index].isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                              decorationColor: Color(0xFF6C6C6C),
                              decorationThickness: 1.5,
                            ),
                          )
                        : null,
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        color: tasks[index].isDone
                            ? Color(0xFF6C6C6C)
                            : Color(0XFFFFFCFC),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
