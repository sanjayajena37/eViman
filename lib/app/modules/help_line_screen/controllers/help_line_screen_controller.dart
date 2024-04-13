import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Firebase/fireStoreDataBaseService.dart';

class HelpLineScreenController extends GetxController {
  //TODO: Implement HelpLineScreenController

  final count = 0.obs;
  final DatabaseService databaseService = DatabaseService();

   /*  getFirestoreData(String collectionPath) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Get a reference to the collection
    CollectionReference collectionRef = firestore.collection(collectionPath);

    // Get all documents (waits for data)
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Convert each document snapshot to a map and store in a list
    List<Map<String, dynamic>> dataList = [];
    for (var doc in querySnapshot.docs) {
      // dataList.add(doc.data());

      print(">>>>>>>>>>>>>>>${doc.data()}");
    }

    // return dataList;
  }*/

  makingPhoneCall(String? number) async {
    var url = Uri.parse("tel:${number ?? ""}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@eviman.co.in',
      queryParameters: {
        'subject': 'Facing Issues',
        'body': 'Dear Sir,',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      // Handle case where email app is not available
      if (kDebugMode) {
        print('Could not launch email app');
      }
    }
  }

  sendingMails() async {
    var url = Uri.parse("mailto:jatinkumarsahoo99@gmail.in");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  sendWhatsappMessage() async {
    // final Uri uri = Uri.file(XFile.fromData(data).path);
    // await launchUrl(uri);
    await launch("https://wa.me/${9124384030}?text=I am facing issues:");
  }

  textMe() async {
    // Android
    var uri = 'sms:+91 ${9124384030}?body=I am facing issues:';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      var uri = 'sms:+91 ${9124384030}?body=I am facing issues:';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }


  @override
  void onInit() {
    // print(">>>>>>>>>>>>>>>>>data from firebase${getFirestoreData("eviman")}");
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
