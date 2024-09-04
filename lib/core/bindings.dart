import 'package:get/get.dart';
import 'package:zoom/features/auth/presentation/controllers/auth_controller.dart';
import 'package:zoom/features/user/presentation/controllers/user_controller.dart';
import 'package:zoom/features/video_call/presentation/controllers/call_controller.dart';
import 'package:zoom/features/video_call/presentation/controllers/call_listener_controller.dart';
import 'package:zoom/features/video_call/presentation/controllers/video_call_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<VideoCallController>(() => VideoCallController());
    Get.lazyPut<CallController>(() => CallController());
    Get.lazyPut<CallListenerController>(() => CallListenerController());
  }
}
