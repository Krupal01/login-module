import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_module/repository/firebase_repository.dart';
import 'package:login_module/utils/custom_exception.dart';

import 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  FirebaseRepository firebaseRepository = FirebaseRepository();

  LoginBloc() : super(LoginInit());

  Future<void> signInWithEmailPassword(String mail, String password) async {
    emit(Loading());
    try {
      UserCredential? userCredential =
          await firebaseRepository.signInWithEmailPassword(mail, password);
      if (userCredential == null) {
        emit(Error(message: "details not found"));
      } else {
        emit(LoginSuccess());
      }
    } on CustomException catch (e) {
      emit(Error(message: e.message ?? ""));
    }
  }

  Future<void> signUpWithEmailPassword(String mail, String password) async {
    emit(Loading());
    try {
      UserCredential? userCredential =
          await firebaseRepository.signUpWithEmailPassword(mail, password);
      if (userCredential == null) {
        emit(Error(message: "details not found"));
      } else {
        emit(SignUpSuccess());
      }
    } on CustomException catch (e) {
      emit(Error(message: e.message ?? ""));
    }
  }

  Future<void> forgotPassword(String mail) async {
    emit(Loading());
    try {
      bool isSend = await firebaseRepository.passwordReset(mail);
      if (isSend) {
        emit(ResetMailSendSuccess());
      } else {
        emit(Error(message: "Something went wrong"));
      }
    } on CustomException catch (e) {
      emit(Error(message: e.message ?? ""));
    }
  }
}
