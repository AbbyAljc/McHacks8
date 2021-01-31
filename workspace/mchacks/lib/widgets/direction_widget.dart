import 'package:flutter/material.dart';

class DirectionTile extends StatelessWidget {
  final String content;

  DirectionTile({this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Icon(Icons.circle, size: 12)),
          Expanded(flex: 9, child: Text(content)),
        ],
      ),
    );
  }
}
