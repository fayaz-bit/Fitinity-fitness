import 'package:flutter/material.dart';

Widget disabledField(String hint) {
  return TextField(
    enabled: false,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: const Color(0xFF1C1C1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

Widget uploadBoxWidget() {
  return Container(
    height: 150,
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.video_call, color: Colors.white54, size: 50),
          SizedBox(height: 10),
          Text("Drag or click to upload video",
              style: TextStyle(color: Colors.white54)),
        ],
      ),
    ),
  );
}
