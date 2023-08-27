import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/shared_preferences_keys.dart';
import '../../../widgets/MyWidget.dart';
import '../../../widgets/Snack.dart';
import '../../ConnectorController.dart';
import '../ProfileViewModel.dart';

class ProfilescreenController extends GetxController with GetSingleTickerProviderStateMixin  {
  //TODO: Implement ProfilescreenController
   File? imageData;
   AnimationController? controllerAnimation;
  final count = 0.obs;
  bool isEnabled = false;
   ProfileViewModel ?profileViewModel;

   getProfileDetails(){
     MyWidgets.showLoading3();
     Get.find<ConnectorController>().GETMETHODCALL(
         api: "http://65.1.169.159:3000/api/riders/v1/profile/${riderId??0}",
         fun: (map) {
           Get.back();
           if(map is Map && map.containsKey("success") && map['success'] == true){
             profileViewModel = ProfileViewModel.fromJson(map as Map<String,dynamic>);
             profileInfoList.clear();
             profileInfoList.add(ProfileInfoModel(tittle: "First Name",hinTetxt:profileViewModel?.riderData?.firstName?? ""));
             profileInfoList.add(ProfileInfoModel(tittle: "Last Name",hinTetxt:profileViewModel?.riderData?.lastName?? ""));
             profileInfoList.add(ProfileInfoModel(tittle: "Email",hinTetxt:profileViewModel?.riderData?.email?? ""));
             profileInfoList.add(ProfileInfoModel(tittle: "Address1",hinTetxt:profileViewModel?.riderData?.address1?? ""));
             profileInfoList.add(ProfileInfoModel(tittle: "Address2",hinTetxt:profileViewModel?.riderData?.address2?? ""));
             profileInfoList.add(ProfileInfoModel(tittle: "City",hinTetxt:profileViewModel?.riderData?.city?? ""));
             profileInfoList.add(ProfileInfoModel(tittle: "State",hinTetxt:profileViewModel?.riderData?.state?? ""));
             profileInfoList.add(ProfileInfoModel(tittle: "Country",hinTetxt:profileViewModel?.riderData?.country?? ""));
             profileInfoList.add(ProfileInfoModel(tittle: "Pin",hinTetxt:(profileViewModel?.riderData?.pin?? "").toString()));
             profileInfoList.add(ProfileInfoModel(tittle: "Driving License No",hinTetxt:(profileViewModel?.riderData?.drivingLicenseNo?? "").toString()));
             update(['inform']);
           }else{
             Get.back();
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
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);

      imageData = imageTemporary;
      update(['ref']);
    } on PlatformException catch (e) {
      print("Failed  to pick image: $e");
    }
    Navigator.of(Get.context!).pop(true);
  }

  void show() {
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext cont) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                    pickImage(ImageSource.camera);
                    Navigator.of(cont).pop;
                },
                child: const Text('Use Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  pickImage(ImageSource.gallery);
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

  @override
  void onReady() {
    getRiderId();
    super.onReady();
  }
   String? riderId;
  getRiderId() async {
     riderId = await SharedPreferencesKeys().getStringData( key: 'riderId');
     getProfileDetails();
    print(">>>>>>>>>>>"+riderId.toString());
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
  ProfileInfoModel({this.tittle,this.hinTetxt});
}

List<ProfileInfoModel> profileInfoList = [
];