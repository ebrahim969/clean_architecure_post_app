import 'package:flutter/material.dart';

class MessageDisplayWidget extends StatelessWidget {
  const MessageDisplayWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Text(message),
        ),
      ),
    );
  }
}
