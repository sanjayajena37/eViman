import 'package:dateplan/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/text_styles.dart';
import '../../../widgets/DropDown.dart';
import '../../../widgets/KeyvalueModel.dart';
import '../../../widgets/MapPopup.dart';
import '../../../widgets/Snack.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field_view.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/kycscreen_controller.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:lottie/lottie.dart' as lottie;

class KycscreenView extends GetView<KycscreenController> {
  KycscreenView({Key? key}) : super(key: key);

  @override
  KycscreenController controller =
  Get.put<KycscreenController>(KycscreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('KYC'),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder<KycscreenController>(
          assignId: true,
          id: "all",
          builder: (controller) {
            return Container(
              child: GetBuilder<
                  KycscreenController>(
                assignId: true,
                id: "ref",
                builder: (logic) {
                  return Stepper(
                    currentStep: controller.currentStep,
                    onStepContinue: controller.continueStep,
                    onStepCancel: controller.cancelStep,
                    onStepTapped: controller.onStepTapped,
                    controlsBuilder: controller.controlsBuilder,
                    physics: ClampingScrollPhysics(),
                    type: StepperType.horizontal,
                    elevation: 2,
                    steps: [
                      Step(
                          title: const Text("Step 1"),
                          content: GetBuilder<KycscreenController>(
                            assignId: true,
                            id: "step1",
                            builder: (logic) {
                              return Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      controller.locationDetail =
                                      await Get.dialog(
                                        MapPopup(),
                                        barrierDismissible: true,
                                      );

                                      if (controller.locationDetail
                                          .isNotEmpty) {
                                        controller.update(['loc']);
                                        controller
                                            .getLocationDetailsFromLatLong1(
                                            controller.locationDetail);
                                      }
                                    },
                                    child: const Text('Select Your Location'),
                                  ),
                                  CommonTextFieldView(
                                    titleText: "First Name",
                                    contextNew: context,
                                    errorText: controller.errorFirstName,
                                    controller: controller.firstNameController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2, top: 0),
                                    hintText: "enter your First Name",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                    pad: 16,
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Last Name",
                                    contextNew: context,
                                    errorText: controller.errorLastName,
                                    controller: controller.lastNameController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your Last Name",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Email",
                                    contextNew: context,
                                    errorText: controller.errorEmail,
                                    controller: controller.emailController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your email",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Mobile",
                                    contextNew: context,
                                    errorText: controller.errorMobile,
                                    controller: controller.mobileController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your mobile",
                                    keyboardType: TextInputType.number,
                                    enable: false,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Address1",
                                    contextNew: context,
                                    errorText: controller.errorAddress1,
                                    controller: controller.address1Controller,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2, top: 0),
                                    hintText: "enter your Address1",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                    pad: 16,
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Address2",
                                    contextNew: context,
                                    errorText: controller.errorAddress2,
                                    controller: controller.address2Controller,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your Address2",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "City",
                                    contextNew: context,
                                    errorText: controller.errorCity,
                                    controller: controller.cityController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your City",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "State",
                                    contextNew: context,
                                    errorText: controller.errorState,
                                    controller: controller.stateController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your State",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Country",
                                    contextNew: context,
                                    errorText: controller.errorCountry,
                                    controller: controller.countryController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your Country",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Pin",
                                    contextNew: context,
                                    errorText: controller.errorPin,
                                    controller: controller.pinController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your Pin",
                                    keyboardType: TextInputType.number,
                                    onChanged: (String txt) {},
                                  ),
                                ],
                              );
                            },
                          ),
                          isActive: controller.currentStep >= 0,
                          state: controller.currentStep >= 0
                              ? StepState.complete
                              : StepState.disabled),
                      Step(
                          title: Text("Step 2"),
                          content: GetBuilder<KycscreenController>(
                            assignId: true,
                            id: "step1",
                            builder: (logic) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(15),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/background1.jpg")),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 7,
                                          spreadRadius: 2, //New
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 4,
                                          ),
                                          GetBuilder<KycscreenController>(
                                            assignId: true,
                                            id: "image0",
                                            builder: (controller) {
                                              return Container(
                                                width: Get.width * 0.35,
                                                height: Get.height * 0.16,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(50)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  child: SizedBox.fromSize(
                                                      size: const Size
                                                          .fromRadius(
                                                          50), // Image radius
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                        child: ClipOval(
                                                          child: SizedBox
                                                              .fromSize(
                                                            size: const Size
                                                                .fromRadius(
                                                                50),
                                                            // Image radius
                                                            child: controller
                                                                .profileImage ==
                                                                null
                                                                ? Image.asset(
                                                              'assets/images/man.jpg',
                                                              fit: BoxFit.cover,
                                                            )
                                                                : Image.file(
                                                              controller
                                                                  .profileImage!,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
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
                                            buttonText: "Upload Profile Picture",
                                            radius: 7,
                                            onTap: () {
                                              controller.show(profile: true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
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
                                          GetBuilder<KycscreenController>(
                                            assignId: true,
                                            id: "image1",
                                            builder: (controller) {
                                              return Container(
                                                width: double.infinity,
                                                height: Get.width * 0.45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(
                                                        48), // Image radius
                                                    child: controller
                                                        .imageData1 ==
                                                        null
                                                        ? Image.asset(
                                                      'assets/images/id-card.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Image.file(
                                                      controller.imageData1!,
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
                                            buttonText: "Upload DL Image",
                                            radius: 7,
                                            onTap: () {
                                              controller.show(dl: true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
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
                                          GetBuilder<KycscreenController>(
                                            assignId: true,
                                            id: "image2",
                                            builder: (controller) {
                                              return Container(
                                                width: double.infinity,
                                                height: Get.width * 0.45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(
                                                        48), // Image radius
                                                    child: controller
                                                        .imageData2 ==
                                                        null
                                                        ? Image.asset(
                                                      'assets/images/id-card.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Image.file(
                                                      controller.imageData2!,
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
                                            buttonText: "Upload Aadhaar Image",
                                            radius: 7,
                                            onTap: () {
                                              controller.show(aadhaar: true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
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
                                          GetBuilder<KycscreenController>(
                                            assignId: true,
                                            id: "image3",
                                            builder: (controller) {
                                              return Container(
                                                width: double.infinity,
                                                height: Get.width * 0.45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(
                                                        48), // Image radius
                                                    child: controller
                                                        .imageData3 ==
                                                        null
                                                        ? Image.asset(
                                                      'assets/images/id-card.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Image.file(
                                                      controller.imageData3!,
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
                                            buttonText: "Upload Pan Image",
                                            radius: 7,
                                            onTap: () {
                                              controller.show(pan: true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          isActive: controller.currentStep >= 1,
                          state: controller.currentStep >= 1
                              ? StepState.complete
                              : StepState.disabled),
                      Step(
                          title: Text("Step 3"),
                          content: GetBuilder<KycscreenController>(
                            assignId: true,
                            id: "step3",
                            builder: (logic) {
                              return Column(
                                children: [
                                  GetBuilder<KycscreenController>(
                                      id: "loc",
                                      builder: (controller) {
                                        return Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text("Lat: "),
                                            Text(
                                                controller.locationDetail['lat']
                                                    .toString())
                                          ],
                                        );
                                      }),
                                  GetBuilder<KycscreenController>(
                                      id: "loc",
                                      builder: (controller) {
                                        return Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text("Lng: "),
                                            Text(
                                                controller.locationDetail['lng']
                                                    .toString())
                                          ],
                                        );
                                      }),
                                  ElevatedButton(
                                    onPressed: () async {
                                      controller.locationDetail =
                                      await Get.dialog(
                                        MapPopup(),
                                        barrierDismissible: true,
                                      );

                                      if (controller.locationDetail
                                          .isNotEmpty) {
                                        controller.update(['loc']);
                                        controller
                                            .getLocationDetailsFromLatLong(
                                            controller.locationDetail);
                                      }
                                    },
                                    child: const Text('Select Your Location'),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    shadowColor: Colors.grey.withOpacity(
                                      Theme
                                          .of(context)
                                          .brightness == Brightness.dark
                                          ? 0.6
                                          : 0.6,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GetBuilder<KycscreenController>(
                                        assignId: true,
                                        id: "userTy",
                                        builder: (logic) {
                                          return SizedBox(
                                              height: 35,
                                              child: Center(
                                                child: DropDown.staticDropdown(
                                                    "User Type",
                                                    "userType",
                                                    controller
                                                        .userTypeList,
                                                        (KeyvalueModel val) {
                                                      controller
                                                          .userTypeController
                                                          .text = val.key;
                                                    }),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  CommonTextFieldView(
                                    titleText: "RegDNumber",
                                    contextNew: context,
                                    errorText: controller.errorRegNo,
                                    controller: controller.regNumberController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2, top: 0),
                                    hintText: "enter your RegDNumber",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                    pad: 16,
                                  ),
                                  CommonTextFieldView(
                                    titleText: "ChassisNumber",
                                    contextNew: context,
                                    errorText: controller.errorChassis,
                                    controller: controller
                                        .chasisNumberController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2, top: 0),
                                    hintText: "enter your ChassisNumber",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                    pad: 16,
                                  ),
                                  CommonTextFieldView(
                                    titleText: "EngineNumber",
                                    contextNew: context,
                                    errorText: controller.errorEngineNum,
                                    controller: controller
                                        .engineNumberController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2, top: 0),
                                    hintText: "enter your EngineNumber",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                    pad: 16,
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Vehicle Name",
                                    contextNew: context,
                                    errorText: controller.errorVehicleName,
                                    controller: controller
                                        .vehicleNameController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2, top: 0),
                                    hintText: "enter your vehicle name",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                    pad: 16,
                                  ),
                                  CommonTextFieldView(
                                    titleText: "ownerName",
                                    contextNew: context,
                                    errorText: controller.errorOwnerName,
                                    controller: controller
                                        .ownerNumberController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2, top: 0),
                                    hintText: "enter ownerName",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                    pad: 16,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
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
                                          GetBuilder<KycscreenController>(
                                            assignId: true,
                                            id: "image4",
                                            builder: (controller) {
                                              return Container(
                                                width: double.infinity,
                                                height: Get.width * 0.45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(
                                                        48), // Image radius
                                                    child: controller
                                                        .imageDataRc ==
                                                        null
                                                        ? Image.asset(
                                                      'assets/images/id-card.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Image.file(
                                                      controller.imageDataRc!,
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
                                            buttonText: "Upload RC",
                                            radius: 7,
                                            onTap: () {
                                              controller.show(rc: true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
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
                                          GetBuilder<KycscreenController>(
                                            assignId: true,
                                            id: "image5",
                                            builder: (controller) {
                                              return Container(
                                                width: double.infinity,
                                                height: Get.width * 0.45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(
                                                        48), // Image radius
                                                    child:
                                                    controller
                                                        .imageDataVehicle ==
                                                        null
                                                        ? Image.asset(
                                                      'assets/images/id-card.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Image.file(
                                                      controller
                                                          .imageDataVehicle!,
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
                                            buttonText: "Upload Vehicle Image",
                                            radius: 7,
                                            onTap: () {
                                              controller.show(vehicle: true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
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
                                          GetBuilder<KycscreenController>(
                                            assignId: true,
                                            id: "image6",
                                            builder: (controller) {
                                              return Container(
                                                width: double.infinity,
                                                height: Get.width * 0.45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(
                                                        48), // Image radius
                                                    child: controller
                                                        .imageDataInsurance ==
                                                        null
                                                        ? Image.asset(
                                                      'assets/images/id-card.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Image.file(
                                                      controller
                                                          .imageDataInsurance!,
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
                                            buttonText: "Upload Insurance Image",
                                            radius: 7,
                                            onTap: () {
                                              controller.show(insurance: true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
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
                                          GetBuilder<KycscreenController>(
                                            assignId: true,
                                            id: "image7",
                                            builder: (controller) {
                                              return Container(
                                                width: double.infinity,
                                                height: Get.width * 0.45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  child: SizedBox.fromSize(
                                                    size: const Size.fromRadius(
                                                        48), // Image radius
                                                    child: controller
                                                        .imageDataPollution ==
                                                        null
                                                        ? Image.asset(
                                                      'assets/images/id-card.png',
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Image.file(
                                                      controller
                                                          .imageDataPollution!,
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
                                            buttonText: "Upload Pollution Image",
                                            radius: 7,
                                            onTap: () {
                                              controller.show(pollution: true);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    shadowColor: Colors.grey.withOpacity(
                                      Theme
                                          .of(context)
                                          .brightness == Brightness.dark
                                          ? 0.6
                                          : 0.6,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          height: 35,
                                          child: Center(
                                            child: DropDown.staticDropdown(
                                                "Select Vehicle Type",
                                                "vehicle",
                                                controller.vehicleTypeList,
                                                    (KeyvalueModel val) {
                                                  controller
                                                      .vehicleTypeController
                                                      .text = val.key;
                                                  controller.filterSubType(
                                                      val.key);
                                                }),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    shadowColor: Colors.grey.withOpacity(
                                      Theme
                                          .of(context)
                                          .brightness == Brightness.dark
                                          ? 0.6
                                          : 0.6,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GetBuilder<KycscreenController>(
                                        assignId: true,
                                        id: "subt",
                                        builder: (logic) {
                                          return SizedBox(
                                              height: 35,
                                              child: Center(
                                                child: DropDown.staticDropdown(
                                                    "Select Vehicle Sub-Type",
                                                    "vehicle",
                                                    controller
                                                        .subVehicleTypeList,
                                                        (KeyvalueModel val) {
                                                      controller
                                                          .vehicleSubTypeController
                                                          .text = val.key;
                                                    }),
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),



                                  /* CommonTextFieldView(
                                titleText: "Vehicle Type",
                                contextNew: context,
                                errorText: controller.errorVehicleType,
                                controller: controller.vehicleTypeController,
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, bottom: 2, top: 0),
                                hintText: "enter your Vehicle Type",
                                keyboardType: TextInputType.text,
                                onChanged: (String txt) {},
                                pad: 16,
                              ),
                              CommonTextFieldView(
                                titleText: "Vehicle SubType",
                                contextNew: context,
                                errorText: controller.errorVehicleSubType,
                                controller: controller.vehicleSubTypeController,
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, bottom: 2, top: 0),
                                hintText: "enter your Vehicle SubType",
                                keyboardType: TextInputType.text,
                                onChanged: (String txt) {},
                                pad: 16,
                              ),*/
                                  CommonTextFieldView(
                                    titleText: "Address1",
                                    contextNew: context,
                                    errorText: controller.errorVehicleAddress1,
                                    controller: controller
                                        .address1VehicleController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2, top: 0),
                                    hintText: "enter your Address1",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                    pad: 16,
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Address2",
                                    contextNew: context,
                                    errorText: controller.errorVehicleAddress2,
                                    controller: controller
                                        .address2VehicleController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your Address2",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "City",
                                    contextNew: context,
                                    errorText: controller.errorVehicleCity,
                                    controller: controller
                                        .cityVehicleController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your City",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "State",
                                    contextNew: context,
                                    errorText: controller.errorVehicleState,
                                    controller: controller
                                        .stateVehicleController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your State",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Country",
                                    contextNew: context,
                                    errorText: controller.errorVehicleCountry,
                                    controller: controller
                                        .countryVehicleController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your Country",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Pin",
                                    contextNew: context,
                                    errorText: controller.errorVehiclePin,
                                    controller: controller.pinVehicleController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your Pin",
                                    keyboardType: TextInputType.number,
                                    onChanged: (String txt) {},
                                  ),
                                  CommonTextFieldView(
                                    titleText: "Current City",
                                    contextNew: context,
                                    errorText: controller
                                        .errorVehicleCurrentCity,
                                    controller:
                                    controller.currentCityVehicleController,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 2),
                                    hintText: "enter your Current City",
                                    keyboardType: TextInputType.text,
                                    onChanged: (String txt) {},
                                  ),
                                ],
                              );
                            },
                          ),
                          isActive: controller.currentStep >= 2,
                          state: controller.currentStep >= 2
                              ? StepState.complete
                              : StepState.disabled)
                    ],
                  );
                },
              )
            );
          },
        ),
      ),
      bottomNavigationBar: GetBuilder<KycscreenController>(
          id: "all",
          builder: (controller) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      controller.cancelStep();
                    },
                    child: Text("Back")),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      controller.continueStep();
                    },
                    child: Text("Next")),
              ),
              SizedBox(width: 10),
            ],
          )
        );
      }),
    );
  }


}
