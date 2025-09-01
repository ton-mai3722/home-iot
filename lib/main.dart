import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'shared/themes/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'core/constants/strings.dart';

void main() {
  runApp(const HomeIoTApp());
}

class HomeIoTApp extends StatelessWidget {
  const HomeIoTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>(create: (context) => AuthBloc())],
      child: MaterialApp.router(
        title: AppStrings.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.lightTheme,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
