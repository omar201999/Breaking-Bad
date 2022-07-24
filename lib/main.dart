import 'package:breaking_bad/app_router.dart';
import 'package:breaking_bad/presentation/screens/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bussiness_logic/observer/bloc_observer.dart';

void main()
{
  BlocOverrides.runZoned(
        () {
      runApp(MyApp(appRouter: AppRouter(),));
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {

  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: HomeLayout(),
      onGenerateRoute: appRouter.generateRouter,
    );
  }
}

