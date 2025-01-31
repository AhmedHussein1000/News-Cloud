import 'package:flutter/material.dart';

class NoRouteDefinedScreen extends StatelessWidget {
  const NoRouteDefinedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'No Route Defined',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
