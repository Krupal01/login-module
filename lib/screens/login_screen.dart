import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_module/bloc/login_bloc.dart';
import 'package:login_module/bloc/login_state.dart';
import 'package:login_module/screens/forgot_password_screen.dart';
import 'package:login_module/screens/signup_screen.dart';
import 'package:login_module/utils/ui_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.runAfterLogin});
  final Function? runAfterLogin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          navigateTo(context, const ForgotPasswordScreen());
                        },
                        child: Text(
                          "Forgot Password",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
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
                        if (state is LoginSuccess) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(getSnackBar("Login Success"));
                          widget.runAfterLogin?.call();
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (state is! Loading) {
                              loginBloc.signInWithEmailPassword(
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
                                : const Text("Login"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        navigateTo(context, const SignUpScreen());
                      },
                      child: Text(
                        "Create Account",
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
