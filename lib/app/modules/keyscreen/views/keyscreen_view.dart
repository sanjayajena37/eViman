import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/keyscreen_controller.dart';

class KeyscreenView extends GetView<KeyscreenController> {
  const KeyscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeyscreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KeyscreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
