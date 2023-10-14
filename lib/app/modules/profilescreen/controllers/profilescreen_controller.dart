import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/shared_preferences_keys.dart';
import '../../../data/ApiFactory.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/Snack.dart';
import '../../ConnectorController.dart';
import '../ProfileViewModel.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart' as service;

class ProfilescreenController extends GetxController
    with GetSingleTickerProviderStateMixin , WidgetsBindingObserver {
  //TODO: Implement ProfilescreenController
  File? imageData;
  AnimationController? controllerAnimation;
  final count = 0.obs;
  bool isEnabled = false;

  File? profileImage;
  File? dlImage;
  File? aadhaarImage;
  File? panImage;

  String? profileImageUrl;
  String? dlImageUrl;
  String? aadhaarImageUrl;
  String? panImageUrl;

  String? uploadProfileImageUrl;
  String? uploadDlImageUrl;
  String? uploadAadhaarImageUrl;
  String? uploadPanImageUrl;

  Rxn<String>? userName = Rxn<String>(null);
  Rxn<bool>? activeStatus = Rxn<bool>(false);

  ProfileViewModel? profileViewModel;
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
  ];

  getProfileDetails() {
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().GETMETHODCALL_TOKEN(
        api: "https://backend.eviman.co.in/api/riders/v1/profile/${riderId ?? 0}",
        token: authToken ?? "",
        fun: (map) {
          print(">>>>" + map.toString());
          Get.back();
          if (map is Map &&
              map.containsKey("success") &&
              map['success'] == true) {
            profileViewModel =
                ProfileViewModel.fromJson(map as Map<String, dynamic>);
            profileInfoList.clear();
            profileInfoList.add(ProfileInfoModel(
                tittle: "First Name",
                hinTetxt: profileViewModel?.riderData?.firstName ?? ""));

            profileInfoList.add(ProfileInfoModel(
                tittle: "Last Name",
                hinTetxt: profileViewModel?.riderData?.lastName ?? ""));
            profileInfoList.add(ProfileInfoModel(
                tittle: "Email",
                hinTetxt: profileViewModel?.riderData?.email ?? ""));
            profileInfoList.add(ProfileInfoModel(
                tittle: "Address1",
                hinTetxt: profileViewModel?.riderData?.address1 ?? ""));
            profileInfoList.add(ProfileInfoModel(
                tittle: "Address2",
                hinTetxt: profileViewModel?.riderData?.address2 ?? ""));
            profileInfoList.add(ProfileInfoModel(
                tittle: "City",
                hinTetxt: profileViewModel?.riderData?.city ?? ""));
            profileInfoList.add(ProfileInfoModel(
                tittle: "State",
                hinTetxt: profileViewModel?.riderData?.state ?? ""));
            profileInfoList.add(ProfileInfoModel(
                tittle: "Country",
                hinTetxt: profileViewModel?.riderData?.country ?? ""));
            profileInfoList.add(ProfileInfoModel(
                tittle: "Pin",
                hinTetxt: (profileViewModel?.riderData?.pin ?? "").toString()));
            profileInfoList.add(ProfileInfoModel(
                tittle: "Driving License No",
                hinTetxt: (profileViewModel?.riderData?.drivingLicenseNo ?? "")
                    .toString()));
            profileImageUrl = profileViewModel?.riderData?.profile_image;
            dlImageUrl = profileViewModel?.riderData?.dlImage;
            aadhaarImageUrl = profileViewModel?.riderData?.aadhaar_image;
            panImageUrl = profileViewModel?.riderData?.pan_image;

            textEditingController[0].text = profileViewModel?.riderData?.firstName ?? "";
            textEditingController[1].text = profileViewModel?.riderData?.lastName ?? "";
            textEditingController[3].text = profileViewModel?.riderData?.address1 ?? "";
            textEditingController[4].text = profileViewModel?.riderData?.address2 ?? "";
            textEditingController[5].text = profileViewModel?.riderData?.city ?? "";
            textEditingController[6].text = profileViewModel?.riderData?.state ?? "";
            textEditingController[7].text = profileViewModel?.riderData?.country ?? "";
            textEditingController[8].text = (profileViewModel?.riderData?.pin ?? "").toString();
            uploadProfileImageUrl = profileViewModel?.riderData?.profile_image ?? "";
            uploadAadhaarImageUrl = profileViewModel?.riderData?.aadhaar_image ?? "";
            uploadDlImageUrl = profileViewModel?.riderData?.dlImage ?? "";
            uploadPanImageUrl = profileViewModel?.riderData?.pan_image ?? "";
            // textEditingController[8].text = profileViewModel?.riderData?.pin ?? "";


            userName?.value = (profileViewModel?.riderData?.firstName??"")+(profileViewModel?.riderData?.lastName??"");
            activeStatus?.value =profileViewModel?.riderData?.isActive??false ;
            userName?.refresh();
            activeStatus?.refresh();

            update(['inform']);
            update(['document']);
            update(['profile']);
          } else {
            Get.back();
            profileViewModel = ProfileViewModel(riderData: RiderData());
            Snack.callError("Something went wrong");
          }
        });
  }

  @override
  void onInit() {
    controllerAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.onInit();
  }

  Dio dioIns = dio.Dio();
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
      {bool profile = false,
      bool dl = false,
      bool aadhaar = false,
      bool pan = false}) async {
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
          if (profile) {
            uploadProfileImageUrl = response.data['uploadedFile'];
            profileImageUrl = null;
            update(['profile']);
          } else if (dl) {
            uploadDlImageUrl = response.data['uploadedFile'];
            dlImageUrl = null;
            update(['dl']);
          } else if (aadhaar) {
            uploadAadhaarImageUrl = response.data['uploadedFile'];
            aadhaarImageUrl = null;
            update(['aadhaar']);
          } else if (pan) {
            uploadPanImageUrl = response.data['uploadedFile'];
            panImageUrl = null;
            update(['pan']);
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
      {bool profile = false,
      bool dl = false,
      bool aadhaar = false,
      bool pan = false}) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      if (profile) {
        imageData = imageTemporary;
        postDocument(imageData!, profile: profile);
      } else if (dl) {
        dlImage = imageTemporary;
        postDocument(dlImage!, dl: dl);
      } else if (aadhaar) {
        aadhaarImage = imageTemporary;
        postDocument(aadhaarImage!, aadhaar: aadhaar);
      } else if (pan) {
        panImage = imageTemporary;
        postDocument(panImage!, pan: pan);
      } else {}
    } on PlatformException catch (e) {
      print("Failed  to pick image: $e");
    }
  }

  void show(
      {bool profile = false,
      bool dl = false,
      bool aadhaar = false,
      bool pan = false}) {
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
                      dl: dl, aadhaar: aadhaar, pan: pan, profile: profile);
                  Navigator.of(cont).pop;
                },
                child: const Text('Use Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  MyWidgets.showLoading3();
                  pickImage(ImageSource.gallery,
                      dl: dl, aadhaar: aadhaar, pan: pan, profile: profile);
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

  updateApi() {
    Map<String, dynamic> postData = {
      "first_name": textEditingController[0].text ?? "",
      "last_name": textEditingController[1].text ?? "",
      "address1": textEditingController[3].text ?? "",
      "address2": textEditingController[4].text ?? "",
      "city": textEditingController[5].text ?? "",
      "state": textEditingController[6].text ?? "",
      "country": textEditingController[7].text ?? "",
      "pin": textEditingController[8].text ?? "",
      "profile_image": uploadDlImageUrl ?? "",
      "dl_image": uploadDlImageUrl ?? "",
      "aadhaar_image": uploadAadhaarImageUrl ?? "",
      "pan_image": uploadAadhaarImageUrl ?? ""
    };

    print(">>>>>>>>>>>>>>>>>>postData"+postData.toString());
    MyWidgets.showLoading3();
    Get.find<ConnectorController>().PATCH_METHOD_POST_TOKEN(
        api:
            "https://backend.eviman.co.in/api/riders/v1/update-profile/${riderId ?? ""}",
        json: postData,
        token: authToken ?? "",
        fun: (map) {
          Get.back();
          if (map is Map &&
              map.containsKey('success') &&
              map['success'] == true) {
            getProfileDetails();
          } else {
            Snack.callError((map ?? "Something went wrong").toString());
          }
          print(">>>>>" + map.toString());
        });
  }

  @override
  void onReady() {
    getRiderId();
    super.onReady();
  }

  String? riderId;
  String? authToken;
  getRiderId() async {
    riderId = await SharedPreferencesKeys().getStringData(key: 'riderId');
    authToken = await SharedPreferencesKeys().getStringData(key: 'authToken');
    print(">>>>>>>>>authToken jks" + authToken.toString());
    getProfileDetails();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  if (state == AppLifecycleState.resumed) {

  } else {

  }
}
class ProfileInfoModel {
  String? tittle;
  String? hinTetxt;
  ProfileInfoModel({this.tittle, this.hinTetxt});
}

List<ProfileInfoModel> profileInfoList = [];
