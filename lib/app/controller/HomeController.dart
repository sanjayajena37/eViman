import 'dart:convert';

// import 'package:bms_programming/app/providers/ApiFactory.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../data/DrawerModel.dart';



class HomeController extends GetxController {
  //TODO: Implement HomeController

  SubChild? selectChild;
  var selectChild1 = Rxn<SubChild>();
  List? buttons;
  List? tranmissionButtons;
  List? asurunImportButtoons;

  bool isMoviePlannerPopupShown = false;

  @override
  void onInit() {
    getbuttondata();
    getTransmissionLog();
    super.onInit();
  }

  getbuttondata() async {
    String value = await rootBundle.loadString('assets/json/buttons.json');
    buttons = json.decode(value);
    update(["buttons"]);
  }

  getTransmissionLog() async {
    String value =
        await rootBundle.loadString('assets/json/transmission_buttons.json');
    tranmissionButtons = json.decode(value)["transmissionLog"];
    asurunImportButtoons = json.decode(value)["assrunImport"];
    update(["transButtons"]);
  }

}
