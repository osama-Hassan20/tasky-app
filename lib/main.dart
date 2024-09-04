import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/add_task/presentation/manager/cubit/cubit.dart';
import 'package:tasky/features/splash/presentation/splash_view.dart';

import 'core/controler/bloc_observer.dart';
import 'core/utils/api_healper/dio_helper.dart';
import 'core/utils/local_service_helper/cache_helper.dart';
import 'core/utils/local_service_helper/constant.dart';
import 'core/utils/size_config.dart';
import 'features/home/presentation/manager/home_cubit/cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.inti();
  await CacheHelper.init();
  onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'TokenId');
  refreshToken = CacheHelper.getData(key: 'RefreshTokenId');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final Widget startWidget;

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiRepositoryProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getTasks(page: 1),
        ),
        BlocProvider(
          create: (context) => AddTaskCubit(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Tasky App',
        home: SplashView(),
      ),
    );
  }
}
