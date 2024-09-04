import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:zoom/firebase_options.dart';

class FirebaseConfig {
  static bool _initialized = false;
  static Future<void> initialize() async {
    if (!_initialized) {
      try {
        await Firebase.initializeApp(options: DefaultFirebase.currentPlatform);
        _initialized = true;
      } catch (e) {
        if (kDebugMode) {
          print('Firebase initialization error: $e');
        }
      }
    }
  }
}

