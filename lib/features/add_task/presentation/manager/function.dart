import 'package:flutter/material.dart';

import '../widgets/select_image.dart';
import 'cubit/cubit.dart';

void showSelectPhotoOptions(BuildContext context, AddTaskCubit cubit) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.28,
        maxChildSize: 0.4,
        minChildSize: 0.28,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: SelectImage(
              onTap: cubit.getPostImage,
            ),
          );
        }),
  );
}
