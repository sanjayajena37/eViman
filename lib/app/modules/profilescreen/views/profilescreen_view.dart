import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dateplan/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/CustomeTittleText.dart';
import '../../../widgets/Textfield_widget.dart';
import '../../../widgets/UploadDocumentWidget.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/profilescreen_controller.dart';

class ProfilescreenView extends GetView<ProfilescreenController> {
  ProfilescreenView({Key? key}) : super(key: key);

  ProfilescreenController controllerX =
      Get.put<ProfilescreenController>(ProfilescreenController());

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
                            controller.update(['ref', 'button']);
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
                                    GetBuilder<ProfilescreenController>(
                                      assignId: true,
                                      id: "profile",
                                      builder: (controllerX) {
                                        return Container(
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
                                                        size: const Size
                                                                .fromRadius(
                                                            50), // Image radius
                                                        child: controllerX
                                                                    .imageData ==
                                                                null
                                                            ? (controllerX.profileImageUrl !=
                                                                        null &&
                                                                    controllerX
                                                                            .profileImageUrl
                                                                            .toString()
                                                                            .trim() !=
                                                                        "")
                                                                ? CachedNetworkImage(
                                                                    imageUrl:
                                                                        controllerX.profileImageUrl ??
                                                                            "",
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                                                                      ),
                                                                    ),
                                                                    progressIndicatorBuilder: (context,
                                                                            url,
                                                                            downloadProgress) =>
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.06,
                                                                          width:
                                                                              Get.width * 0.2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(18.0),
                                                                            child:
                                                                                CircularProgressIndicator(value: downloadProgress.progress),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                  )
                                                                : Image.asset(
                                                                    'assets/images/man.jpg',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                            : Image.file(
                                                                controllerX
                                                                    .imageData!,
                                                                fit: BoxFit
                                                                    .cover,
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
                                                            controllerX.show(
                                                                profile: true);
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Get.width /
                                                                              2)),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .camera_alt,
                                                                  // color: primaryColor,
                                                                  size: 18,
                                                                ),
                                                              )),
                                                        ))
                                              ]),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Obx(() {
                                      return CustomeTittleText(
                                        text: controllerX.userName?.value ??
                                            "Eviman Driver",
                                        fontWeight: FontWeight.w600,
                                      );
                                    }),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomeSubTittleText(
                                      text: "Golden Member",
                                      textsize: 13,
                                      color: Colors.grey.shade500,
                                    ),
                                    Obx(() {
                                      return Container(
                                          child: (controllerX
                                                      .activeStatus?.value ??
                                                  false)
                                              ? CustomeSubTittleText(
                                                  text: "Online",
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                )
                                              : CustomeSubTittleText(
                                                  text: "Offline",
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600,
                                                ));
                                    }),
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: profileInfoList.length,
                                      padding: EdgeInsets.all(2),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12,
                                              left: 12,
                                              top: 0,
                                              bottom: 0),
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
                                                isEnabled:
                                                    controllerX.isEnabled,
                                                validator: (_) {},
                                                hint: profileInfoList[index]
                                                    .hinTetxt
                                                    .toString(),
                                                textController: controllerX
                                                        .textEditingController[
                                                    index],
                                              ),
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
                              child: GetBuilder<ProfilescreenController>(
                                assignId: true,
                                id: "document",
                                builder: (controllerX) {
                                  return Column(
                                    children: [
                                      GetBuilder<ProfilescreenController>(
                                        assignId: true,
                                        id: "dl",
                                        builder: (controllerX) {
                                          return UploadDocumentAndView(
                                              fileData: controllerX.dlImage,
                                              imageUrl: controllerX.dlImageUrl,
                                              buttonText: "Upload DL",
                                              callback: () {
                                                controllerX.show(dl: true);
                                              });
                                        },
                                      ),
                                      GetBuilder<ProfilescreenController>(
                                        assignId: true,
                                        id: "aadhaar",
                                        builder: (controllerX) {
                                          return UploadDocumentAndView(
                                              fileData:
                                                  controllerX.aadhaarImage,
                                              imageUrl:
                                                  controllerX.aadhaarImageUrl,
                                              buttonText: "Upload Aadhaar",
                                              callback: () {
                                                controllerX.show(aadhaar: true);
                                              });
                                        },
                                      ),
                                      GetBuilder<ProfilescreenController>(
                                        assignId: true,
                                        id: "pan",
                                        builder: (logic) {
                                          return UploadDocumentAndView(
                                              fileData: controllerX.panImage,
                                              imageUrl: controllerX.panImageUrl,
                                              buttonText: "Upload PAN",
                                              callback: () {
                                                controllerX.show(pan: true);
                                              });
                                        },
                                      ),
                                    ],
                                  );
                                },
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
      bottomNavigationBar: GetBuilder<ProfilescreenController>(
        assignId: true,
        id: "button",
        builder: (controllerX) {
          return Container(
            child: (controllerX.isEnabled == true)
                ? CommonButton(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                    buttonText: "Update",
                    onTap: () {
                      controllerX.updateApi();
                    },
                  )
                : Container(
                    child: Text(""),
                  ),
          );
        },
      ),
    );
  }
}
