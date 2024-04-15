import 'package:flutter/material.dart';

class DetailsRowWidget extends StatelessWidget {
  const DetailsRowWidget({super.key, required this.title, required this.details,});
  final String title;
  final String details;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(details),
        ],
      ),
    );
  }
}