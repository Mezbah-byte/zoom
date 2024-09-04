import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/video_call_controller.dart';

class VideoCallPage extends StatelessWidget {
  final VideoCallController _controller = Get.find<VideoCallController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Call')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            
          },
          child: Text('Start Call'),
        ),
      ),
    );
  }
}
