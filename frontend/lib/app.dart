import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/app/config/bloc/config_bloc.dart';
import 'package:frontend/app/home/bloc/home_bloc.dart';
import 'package:frontend/core/routing/routing.dart';

/// The main application shell for the Triage AI Chatbot.
/// This widget sets up the necessary providers and initializes the app's routing and theme.
class MyAppShell extends StatelessWidget {
  const MyAppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        // Providing multiple BLoC instances to the widget tree
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(create: (context) => ConfigBloc()),
        ],
        child: MaterialApp.router(
          title: 'Triage AI Chatbot',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          debugShowCheckedModeBanner: false,
          // Setting up the router for navigation
          routeInformationParser: AppRouter.router.routeInformationParser,
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
        ),
      ),
    );
  }
}
