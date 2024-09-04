import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom/config/routes.dart';
import 'package:zoom/features/auth/presentation/controllers/auth_controller.dart';
import 'package:zoom/features/auth/presentation/pages/register_page.dart';
import 'package:zoom/features/user/presentation/controllers/user_controller.dart';
import 'package:zoom/features/user/presentation/pages/user_list_page.dart';
import 'package:zoom/features/video_call/presentation/controllers/call_controller.dart';
import 'package:zoom/features/video_call/presentation/controllers/call_listener_controller.dart';
import 'package:zoom/features/video_call/presentation/controllers/video_call_controller.dart';
import 'config/firebase_config.dart';
import 'config/zoom_config.dart';
import 'core/bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();
  // await ZoomConfig.initialize();
  
  await Get.putAsync(() async {
    final authController = AuthController();
    await authController.init();
    return authController;
  });

  // Check if the user is already logged in
  final authController = Get.find<AuthController>();
  final isLoggedIn = authController.isLoggedIn();

  // Bind other controllers
  Get.lazyPut<UserController>(() => UserController());
  Get.lazyPut<VideoCallController>(() => VideoCallController());
  Get.lazyPut<CallController>(() => CallController());
  Get.lazyPut<CallListenerController>(() => CallListenerController());

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zoom Calling App',
      // initialBinding: AppBindings(),
      getPages: AppRoutes.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn?UserListPage(): RegisterPage(),
    );
  }
}
