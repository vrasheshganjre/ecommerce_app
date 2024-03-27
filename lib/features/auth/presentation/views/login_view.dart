import 'package:ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            Fluttertoast.showToast(msg: state.error);
          } else if (state is AuthSuccess) {
            Fluttertoast.showToast(msg: "Sign in as ${state.user.email}");
          }
        },
        builder: (context, state) {
          return state is AuthLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            "Welcome to Ecommerce app",
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 50,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          FilledButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthSignIn());
                            },
                            child: const Text("Continue with google"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
