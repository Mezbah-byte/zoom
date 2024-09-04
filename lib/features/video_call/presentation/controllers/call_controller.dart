import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CallController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createCallRequest(String callerId, String receiverId) async {
    try {
      await _firestore.collection('calls').add({
        'callerId': callerId,
        'receiverId': receiverId,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to create call request: $e');
    }
  }
}
