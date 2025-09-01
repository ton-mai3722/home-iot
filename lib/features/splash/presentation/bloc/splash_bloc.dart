import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(const SplashLoading());

    // Simulate loading time
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is authenticated
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null && token.isNotEmpty) {
      emit(const SplashAuthenticated());
    } else {
      emit(const SplashUnauthenticated());
    }
  }
}
