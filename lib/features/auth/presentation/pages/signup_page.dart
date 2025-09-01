import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Username _username = const Username.pure();
  Email _email = const Email.pure();
  Password _password = const Password.pure();
  ConfirmPassword _confirmPassword = const ConfirmPassword.pure();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.signUp)),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      AppStrings.signUp,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // Username Field
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.username,
                        prefixIcon: Icon(Icons.person_outlined),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _username = Username.dirty(value);
                        });
                      },
                      validator: (value) {
                        if (_username.error == UsernameValidationError.empty) {
                          return AppStrings.usernameRequired;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: AppStrings.email,
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _email = Email.dirty(value);
                        });
                      },
                      validator: (value) {
                        if (_email.error == EmailValidationError.empty) {
                          return AppStrings.emailRequired;
                        }
                        if (_email.error == EmailValidationError.invalid) {
                          return AppStrings.emailInvalid;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: AppStrings.password,
                        prefixIcon: Icon(Icons.lock_outlined),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password = Password.dirty(value);
                          _confirmPassword = ConfirmPassword.dirty(
                            password: value,
                            value: _confirmPasswordController.text,
                          );
                        });
                      },
                      validator: (value) {
                        if (_password.error == PasswordValidationError.empty) {
                          return AppStrings.passwordRequired;
                        }
                        if (_password.error ==
                            PasswordValidationError.tooShort) {
                          return AppStrings.passwordTooShort;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: AppStrings.confirmPassword,
                        prefixIcon: Icon(Icons.lock_outlined),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = ConfirmPassword.dirty(
                            password: _passwordController.text,
                            value: value,
                          );
                        });
                      },
                      validator: (value) {
                        if (_confirmPassword.error ==
                            ConfirmPasswordValidationError.empty) {
                          return AppStrings.passwordRequired;
                        }
                        if (_confirmPassword.error ==
                            ConfirmPasswordValidationError.mismatch) {
                          return AppStrings.passwordMismatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Sign Up Button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;
                        final isValid = Formz.validate([
                          _username,
                          _email,
                          _password,
                          _confirmPassword,
                        ]);

                        return ElevatedButton(
                          onPressed: isLoading || !isValid
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      SignUpSubmitted(
                                        username: _usernameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  }
                                },
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(AppStrings.signUp),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(AppStrings.alreadyHaveAccount),
                        TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: const Text(AppStrings.login),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
