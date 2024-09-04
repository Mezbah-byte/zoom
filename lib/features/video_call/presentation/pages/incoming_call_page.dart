import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom/features/video_call/presentation/pages/call_screen.dart';

class IncomingCallPage extends StatefulWidget {
  final Map<String, dynamic> callData;
  final String callId;

  IncomingCallPage({required this.callData, required this.callId});

  @override
  _IncomingCallPageState createState() => _IncomingCallPageState();
}

class _IncomingCallPageState extends State<IncomingCallPage> {
  late Timer _statusCheckTimer;

  @override
  void initState() {
    super.initState();
    _startStatusCheck();
  }

  @override
  void dispose() {
    _statusCheckTimer.cancel();
    super.dispose();
  }

  void _startStatusCheck() {
    _statusCheckTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      final callDoc = await FirebaseFirestore.instance.collection('calls').doc(widget.callId).get();
      final callData = callDoc.data();

      if (callData != null) {
        if (callData['status'] == 'accepted') {
          // Navigate to CallScreen
          Get.to(() => CallScreen(callId: widget.callId));
          _statusCheckTimer.cancel(); // Stop the timer
        } else if (callData['status'] == 'rejected' || callData['status'] == 'canceled') {
          // Call was rejected or canceled
          Get.back(); // Go back to the previous screen
          _statusCheckTimer.cancel(); // Stop the timer
        }
      } else {
        // Call data no longer exists
        Get.back(); // Go back to the previous screen
        _statusCheckTimer.cancel(); // Stop the timer
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incoming Call'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Incoming call from ${widget.callData['callerId']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final success = await _updateCallStatus(widget.callId, widget.callData['receiverId'], 'accepted');
                if (success) {
                  Get.to(() => CallScreen(callId: widget.callId));
                }
              },
              child: Text('Accept'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final success = await _updateCallStatus(widget.callId, widget.callData['receiverId'], 'rejected');
                if (success) {
                  Get.back();
                }
              },
              child: Text('Reject'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _updateCallStatus(String callId, String myUid, String status) async {
    try {
      final callDoc = await FirebaseFirestore.instance.collection('calls').doc(callId).get();
      final callData = callDoc.data();

      if (callData != null) {
        if (callData['callerId'] == myUid || callData['receiverId'] == myUid) {
          if (callData['status'] == 'pending') {
            await FirebaseFirestore.instance.collection('calls').doc(callId).update({
              'status': status,
            });
            Get.snackbar('Success', 'Call status updated to $status');
            return true;
          } else {
            Get.snackbar('Error', 'Call is no longer pending');
            return false;
          }
        } else {
          Get.snackbar('Error', 'You are not authorized to update this call');
          return false;
        }
      } else {
        Get.snackbar('Error', 'Call not found');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update call status');
      return false;
    }
  }
}
