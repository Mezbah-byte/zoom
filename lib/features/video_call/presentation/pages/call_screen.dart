import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallScreen extends StatelessWidget {
  final String callId;

  CallScreen({required this.callId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongoing Call'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Ongoing call with ID: $callId'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to end the call
              },
              child: Text('End Call'),
            ),
          ],
        ),
      ),
    );
  }
}
