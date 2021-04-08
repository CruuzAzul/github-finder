import 'package:flutter/material.dart';

class AdditionalLabel extends StatelessWidget {
  const AdditionalLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey[500],
      ),
    );
  }
}
