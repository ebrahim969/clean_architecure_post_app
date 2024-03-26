import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.txt,
    this.onPressed,
  });

  final String txt;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 50,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(30)),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            txt,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
