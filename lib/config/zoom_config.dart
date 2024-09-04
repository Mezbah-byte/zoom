import 'package:flutter/material.dart';
// import 'package:flutter_zoom_sdk/zoom_options.dart';
// import 'package:flutter_zoom_sdk/zoom_view.dart';

class ZoomConfig {
  static final String _sdkKey = '4EWtf96CozmNxQwZu5LWO3gvojDqCJAq963S';
  static final String _sdkSecret = '2GEaEgblthLBOYcKjz6rbXswWsQgYMOyHrYu';

  // static Future<void> initialize() async {
  //   try {
  //     ZoomOptions options = ZoomOptions(
  //       domain: "zoom.us",
  //       appKey: _sdkKey,
  //       appSecret: _sdkSecret,
  //     );

  //     ZoomView zoom = ZoomView();
  //     zoom.initZoom(options)
  //         .then((results) {
  //       if (results[0] == 0) {
  //         debugPrint("Zoom SDK initialized successfully.");
  //       } else {
  //         debugPrint("Failed to initialize Zoom SDK: ${results[0]}");
  //       }
  //     }).catchError((error) {
  //       debugPrint("Error initializing Zoom SDK: $error");
  //     });
  //   } catch (e) {
  //     debugPrint("Unexpected error during Zoom SDK initialization: $e");
  //   }
  // }
}
