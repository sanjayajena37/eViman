import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart' as service;

import '../../../constants/shared_preferences_keys.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/Snack.dart';
import '../../ConnectorController.dart';
import '../VehicleDetailsModel.dart';

class VehicleDetailsController extends GetxController {
  //TODO: Implement VehicleDetailsController

  final count = 0.obs;
  bool isEnabled = false;
  File? imageData;
  String? vehicleImageUrl;
  Dio dioIns = dio.Dio();

  File? vehicleImage;
  File? insuranceImage;
  File? pollutionImage;

  String? insuranceImageUrl;
  String? pollutionImageUrl;

  String? uploadVehicleImageUrl;
  String? uploadInsuranceImageUrl;
  String? uploadPollutionImageUrl;

  Rxn<String>? userName = Rxn<String>(null);
  Rxn<bool>? activeStatus = Rxn<bool>(false);

  List<TextEditingController> textEditingController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

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
      {bool vehicle = false,
      bool insurance = false,
      bool pollution = false}) async {
    try {
      service.Response response;
      response = await dioIns.post(
        "http://65.1.169.159:3000/api/uploads/v1/file",
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
          if (vehicle) {
            uploadVehicleImageUrl = response.data['uploadedFile'];
            vehicleImage = null;
            update(['profile']);
          } else if (insurance) {
            uploadInsuranceImageUrl = response.data['uploadedFile'];
            insuranceImageUrl = null;
            update(['dl']);
          } else if (pollution) {
            uploadPollutionImageUrl = response.data['uploadedFile'];
            pollutionImageUrl = null;
            update(['aadhaar']);
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

  Future pickImage(ImageSource source,
      {bool vehicle = false,
      bool pollution = false,
      bool insurance = false}) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      if (vehicle) {
        imageData = imageTemporary;
        postDocument(imageData!, vehicle: vehicle);
      } else if (insurance) {
        insuranceImage = imageTemporary;
        postDocument(insuranceImage!, insurance: insurance);
      } else if (pollution) {
        pollutionImage = imageTemporary;
        postDocument(pollutionImage!, pollution: pollution);
      } else {}
    } on PlatformException catch (e) {
      print("Failed  to pick image: $e");
    }
  }

  void show(
      {bool vehicle = false, bool pollution = false, bool insurance = false}) {
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
                      vehicle: vehicle,
                      pollution: pollution,
                      insurance: insurance);
                  Navigator.of(cont).pop;
                },
                child: const Text('Use Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  MyWidgets.showLoading3();
                  pickImage(ImageSource.gallery,
                      vehicle: vehicle,
                      pollution: pollution,
                      insurance: insurance);
                  Navigator.of(cont).pop;
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

  String? vehicleId;
  String? authToken;
  VehicleDetailsModel? vehicleDetailsModel;
  getRiderId() async {
    vehicleId = await SharedPreferencesKeys().getStringData(key: 'vehicleId');
    authToken = await SharedPreferencesKeys().getStringData(key: 'authToken');
    getVehicleDetails();
  }

  getVehicleDetails() {
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL_TOKEN(
        api: "http://65.1.169.159:3000/api/vehicles/v1/get/${vehicleId ?? 0}",
        token: authToken ?? "",
        fun: (map) {
          print(">>>>" + map.toString());
          Get.back();
          if (map is Map &&
              map.containsKey("success") &&
              map['success'] == true) {
            vehicleDetailsModel =
                VehicleDetailsModel.fromJson(map as Map<String, dynamic>);
            profileInfoList.clear();
            profileInfoList.add(ProfileInfoModel(
                tittle: "Vehicle Regd Num",
                hinTetxt: vehicleDetailsModel?.vehicleDetails?.vehicleRegdNumber ?? ""));

            profileInfoList.add(ProfileInfoModel(
                tittle: "Chassis Number",
                hinTetxt: vehicleDetailsModel?.vehicleDetails?.chasisNumber ?? ""));

            profileInfoList.add(ProfileInfoModel(
                tittle: "Engine Number",
                hinTetxt: vehicleDetailsModel?.vehicleDetails?.engineNumber ?? ""));

            profileInfoList.add(ProfileInfoModel(
                tittle: "Address1",
                hinTetxt: vehicleDetailsModel?.vehicleDetails?.address1 ?? ""));

            profileInfoList.add(ProfileInfoModel(
                tittle: "Address2",
                hinTetxt: vehicleDetailsModel?.vehicleDetails?.address2 ?? ""));

            profileInfoList.add(ProfileInfoModel(
                tittle: "City",
                hinTetxt: vehicleDetailsModel?.vehicleDetails?.city ?? ""));

            profileInfoList.add(ProfileInfoModel(
                tittle: "State",
                hinTetxt: vehicleDetailsModel?.vehicleDetails?.state ?? ""));

            profileInfoList.add(ProfileInfoModel(
                tittle: "Country",
                hinTetxt: vehicleDetailsModel?.vehicleDetails?.country ?? ""));

            profileInfoList.add(ProfileInfoModel(
                tittle: "Pin",
                hinTetxt: (vehicleDetailsModel?.vehicleDetails?.pin ?? "").toString()));

            profileInfoList.add(ProfileInfoModel(
                tittle: "Current City",
                hinTetxt: (vehicleDetailsModel?.vehicleDetails?.currentCity ?? "").toString()));

            userName?.value = vehicleDetailsModel?.vehicleDetails?.ownerName??"";
            update(['ref']);
            // activeStatus?.value = vehicleDetailsModel?.vehicleDetails?.isActive?? false;


          } else {
            Get.back();
            Snack.callError("Something went wrong");
          }
        });
  }

  @override
  void onInit() {
    getRiderId();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

class ProfileInfoModel {
  String? tittle;
  String? hinTetxt;
  ProfileInfoModel({this.tittle, this.hinTetxt});
}

List<ProfileInfoModel> profileInfoList = [];
