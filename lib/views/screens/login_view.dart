import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../blocs/auth_bloc/auth_event.dart';
import '../../../blocs/auth_bloc/auth_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginSuccess) {
              Navigator.pushReplacementNamed(context, '/home');
            }
            if (state is AuthLoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoginInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/imgs/popcorn.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 48.0),
                  TextField(
                    controller: emailController,
                    onChanged: (value) {
                      context.read<AuthBloc>().add(AuthLoginEmailChangedEvent(value));
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: state is AuthLoginFailureInvalidEmail ? state.error.toString() : null,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: passwordController,
                    onChanged: (value) {
                      context.read<AuthBloc>().add(AuthLoginPasswordChangedEvent(value));
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: state is AuthLoginFailureInvalidPassword ? state.error.toString() : null,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLoginSubmittedEvent(
                          emailController.text, passwordController.text));
                    },
                    child:
                    const Text(
                        'Login',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
