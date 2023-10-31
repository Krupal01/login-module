import 'package:flutter/cupertino.dart';
import 'package:login_module/bloc/login_bloc.dart';
import 'package:login_module/screens/login_screen.dart';

class AuthorizedScreen extends StatefulWidget {
  const AuthorizedScreen({super.key, required this.child});
  final Widget child;

  @override
  State<AuthorizedScreen> createState() => _AuthorizedScreenState();
}

class _AuthorizedScreenState extends State<AuthorizedScreen> {
  LoginBloc loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return loginBloc.isLogin() ? widget.child : LoginScreen(runAfterLogin: (){
      setState(() {

      });
    },);
  }
}
