import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/auth_bloc/auth_event.dart';
import '../blocs/auth_bloc/auth_state.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
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
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLoginSubmittedEvent(
                        emailController.text, passwordController.text));
                  },
                  child: Text('Login'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
