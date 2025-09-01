import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    if (!_emailRegExp.hasMatch(value)) return EmailValidationError.invalid;
    return null;
  }
}

enum PasswordValidationError { empty, tooShort }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < 6) return PasswordValidationError.tooShort;
    return null;
  }
}

enum ConfirmPasswordValidationError { empty, mismatch }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({required this.password, String value = ''})
    : super.dirty(value);

  final String password;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) return ConfirmPasswordValidationError.empty;
    if (value != password) return ConfirmPasswordValidationError.mismatch;
    return null;
  }
}

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    return null;
  }
}
