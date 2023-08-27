import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bluetoothscreen_controller.dart';

class BluetoothscreenView extends GetView<BluetoothscreenController> {
  const BluetoothscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BluetoothscreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BluetoothscreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
