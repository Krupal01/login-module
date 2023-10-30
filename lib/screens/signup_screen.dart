import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../utils/ui_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: "enter your E-mail", labelText: "E-mail"),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: "enter your password",
                        labelText: "Password",
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    BlocConsumer<LoginBloc, LoginState>(
                      bloc: loginBloc,
                      listener: (context, state) {
                        if (state is Error) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(getSnackBar(state.message));
                        }
                        if (state is SignUpSuccess) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(getSnackBar("Register Success"));
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (state is! Loading) {
                              loginBloc.signUpWithEmailPassword(
                                  emailController.text,
                                  passwordController.text);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (state is Loading)
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Register User"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "back to login",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
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
