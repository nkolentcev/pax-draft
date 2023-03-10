import 'package:flutter/material.dart';

import 'models/user_model.dart';

class WorkScreen extends StatelessWidget {
  final Users user;
  WorkScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('${this.user.name}'),
      ),
    );
  }
}
