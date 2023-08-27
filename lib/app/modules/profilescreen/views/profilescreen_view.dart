import 'dart:io';

import 'package:dateplan/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/Textfield_widget.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/profilescreen_controller.dart';

class ProfilescreenView extends GetView<ProfilescreenController> {
  ProfilescreenView({Key? key}) : super(key: key);

  ProfilescreenController controllerX = Get.find<ProfilescreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder<ProfilescreenController>(
            id: "ref",
            builder: (controllerX) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonAppbarView(
                        iconData: Icons.arrow_back,
                        onBackClick: () {
                          Navigator.pop(context);
                        },
                        titleText: "Profile",
                      ),
                      InkWell(
                          onTap: () {
                            controller.isEnabled = !controller.isEnabled;
                            controller.update(['ref']);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon((controller.isEnabled)
                                ? Icons.save
                                : Icons.mode_edit_outline_rounded),
                          )),
                    ],
                  ),
                  Expanded(
                    child:
                    NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.grey.shade300),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Stack(
                                          alignment: Alignment.center,
                                          fit: StackFit.loose,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                ClipOval(
                                                  child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(
                                                        50), // Image radius
                                                    child: controllerX
                                                        .imageData ==
                                                        null
                                                        ? Image.asset(
                                                      'assets/images/avatar2.jpg',
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Image.file(
                                                      controllerX
                                                          .imageData!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            controllerX.isEnabled == false
                                                ? const SizedBox()
                                                : Positioned(
                                                bottom: 0,
                                                left: Get.width / 2.2,
                                                child: InkWell(
                                                  onTap: () {
                                                    controllerX.show();
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                          Colors.white,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey
                                                                  .shade200),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              Get.width /
                                                                  2)),
                                                      child: const Padding(
                                                        padding:
                                                        EdgeInsets.all(
                                                            10.0),
                                                        child: Icon(
                                                          Icons.camera_alt,
                                                          // color: primaryColor,
                                                          size: 18,
                                                        ),
                                                      )),
                                                ))
                                          ]),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomeTittleText(
                                      text: "Eviman Driver",
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomeSubTittleText(
                                      text: "Golden Member",
                                      textsize: 13,
                                      color: Colors.grey.shade500,
                                    ),
                                    CustomeSubTittleText(
                                      text: "Online",
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,

                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width,
                              color: Colors.grey.shade200,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 15,
                                ),
                                child: CustomeSubTittleText(
                                  text: "Information",
                                  textsize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (overscroll) {
                                  overscroll.disallowGlow();
                                  return true;
                                },
                                child: GetBuilder<ProfilescreenController>(
                                  assignId: true,
                                  id: "inform",
                                  builder: (controllerX) {
                                    return ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: profileInfoList.length,padding: EdgeInsets.all(2),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12, left: 12, top: 0,bottom: 0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              CustomeSubTittleText(
                                                text: profileInfoList[index]
                                                    .tittle
                                                    .toString(),
                                                textsize: 13,
                                                color: Colors.grey.shade500,
                                              ),
                                              const SizedBox(
                                                height: 05,
                                              ),
                                              Textfield_widget(
                                                  isOutlineBorder: true,
                                                  isEnabled: controllerX
                                                      .isEnabled,
                                                  validator: (_) {},
                                                  hint: profileInfoList[index]
                                                      .hinTetxt
                                                      .toString()),
                                              const SizedBox(
                                                height: 05,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 10,
                              color: Colors.white,
                            ),
                            Container(
                              width: Get.width,
                              color: Colors.grey.shade200,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 15,
                                ),
                                child: CustomeSubTittleText(
                                  text: "Documnet Info",
                                  textsize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: controllerX.isEnabled == false
                                        ? () {}
                                        : () {
                                      print("Aadhaar card");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12, left: 12, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomeSubTittleText(
                                            text: "Aadhaar No",
                                            textsize: 13,
                                            color: Colors.grey.shade500,
                                          ),
                                          const SizedBox(
                                            height: 05,
                                          ),
                                          Textfield_widget(
                                            isOutlineBorder: true,
                                            cursorwidth: 0,
                                            isEnabled: false,
                                            validator: (_) {},
                                            hint: "XXXX XXXX XXXX 4566",
                                            sufiixIcon:
                                            controllerX.isEnabled == false
                                                ? const SizedBox()
                                                : const Icon(
                                              Icons.upload,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 05,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: controllerX.isEnabled == false
                                        ? () {}
                                        : () {
                                      print("pan card");
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12, left: 12, top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            CustomeSubTittleText(
                                              text: "PAN No",
                                              textsize: 13,
                                              color: Colors.grey.shade500,
                                            ),
                                            const SizedBox(
                                              height: 05,
                                            ),
                                            Textfield_widget(
                                              isOutlineBorder: true,
                                              cursorwidth: 0,
                                              isEnabled: false,
                                              inputType: TextInputType.none,
                                              validator: (_) {},
                                              hint: "ABCD1234A",
                                              sufiixIcon:
                                              controllerX.isEnabled == false
                                                  ? const SizedBox()
                                                  : const Icon(
                                                Icons.upload,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 05,
                                            ),
                                          ],
                                        )),
                                  ),
                                  InkWell(
                                    onTap: controllerX.isEnabled == false
                                        ? () {}
                                        : () {
                                      Get.toNamed(Routes.DOCUMENT_UPLOAD);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12, left: 12, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomeSubTittleText(
                                            text: "Driving Lisence",
                                            textsize: 13,
                                            color: Colors.grey.shade500,
                                          ),
                                          const SizedBox(
                                            height: 05,
                                          ),
                                          Textfield_widget(
                                            isOutlineBorder: true,
                                            cursorwidth: 0,
                                            isEnabled: false,
                                            inputType: TextInputType.none,
                                            validator: (_) {},
                                            hint: "DL-XXXXXXXXX",
                                            sufiixIcon:
                                            controllerX.isEnabled == false
                                                ? const SizedBox()
                                                : const Icon(
                                              Icons.upload,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: controllerX.isEnabled == false
                                        ? () {}
                                        : () {
                                      print("ATM card");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 12, left: 12, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomeSubTittleText(
                                            text: "Bank Account Detaiils",
                                            textsize: 13,
                                            color: Colors.grey.shade500,
                                          ),
                                          const SizedBox(
                                            height: 05,
                                          ),
                                          Textfield_widget(
                                            isOutlineBorder: true,
                                            cursorwidth: 0,
                                            isEnabled: false,
                                            inputType: TextInputType.none,
                                            validator: (_) {},
                                            hint: "1234 XXXX XXXX 4578",
                                            sufiixIcon:
                                            controllerX.isEnabled == false
                                                ? const SizedBox()
                                                : const Icon(
                                              Icons.upload,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
