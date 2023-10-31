import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_module/utils/custom_exception.dart';

import '../firebase_options.dart';

class FirebaseRepository {
  FirebaseApp? app;
  FirebaseAuth? auth;
  FirebaseRepository._privateConstructor(){
    initFirebase();
  }

  static FirebaseRepository firebaseRepository = FirebaseRepository._privateConstructor();

  factory FirebaseRepository(){
    return firebaseRepository;
  }

  void initFirebase() async {
    app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    auth = FirebaseAuth.instanceFor(app: app!);
  }

  Future<UserCredential?> signInWithEmailPassword(String email , String password) async {
    try {
      UserCredential? userCredential = await auth?.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-login-credentials') {
        throw CustomException('invalid credentials');
      }else {
        throw CustomException(e.message);
      }
    }
  }

  Future<UserCredential?> signUpWithEmailPassword(String email , String password) async {
    try{
      UserCredential? userCredential = await auth?.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  Future<bool> passwordReset(String email) async {
    try{
      var isSend = false;
      await auth?.sendPasswordResetEmail(email: email).then((value) => isSend = true ).catchError((e)=> throw CustomException(e.toString()));
      return isSend;
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  User? getCurrentUser(){
    return auth?.currentUser;
  }
}
