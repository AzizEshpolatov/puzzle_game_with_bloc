import 'package:flutter/material.dart';

Widget alphabetButton({
  required String title,
  required VoidCallback onPressed,
}) {
  return Container(
    margin: const EdgeInsets.only(right: 10, bottom: 10),
    width: 40,
    height: 50,
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
