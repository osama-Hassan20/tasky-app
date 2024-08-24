import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tasky/core/utils/app_styles.dart';
// import 'package:tasky/features/home/presentation/manager/home_cubit/cubit.dart';
// import 'package:tasky/features/home/presentation/manager/home_cubit/state.dart';

class ListTaskView extends StatelessWidget {
  const ListTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: ListView.separated(
              // shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: 100,
              itemBuilder: (BuildContext context, int index){
                return Text('sls');
              }),
      )
    );
  }
}