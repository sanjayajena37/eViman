import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/image_details_page_controller.dart';

class ImageDetailsPageView extends GetView<ImageDetailsPageController> {
  const ImageDetailsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImageDetailsPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ImageDetailsPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
