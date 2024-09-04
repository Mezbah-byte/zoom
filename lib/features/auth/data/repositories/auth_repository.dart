import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> register(String email, String password) async {
    return (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
  }

  Future<User?> login(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
