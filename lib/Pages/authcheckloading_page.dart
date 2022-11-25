import 'package:flutter/material.dart';

class AuthCheckLoadingPage extends StatelessWidget {
  const AuthCheckLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
}