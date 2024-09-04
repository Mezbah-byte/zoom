import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom/features/auth/data/models/user_model.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<UserModel> userList = RxList<UserModel>();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      userList.clear();
      snapshot.docs.forEach((doc) {
        userList.add(UserModel.fromJson(doc.data()));
      });
    });
  }
}
