import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful login
      if (event.email == 'test@test.com' && event.password == '123456') {
        final user = User(
          id: '1',
          username: 'Test User',
          email: event.email,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // Save token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', 'mock_token_123');
        await prefs.setString('user_id', user.id);

        emit(AuthSuccess(user: user));
      } else {
        emit(const AuthFailure(message: 'อีเมลหรือรหัสผ่านไม่ถูกต้อง'));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful signup
      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        username: event.username,
        email: event.email,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', 'mock_token_123');
      await prefs.setString('user_id', user.id);

      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Clear stored data
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('user_id');

      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
