import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/document_upload_controller.dart';

class DocumentUploadView extends GetView<DocumentUploadController> {
  const DocumentUploadView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CommonButton(
          padding: const EdgeInsets.only(
              left: 24, right: 24, bottom: 16),
          buttonText: "Complete",
          onTap: () {

          },
        ),
      ),
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              iconData: Icons.arrow_back,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "Driver License",
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                GetBuilder<DocumentUploadController>(
                                  assignId: true,
                                  id: "image",
                                  builder: (controller) {
                                    return Container(
                                      width: double.infinity,
                                      height: Get.width * 0.45,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              15)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(
                                              48), // Image radius
                                          child: controller.imageData == null
                                              ? Image.asset(
                                            'assets/images/mapImage.png',
                                            fit: BoxFit.cover,
                                          )
                                              : Image.file(
                                            controller.imageData !,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CommonButton(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, bottom: 5),
                                  buttonText: "Upload Photo",
                                  radius: 7,
                                  onTap: () {
                                    controller.show();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextFieldView(
                                titleText: "Card Number",
                                padding: const EdgeInsets.only(
                                    left: 2, right: 2, bottom: 10),
                                hintText: "1234 567 890",
                                keyboardType: TextInputType.number,
                                onChanged: (String txt) {},
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CommonTextFieldView(
                                titleText: "Expiration Date",
                                padding: const EdgeInsets.only(
                                    left: 2, right: 2, bottom: 10),
                                hintText: "MM//DD/YYYY",
                                keyboardType: TextInputType.number,
                                onChanged: (String txt) {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // height: 50,
                        color: Colors.red,
                        // width: Screen.width(context),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
