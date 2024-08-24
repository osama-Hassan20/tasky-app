import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/features/profile/presentation/widgets/profile_section.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/size_config.dart';
import 'manager/cubit/cubit.dart';
import 'manager/cubit/state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUser(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile',
                  style: AppStyles.styleBold16(context)
                      .copyWith(color: const Color(0xFF24252C))),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Transform.rotate(
                    angle: -1.57079633 * 2,
                    child: SvgPicture.asset(
                      ImageAssets.arrowIcon,
                      color: Colors.black,
                    )),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(
                SizeConfig.defaultSize! * 2.4,
              ),
              child: Column(
                children: [
                  ProfileSection(
                    title: 'NAME',
                    value: cubit.userModel?.displayName ?? '',
                  ),
                  ProfileSection(
                    title: 'PHONE',
                    value: cubit.userModel?.username ?? '',
                    widget: InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: cubit.userModel?.username??''));
                        CherryToast.success(
                          title: const Text('Copied to Clipboard'),
                          animationType: AnimationType.fromTop,
                        ).show(context);
                      },
                      child: const Icon(
                        Icons.copy,
                        color: Color(0xff5F33E1),
                      ),
                    ),
                  ),
                  ProfileSection(
                    title: 'LEVEL',
                    value: cubit.userModel?.level ?? '',
                  ),
                  ProfileSection(
                    title: 'YEARS OF EXPERIENCE',
                    value:
                        '${cubit.userModel?.experienceYears.toString()} years',
                  ),
                  ProfileSection(
                      title: 'LOCATION', value: cubit.userModel?.address ?? ''),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
