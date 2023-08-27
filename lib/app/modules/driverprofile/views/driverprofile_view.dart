import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/driverprofile_controller.dart';

class DriverprofileView extends GetView<DriverprofileController> {
  const DriverprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DriverprofileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DriverprofileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
