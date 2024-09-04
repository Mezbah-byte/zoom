import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../domain/auth_usecases.dart';

class AuthController extends GetxController {
  final AuthUseCases _authUseCases = AuthUseCases();

  // Future<void> register(String email, String password) async {
  //   try {
  //     await _authUseCases.register(email, password);
  //     Get.snackbar('Success', 'Registration Successful');
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }

  Future<void> register(String email, String password) async {
    try {
      await _authUseCases.register(email, password);
      Get.snackbar('Success', 'Registration Successful');
      login(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The email address is already in use.');
        login(email, password);
      } else if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password is too weak.');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'The email address is invalid.');
      } else {
        Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unknown error occurred: ${e.toString()}');
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve user details
      User? user = userCredential.user;

      if (user != null) {
        // User is signed in, now update Firestore
        await _updateUserData(user);
        
        // Navigate to UsersScreen
        Get.offAllNamed('/user_list');
        Get.snackbar('Success', 'Login Successful');
      } else {
        Get.snackbar('Error', 'User not found');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Incorrect password provided for that user.');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'The email address is invalid.');
      } else {
        Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unknown error occurred: ${e.toString()}');
    }
  }

  Future<void> _updateUserData(User user) async {
    try {
      // Define the user data to be saved
      String name = user.email!.split('@').first;
      Map<String, dynamic> userData = {
        'uid':user.uid,
        'email': user.email,
        'profilePic': user.photoURL ?? '', 
        'name': name ?? 'No Name',
      };

      // Save or update user data in Firestore
      await _firestore.collection('users').doc(user.uid).set(userData, SetOptions(merge: true));
    } catch (e) {
      Get.snackbar('Error', 'Failed to update user data: ${e.toString()}');
    }
  }

  

  Future<void> init() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      print('User is already signed in: ${currentUser.email}');
    } else {
      print('No user is currently signed in.');
    }
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  Future<void> logout() async {
    await _authUseCases.logout();
  }
}
