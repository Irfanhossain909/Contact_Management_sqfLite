import 'package:flutter/material.dart';

class NewContactPage extends StatelessWidget {
  static const String routeName = '/new';
  const NewContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
    );
  }
}
