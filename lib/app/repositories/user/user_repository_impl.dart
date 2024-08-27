import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth;

  UserRepositoryImpl({required FirebaseAuth auth}) : _auth = auth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException(message: 'Email já cadastrado');
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods = await _auth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains("password")) {
        await _auth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains("google")) {
        throw AuthException(message: "Cadastro realizado com o Google");
      } else {
        throw AuthException(message: "Email não cadastrado");
      }
    } on AuthException catch (_) {
      throw AuthException(message: "Erro ao resetar a senha");
    }
  }

  @override
  Future<User?> googleLogin() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final loginMethods =
            await _auth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains("password")) {
          throw AuthException(
              message:
                  'Você já utilizou este e-mail para cadastro. Caso tenha esquecido sua senha, por favor clique no link "Esqueceu sua senha"');
        } else {
          final googleAuth = await googleUser.authentication;

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          final userCredential = await _auth.signInWithCredential(credential);

          return userCredential.user;
        }
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        throw AuthException(
            message: "Conta já cadastrada com outro método de login");
      } else {
        throw AuthException(message: 'Erro ao realizar login com o Google');
      }
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _auth.signOut();
  }
}
