import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/utils/app_styles.dart';
import 'package:tasky/features/add_task/presentation/manager/cubit/cubit.dart';

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    super.key,
    required this.cubit,
  });

  final AddTaskCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await cubit.pickImage(ImageSource.gallery);
      },
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_photo_alternate_outlined,
              color: Color(0xFF5F33E1),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Add Img',
              textAlign: TextAlign.center,
              style: AppStyles.styleMedium19(context),
            ),
          ],
        ),
      ),
    );
  }
}
