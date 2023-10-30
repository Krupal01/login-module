import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../utils/ui_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

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
                      height: 14,
                    ),
                    BlocConsumer<LoginBloc, LoginState>(
                      bloc: loginBloc,
                      listener: (context, state) {
                        if (state is Error) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(getSnackBar(state.message));
                        }
                        if (state is ResetMailSendSuccess) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(getSnackBar("check your mail"));
                          emailController.text = "";
                          showSuccessDialog(
                              context, "Reset password link sent");
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (state is! Loading) {
                              loginBloc.forgotPassword(emailController.text);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (state is Loading)
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Send password reset mail"),
                          ),
                        );
                      },
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
