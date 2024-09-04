import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zoom/features/video_call/presentation/pages/incoming_call_page.dart';

class CallListenerController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    _listenForIncomingCalls();
  }

  void _listenForIncomingCalls() {
  final String userId = _auth.currentUser!.uid;
  print(userId);
  _firestore.collection('calls')
    .where('receiverId', isEqualTo: userId)
    .where('status', isEqualTo: 'pending')
    .snapshots()
    .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final callData = doc.data(); // The call data
          final callId = doc.id; // The document ID of the call
          showIncomingCallInterface(callData, callId);
        }
      }
    });
}


  void showIncomingCallInterface(Map<String, dynamic> callData, String callId) {
    Get.to(() => IncomingCallPage(callData: callData, callId: callId,));
  }
}
