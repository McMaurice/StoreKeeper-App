import 'package:flutter/material.dart';

Widget customButton(
  String title,
  Color color,
  IconData? icon,
  VoidCallback onPressed,
) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: () {
      onPressed();
    },
    icon: Icon(icon, color: Colors.white),
    label: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
