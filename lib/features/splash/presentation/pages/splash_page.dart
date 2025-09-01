import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(const AppStarted()),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          context.go('/home');
        } else if (state is SplashUnauthenticated) {
          context.go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Icon(Icons.home_outlined, size: 120, color: AppColors.onPrimary),
              SizedBox(height: 24),

              // App Name
              Text(
                AppStrings.appName,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onPrimary,
                ),
              ),
              SizedBox(height: 8),

              // App Description
              Text(
                AppStrings.appDescription,
                style: TextStyle(fontSize: 16, color: AppColors.onPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),

              // Loading Indicator
              CircularProgressIndicator(color: AppColors.onPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
