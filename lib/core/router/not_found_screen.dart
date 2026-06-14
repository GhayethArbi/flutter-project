import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  final String route;
  const NotFoundScreen({required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Route "$route" not found',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
