import 'package:firebase_auth/firebase_auth.dart';

import '../data/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository _repository = AuthRepository();

  Future<User?> register(String email, String password) {
    return _repository.register(email, password);
  }

  Future<User?> login(String email, String password) {
    return _repository.login(email, password);
  }

  Future<void> logout() {
    return _repository.logout();
  }
}
