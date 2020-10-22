import 'package:flutter/material.dart';

class BottomSheetBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 70,
      margin: EdgeInsets.all(12.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey,
      ),
    );
  }
}
