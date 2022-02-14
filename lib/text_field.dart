import 'package:flutter/material.dart';

Widget textField(String title, String label, TextEditingController controller) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              hintText: title,
              labelStyle: TextStyle(
                color: Colors.blue,
              ),
              labelText: label),
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
