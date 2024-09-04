import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom/features/auth/presentation/controllers/auth_controller.dart';
import 'package:zoom/features/video_call/presentation/controllers/call_controller.dart';
import 'package:zoom/features/video_call/presentation/controllers/call_listener_controller.dart';
import '../controllers/user_controller.dart';

class UserListPage extends StatelessWidget {
  final UserController _controller = Get.find<UserController>();
  // UserController _controller = Get.put(UserController());
  final CallController callController = Get.find<CallController>();
  final authController = Get.find<AuthController>();
  final CallListenerController callListenerController = Get.find<CallListenerController>();

  final myUid = FirebaseAuth.instance.currentUser?.uid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Obx(() {
        return ListView.builder(
          itemCount: _controller.userList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_controller.userList[index].email),
              onTap: () {
                callController.createCallRequest(myUid!, _controller.userList[index].uid);
              },
            );
          },
        );
      }),
    );
  }
}
