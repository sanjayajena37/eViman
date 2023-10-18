import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dateplan/app/constants/helper.dart';
import 'package:dateplan/app/widgets/Snack.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/themes.dart';
import '../../../data/ApiFactory.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/validator.dart';
import '../../../widgets/KeyvalueModel.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/common_button.dart';
import '../../ConnectorController.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart' as service;
import 'package:location/location.dart' as lo;
import 'package:permission_handler/permission_handler.dart' as permission;
import '../FareInfoModel.dart';
import 'package:geolocator/geolocator.dart' as geoLoc;

class KycscreenController extends GetxController with Helper {
  //TODO: Implement KycscreenController
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  final TextEditingController regNumberController = TextEditingController();
  final TextEditingController vehicleNameController = TextEditingController();
  final TextEditingController chasisNumberController = TextEditingController();
  final TextEditingController engineNumberController = TextEditingController();
  final TextEditingController ownerNumberController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController vehicleSubTypeController =
      TextEditingController();
  final TextEditingController address1VehicleController =
      TextEditingController();
  final TextEditingController address2VehicleController =
      TextEditingController();
  final TextEditingController cityVehicleController = TextEditingController();
  final TextEditingController stateVehicleController = TextEditingController();
  final TextEditingController countryVehicleController =
      TextEditingController();
  final TextEditingController pinVehicleController = TextEditingController();
  final TextEditingController currentCityVehicleController =
      TextEditingController();

  String? lat;
  String? lng;

  File? imageData;
  File? profileImage;
  File? imageData1;
  File? imageData2;
  File? imageData3;

  File? imageDataRc;
  File? imageDataVehicle;
  File? imageDataInsurance;
  File? imageDataPollution;

  String errorEmail = '';
  String errorMobile = '';
  String errorLastName = '';
  String errorFirstName = '';

  String errorAddress1 = '';
  String errorAddress2 = '';
  String errorCity = '';
  String errorState = '';
  String errorCountry = '';
  String errorPin = '';

  String errorRegNo = '';
  String errorChassis = '';
  String errorEngineNum = '';
  String errorVehicleName = '';
  String errorOwnerName = '';
  String errorVehicleType = '';
  String errorVehicleSubType = '';
  String errorVehicleAddress1 = '';
  String errorVehicleAddress2 = '';
  String errorVehicleCity = '';
  String errorVehicleState = '';
  String errorVehicleCountry = '';
  String errorVehiclePin = '';
  String errorVehicleCurrentCity = '';

  Dio dioIns = dio.Dio();

  String? image1;
  String? profileImg;
  String? image2;
  String? image3;

  String? image4;
  String? image5;
  String? image6;
  String? image7;

  Map<String, dynamic> locationDetail = {"details": null, "lat": 0, "lng": 0};

  bool allValidation1() {
    bool isValid = true;
    if (firstNameController.text.trim().isEmpty) {
      errorFirstName = "Please enter your first name";
      errorEmail = '';
      errorMobile = '';
      errorLastName = '';
      errorAddress1 = "";
      errorAddress2 = "";
      errorCity = "";
      errorState = "";
      errorCountry = "";
      errorPin = "";
      isValid = false;
    } else if (lastNameController.text.trim().isEmpty) {
      errorLastName = "Please enter your last name";
      errorEmail = '';
      errorMobile = '';
      errorFirstName = '';
      errorAddress1 = "";
      errorAddress2 = "";
      errorCity = "";
      errorState = "";
      errorCountry = "";
      errorPin = "";
      isValid = false;
    } else if (emailController.text.trim().isEmpty) {
      errorEmail = "Please enter your email";
      errorMobile = '';
      errorLastName = '';
      errorFirstName = '';
      errorAddress1 = "";
      errorAddress2 = "";
      errorCity = "";
      errorState = "";
      errorCountry = "";
      errorPin = "";
      isValid = false;
    }else if (Validator.validateEmail(emailController.text.trim())) {
      errorEmail = "Please enter your email";
      errorMobile = '';
      errorLastName = '';
      errorFirstName = '';
      errorAddress1 = "";
      errorAddress2 = "";
      errorCity = "";
      errorState = "";
      errorCountry = "";
      errorPin = "";
      isValid = false;
    } else if (mobileController.text.trim().isEmpty) {
      errorMobile = "Please enter your mobile";
      errorEmail = '';
      errorLastName = '';
      errorFirstName = '';
      errorAddress1 = "";
      errorAddress2 = "";
      errorCity = "";
      errorState = "";
      errorCountry = "";
      errorPin = "";
      isValid = false;
    } else if (address1Controller.text.trim().isEmpty) {
      errorAddress1 = "Please enter your address1";
      errorAddress2 = "";
      errorCity = "";
      errorState = "";
      errorCountry = "";
      errorPin = "";
      errorEmail = '';
      errorMobile = '';
      errorLastName = '';
      errorFirstName = '';
      isValid = false;
    } else if (address2Controller.text.trim().isEmpty) {
      errorAddress2 = "Please enter your address2";
      errorAddress1 = "";
      errorCity = "";
      errorState = "";
      errorCountry = "";
      errorPin = "";
      errorEmail = '';
      errorMobile = '';
      errorLastName = '';
      errorFirstName = '';
      isValid = false;
    } else if (cityController.text.trim().isEmpty) {
      errorCity = "Please enter your city";
      errorAddress1 = "";
      errorAddress2 = "";
      errorState = "";
      errorCountry = "";
      errorPin = "";
      errorEmail = '';
      errorMobile = '';
      errorLastName = '';
      errorFirstName = '';
      isValid = false;
    } else if (stateController.text.trim().isEmpty) {
      errorState = "Please enter your state";
      errorAddress1 = "";
      errorAddress2 = "";
      errorCity = "";
      errorCountry = "";
      errorPin = "";
      errorEmail = '';
      errorMobile = '';
      errorLastName = '';
      errorFirstName = '';
      isValid = false;
    } else if (countryController.text.trim().isEmpty) {
      errorCountry = "Please enter your country";
      errorAddress1 = "";
      errorAddress2 = "";
      errorCity = "";
      errorState = "";
      errorPin = "";
      errorEmail = '';
      errorMobile = '';
      errorLastName = '';
      errorFirstName = '';
      isValid = false;
    } else if (pinController.text.trim().isEmpty) {
      errorPin = "Please enter your country";
      errorAddress1 = "";
      errorAddress2 = "";
      errorCity = "";
      errorState = "";
      errorCountry = "";
      errorEmail = '';
      errorMobile = '';
      errorLastName = '';
      errorFirstName = '';
      isValid = false;
    } else {
      errorEmail = '';
      errorMobile = '';
      errorLastName = '';
      errorFirstName = '';
      errorAddress1 = "";
      errorAddress2 = "";
      errorCity = "";
      errorState = "";
      errorCountry = "";
      errorPin = "";
      isValid = true;
    }
    update(['ref']);
    return true;
  }

  bool allValidation2() {
    bool isValid = true;
    if (image1 == null) {
      isValid = false;
      Snack.callError("Please select dl");
    } else if (image2 == null) {
      isValid = false;
      Snack.callError("Please select aadhaar");
    } else if (image3 == null) {
      isValid = false;
      Snack.callError("Please select pan");
    } else {
      isValid = true;
    }
    return true;
  }

  bool allValidation3() {
    print(">>>>validation3call");
    bool isValid = true;
    if (regNumberController.text.trim().isEmpty) {
      errorRegNo = 'Please enter your regDNumber';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (chasisNumberController.text.trim().isEmpty) {
      errorChassis = 'Please enter your chassis number';
      errorRegNo = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (engineNumberController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorEngineNum = 'Please enter your engine number';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (ownerNumberController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = 'Please enter your owner name';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (vehicleNameController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleName = "Please enter vehicle name";
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (image4 == null) {
      isValid = false;
      Snack.callError("Please upload your RC");
    } else if (image5 == null) {
      isValid = false;
      Snack.callError("Please upload your Vehicle Image");
    } else if (image6 == null) {
      isValid = false;
      Snack.callError("Please upload your Insurance Image");
    } else if (image7 == null) {
      isValid = false;
      Snack.callError("Please upload your Pollution Image");
    } else if (vehicleTypeController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = 'Please enter your vehicle type';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (vehicleSubTypeController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = 'Please enter your vehicle sub type';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (address1VehicleController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = 'Please enter your vehicle address1';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (address2VehicleController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = 'Please enter your vehicle address2';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (cityVehicleController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = 'Please enter your vehicle city';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (stateVehicleController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = 'Please enter your vehicle state';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (countryVehicleController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = 'Please enter your vehicle country';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (pinVehicleController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = 'Please enter your vehicle pin';
      errorVehicleCurrentCity = '';
      isValid = false;
    } else if (currentCityVehicleController.text.trim().isEmpty) {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = 'Please enter your vehicle pin';
      isValid = false;
    } else {
      errorChassis = '';
      errorRegNo = '';
      errorChassis = '';
      errorEngineNum = '';
      errorOwnerName = '';
      errorVehicleType = '';
      errorVehicleSubType = '';
      errorVehicleAddress1 = '';
      errorVehicleAddress2 = '';
      errorVehicleCity = '';
      errorVehicleState = '';
      errorVehicleCountry = '';
      errorVehiclePin = '';
      errorVehicleCurrentCity = '';
      isValid = true;
    }

    update(['ref']);
    return isValid;
  }

  String mobile = "";
  final count = 0.obs;
  int currentStep = 0;
  int currentStep1 = 0;
  void continueStep() {
    currentStep1 = currentStep + 1;
    if ((currentStep == 0) && allValidation1()) {
      if (currentStep < 2) {
        currentStep = currentStep + 1;
      }
      update(['ref']);
    } else if ((currentStep == 1) && allValidation2()) {
      createProfile();
    } else if ((currentStep == 2) && allValidation3()) {
      if (currentStep < 2) {
        currentStep = currentStep + 1;
      }
      addVehicle();
    } else {
      update(['ref']);
      Snack.callError("Please enter your details");
    }

    print(">>>>>>>> " +
        currentStep1.toString() +
        "      " +
        currentStep.toString());
  }

  String riderId = "";
  void createProfile() {
    Map sendData = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "mobile": mobileController.text,
      "address1": address1Controller.text,
      "address2": address2Controller.text,
      "city": cityController.text,
      "state": stateController.text,
      "country": countryController.text,
      "pin": int.parse(pinController.text),
      "dl_image": image1 ?? "dlImage",
      "aadhaar_image": image2 ?? "aadhaarImage",
      "pan_image": image3 ?? "panImage",
      "profile_image": profileImg ?? ""
    };
    print(">>>>>>" + jsonEncode(sendData).toString());
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().POSTMETHOD(
        api: ApiFactory.CREATE_PROFILE,
        json: sendData,
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey('success') &&
              map['success'] == true) {
            riderId = (map['riderId'] ?? "").toString();
            print(">>>>>" + (map['riderId'] ?? "").toString());
            if (currentStep < 2) {
              currentStep = currentStep + 1;
            }
            authToken = map['authToken'];
            update(['ref']);
            Snack.callSuccess((map['message'] ?? "").toString());
          } else {
            Snack.callError(((map['errMessage'] )?? "Something went wrong").toString());
          }
          print(">>>>>" + map.toString());
        });
  }

  void addVehicle() {
    Map sendData = {
      "riderId": riderId ?? "",
      "regdNumber": regNumberController.text ?? "",
      "chasisNumber": chasisNumberController.text ?? "",
      "engineNumber": engineNumberController.text ?? "",
      "ownerName": ownerNumberController.text ?? "",
      "vehicleName": vehicleNameController.text,
      "rcImage": image4,
      "vehicleImage": image5,
      "insuranceImage": image6,
      "pollutionImage": image7,
      "vehicleType": vehicleTypeController.text ?? "",
      "vehicleSubType": vehicleSubTypeController.text ?? "",
      "address1": address1VehicleController.text ?? "",
      "address2": address2VehicleController.text ?? "",
      "city": cityVehicleController.text ?? "",
      "state": stateVehicleController.text ?? "",
      "country": countryVehicleController.text ?? "",
      "pin": pinVehicleController.text ?? "",
      "currentCity": currentCityVehicleController.text ?? '',
      "lat": locationDetail['lat'],
      "lng": locationDetail['lng']
    };
    print(">>>>>> add vehicle" + jsonEncode(sendData).toString());
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().POSTMETHOD_TOKEN(
        api: "https://backend.eviman.co.in/api/vehicles/v1/create",
        json: sendData,
        fun: (map) {
          Get.back();
          print(">>>>>>>>>" + map.toString());

          if (map is Map &&
              map.containsKey('success') &&
              map['success'] == true) {
            riderId = map['riderId'].toString();
            update(['ref']);
            if (currentStep1 > 2) {
              showUnderProcess();
            }
            Snack.callSuccess(
              (map['message'] ?? "").toString(),
            );
          } else {
            Snack.callError((map ?? "Something went wrong").toString());
          }
          print(">>>>>" + map.toString());
        },
        token: authToken ?? "");
  }

  void showUnderProcess() async {
    bool isOk = await showCommonPopupNew2(
      "Your kyc verification under process?",
      "Vehicle Added Successfully\nPlease wait until nex update.",
      barrierDismissible: false,
      isYesOrNoPopup: false,
    );
    if (isOk) {
      Get.offAllNamed(Routes.LOGINSCREEN);
      // ignore: use_build_context_synchronously
    }
  }

  cancelStep() {
    if (currentStep > helpStep) {
      currentStep1 = currentStep - 1;
      currentStep = currentStep - 1;

      print(">>>>>>>> " +
          currentStep1.toString() +
          "      " +
          currentStep.toString());
      update(['ref']);
    }
  }

  onStepTapped(int value) {
    currentStep = value;
    update(['ref']);
  }

  Widget controlsBuilder(context, details) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [],
        ),
      ],
    );
  }

  Future pickImage(ImageSource source,
      {bool dl = false,
      bool aadhaar = false,
      bool pan = false,
      bool rc = false,
      bool vehicle = false,
      bool insurance = false,
      bool pollution = false,
      bool profile = false}) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 20,
      );
      if (image == null) return;
      final imageTemporary = File(image.path);
      if (dl) {
        imageData1 = imageTemporary;
        MyWidgets.showLoading3();
        postDocument(imageTemporary, pan: pan, aadhaar: aadhaar, dl: dl);
      } else if (aadhaar) {
        imageData2 = imageTemporary;
        MyWidgets.showLoading3();
        postDocument(imageTemporary, pan: pan, aadhaar: aadhaar, dl: dl);
      } else if (pan) {
        imageData3 = imageTemporary;
        MyWidgets.showLoading3();
        postDocument(imageTemporary, pan: pan, aadhaar: aadhaar, dl: dl);
      } else if (rc) {
        imageDataRc = imageTemporary;
        MyWidgets.showLoading3();
        postDocument(imageTemporary, rc: rc);
      } else if (vehicle) {
        imageDataVehicle = imageTemporary;
        MyWidgets.showLoading3();
        postDocument(imageTemporary, vehicle: vehicle);
      } else if (insurance) {
        imageDataInsurance = imageTemporary;
        MyWidgets.showLoading3();
        postDocument(imageTemporary, insurance: insurance);
      } else if (pollution) {
        imageDataPollution = imageTemporary;
        MyWidgets.showLoading3();
        postDocument(imageTemporary, pollution: pollution);
      } else if (profile) {
        profileImage = imageTemporary;
        MyWidgets.showLoading3();
        postDocument(imageTemporary, profile: profile);
      } else {
        Snack.callError("Something went wrong");
      }
      // imageData = imageTemporary;
    } on PlatformException catch (e) {
      print("Failed  to pick image: $e");
    }
    Get.back();
  }

  void show(
      {bool dl = false,
      bool aadhaar = false,
      bool pan = false,
      bool rc = false,
      bool vehicle = false,
      bool insurance = false,
      bool pollution = false,
      bool profile = false}) {
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext cont) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  MyWidgets.showLoading3();
                  pickImage(ImageSource.camera,
                      pan: pan,
                      aadhaar: aadhaar,
                      dl: dl,
                      pollution: pollution,
                      insurance: insurance,
                      vehicle: vehicle,
                      rc: rc,
                      profile: profile);
                },
                child: const Text('Use Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  MyWidgets.showLoading3();
                  pickImage(ImageSource.gallery,
                      pan: pan,
                      aadhaar: aadhaar,
                      dl: dl,
                      pollution: pollution,
                      insurance: insurance,
                      vehicle: vehicle,
                      rc: rc,
                      profile: profile);
                },
                child: const Text('Upload from files'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(cont);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          );
        });
  }

  Future<dio.FormData> getFormData(File? selectFile) async {
    var formData = dio.FormData();
    if (selectFile != null) {
      formData.files.add(MapEntry(
        'file',
        dio.MultipartFile.fromFileSync(
          selectFile.path ?? "",
          filename: selectFile.uri.pathSegments.last ?? "",
        ),
      ));
    }
    return formData;
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  postDocument(File image,
      {bool dl = false,
      bool aadhaar = false,
      bool pan = false,
      bool rc = false,
      bool vehicle = false,
      bool insurance = false,
      bool pollution = false,
      bool profile = false}) async {
    try {
      service.Response response;
      response = await dioIns.post(
        "https://backend.eviman.co.in/api/uploads/v1/file",
        data: await getFormData(image),
        onSendProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + '%');
          }
        },
      );
      closeDialogIfOpen();
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map && response.data['success'] == true) {
          if (dl) {
            image1 = response.data['uploadedFile'];
            update(['image1']);
          } else if (aadhaar) {
            image2 = response.data['uploadedFile'];
            update(['image2']);
          } else if (pan) {
            image3 = response.data['uploadedFile'];
            update(['image3']);
          } else if (rc) {
            image4 = response.data['uploadedFile'];
            update(['image4']);
          } else if (vehicle) {
            image5 = response.data['uploadedFile'];
            update(['image5']);
          } else if (insurance) {
            image6 = response.data['uploadedFile'];
            update(['image6']);
          } else if (pollution) {
            image7 = response.data['uploadedFile'];
            update(['image7']);
          } else if (profile) {
            profileImg = response.data['uploadedFile'];
            update(['image0']);
          } else {}
        }
        print(">>>>>>>>>>response" + response.data.toString());
      } else {
        print(">>>>>>>>>>response" + response.data.toString());
        Snack.callError("Something went wrong");
      }
    } on dio.DioError catch (e) {
      print(">>>>>>>>>>response" + e.toString());
    }
  }

  bool permissionAllow = false;

  Future<String> handleLocationPermission() async {
    try{
      geoLoc.LocationPermission permission1;
      permission1 = await geoLoc.Geolocator.checkPermission();

      // permission1 = await geoLoc.Geolocator.checkPermission();
      if(permission1 == geoLoc.LocationPermission.always){
        return "true";
      }
      if (permission1 == geoLoc.LocationPermission.denied || permission1 == geoLoc.LocationPermission.whileInUse ) {
        return "false";
      }
      if (permission1 == geoLoc.LocationPermission.deniedForever) {
        // openAppSettings();
        // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied.')));
        return "falsePlus";
      }
      if(permission1 == geoLoc.LocationPermission.whileInUse){
        return "false";
      }

     /* var status = await permission.Permission.location.status;
      print(">>>>>>>>sta"+status.toString());
      if(status.isPermanentlyDenied){
        return "falsePlus";
      }else if(status.isDenied){
        return "false";
      }else{
        return "true";
      }*/

    }catch(ex){
      return "false";
    }

    return "true";
  }

  void infoDialog1() async {
    var status = await permission.Permission.location.status;
    // var status1 = await permission.Permission.locationAlways.status;
    // var status2 = await permission.Permission.notification.status;
    print(">>>>>>>>>>>>>>status$status");
    if (status.isDenied) {
      bool isOk = await showCommonPopupNew6(
          "eViman App need your location permission.It's required to give smooth less service to you",
          "are you agree?",
          barrierDismissible: true,
          isYesOrNoPopup: true);
      if (isOk) {
        if (status.isPermanentlyDenied) {
          permission.openAppSettings();
        }else{
          print(">>>>>>>>>>>>>>>>>>>>else in dialog call");
          permission. Permission.location.request();
        }
      } else {
        permissionAllow = false;
        update(['all']);
      }
    } else {
      print(">>>>>>>>>>>>>>>>>>>>else out dialog call");
      // permission. Permission.notification.request();
      permissionAllow = true;
      update(['all']);
      // getRiderId();
      // getCurrentLocation();
      getCurrentLocation();
      getFareInfo();
    }
  }

  Future<void> getCurrentLocation() async {
    lo.Location location = lo.Location();
    location.getLocation().then((value) async {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          value.latitude ?? 0, value.longitude ?? 0);
      if (placeMarks.isNotEmpty) {
        locationDetail = {
          "details": placeMarks.first,
          "lat": value.latitude ?? 0,
          "lng": value.longitude ?? 0
        };
        getLocationDetailsFromLatLong(locationDetail);
        update(['loc']);
      }
    });
  }

  getLocationDetailsFromLatLong(Map<String, dynamic>? locationDetails) {
    // locationDetail
    if (locationDetail.isNotEmpty &&
        locationDetail.containsKey("details") &&
        locationDetail['details'] != null &&
        locationDetail['details'] is Placemark) {
      Placemark data = locationDetail['details'];

      address1VehicleController.text = data.name ?? "";
      address2VehicleController.text = data.subLocality ?? "";
      cityVehicleController.text = data.locality ?? "";
      stateVehicleController.text = data.administrativeArea ?? "";
      countryVehicleController.text = data.country ?? "";
      pinVehicleController.text = data.postalCode ?? "";
      currentCityVehicleController.text = data.locality ?? "";

      address1Controller.text = data.name ?? '';
      address2Controller.text = data.subLocality ?? "";
      cityController.text = data.locality ?? "";
      stateController.text = data.administrativeArea ?? "";
      countryController.text = data.country ?? "";
      pinController.text = data.postalCode ?? "";

      update(['ref']);
    }
  }

  getLocationDetailsFromLatLong1(Map<String, dynamic>? locationDetails) {
    // locationDetail
    if (locationDetail.isNotEmpty &&
        locationDetail.containsKey("details") &&
        locationDetail['details'] != null &&
        locationDetail['details'] is Placemark) {
      Placemark data = locationDetail['details'];

      address1Controller.text = data.name ?? '';
      address2Controller.text = data.subLocality ?? "";
      cityController.text = data.locality ?? "";
      stateController.text = data.administrativeArea ?? "";
      countryController.text = data.country ?? "";
      pinController.text = data.postalCode ?? "";
      update(['step1']);
    }
  }

  Map<String, dynamic> data = {};
  int helpStep = 0;
  String authToken = "";
  @override
  void onInit() {

    data = Get.arguments ?? {};
    currentStep = data['index'] ?? 0;
    helpStep = data['index'] ?? 0;
    mobile = data['mobile'] ?? "";
    authToken = data['authToken'] ?? "";
    riderId = (data['riderId'] ?? "").toString();
    mobileController.text = mobile;
    dioIns = dio.Dio();
    super.onInit();
  }

  FareInfoModel? fareInfoModel = FareInfoModel(fareList: <FareList>[]);

  List<KeyvalueModel> vehicleTypeList = [];
  List<KeyvalueModel> subVehicleTypeList = [];
  List<Vehicle> vehicles = [];

  getFareInfo() {
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL(
        api: "https://backend.eviman.co.in/api/fareinfo/v1/get-fare-list",
        fun: (map) {
          Get.back();
          print(">>>>>>>>>" + map.toString());

          if (map is Map &&
              map.containsKey('success') &&
              map['success'] == true) {
            fareInfoModel = FareInfoModel.fromJson(map as Map<String, dynamic>);
            if (fareInfoModel?.fareList != null &&
                (fareInfoModel?.fareList?.length ?? 0) > 0) {
              vehicles = fareInfoModel!.fareList!
                  .map((e) =>
                      Vehicle.fromJson(e.toJson() as Map<String, dynamic>))
                  .toList();
            }
            final Set<String> uniqueVehicleTypes =
                vehicles.map((vehicle) => vehicle.vehicleType).toSet();
            print(">>>>>>>>>>>>vehicles" + uniqueVehicleTypes.toString());
            vehicleTypeList.clear();
            List data = uniqueVehicleTypes.toList();
            for (int i = 0; i < (data.length ?? 0); i++) {
              vehicleTypeList.add(
                  new KeyvalueModel(key: data[i] ?? "", name: data[i] ?? ""));
            }
            print(">>>>>>>>>>>>vehicleTypeList" + vehicleTypeList.toString());

            // Snack.callSuccess((map['message'] ?? "").toString(),);
          } else {
            fareInfoModel = FareInfoModel(fareList: []);
            Snack.callError((map ?? "Something went wrong").toString());
          }
          print(">>>>>" + map.toString());
        });
  }

  filterSubType(String key) {
    subVehicleTypeList.clear();
    fareInfoModel?.fareList?.forEach((element) {
      if (element.vehicleType.toString().trim().toLowerCase() ==
          key.toString().trim().toLowerCase()) {
        subVehicleTypeList.add(new KeyvalueModel(
            key: element.vehicleSubType ?? "",
            name: element.vehicleSubType ?? ""));
      }
    });
    update(['subt']);
  }

  @override
  void onReady() {
    infoDialog1();

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
