import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_styles.dart';

import '../../domain/models/tasks_model.dart';

class StatusTask extends StatelessWidget {
  const StatusTask({
    super.key,
    required this.taskModel,
  });

  final TasksModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 6, vertical: 2),
      decoration: ShapeDecoration(
        color: taskModel.status == 'waiting'
            ? const Color(0xFFFFE4F2)
            : taskModel.status == 'inprogress'
            ? const Color(0xFFF0ECFF)
            : const Color(0xFFE3F2FF),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(
        taskModel.status ?? '',
        style:AppStyles.styleMediumStatus12(taskModel.status, context)
      ),
    );
  }
}
