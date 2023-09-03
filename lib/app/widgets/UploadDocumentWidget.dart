import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common_button.dart';

class UploadDocumentAndView extends StatelessWidget {
  final File? fileData;
  final String? imageUrl;
  final VoidCallback? callback;
  const UploadDocumentAndView(
      {super.key, this.fileData, this.imageUrl, this.callback});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 7,
              spreadRadius: 2, //New
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.width * 0.45,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: fileData == null
                      ? (imageUrl != null && imageUrl.toString().trim() != "")
                          ? CachedNetworkImage(
                              imageUrl: imageUrl ?? "",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,),
                                ),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.06,
                                    width: size.width * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                  ),
                                ],
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : Image.asset(
                              'assets/images/id-card.png',
                              fit: BoxFit.cover,
                            )
                      : Image.file(
                          fileData!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CommonButton(
              padding: const EdgeInsets.only(left: 4, right: 4, bottom: 5),
              buttonText: "Upload Document",
              radius: 7,
              onTap: callback,
            ),
          ],
        ),
      ),
    );
  }
}
