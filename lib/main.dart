import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:permission_handler/permission_handler.dart';

import 'MainClass.dart';
import 'app/data/BinderData.dart';
import 'app/logic/controllers/theme_provider.dart';
import 'app/modules/driverDashboard/controllers/workmanager_initializer.dart';
import 'app/providers/flutterbackgroundservices.dart';
import 'app/routes/app_pages.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<ThemeController>(() => ThemeController.init(),
      permanent: true);
  await Permission.locationAlways.isDenied.then((value) {
    if(value){
      Permission.locationAlways.request();
    }
  }) ;
  await Permission.location.isDenied.then((value) {
    if(value){
      Permission.location.request();
    }
  }) ;
  await Permission.notification.isDenied.then((value) {
    if(value){
      Permission.notification.request();
    }
  }) ;

  // final int helloAlarmID = 0;
  // await AndroidAlarmManager.initialize();
  // await AndroidAlarmManager.periodic(const Duration(seconds: 3), helloAlarmID, BackgroundTask.printHello);

  // initializeWorkManager();
  await initializeService();

  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MainClass()));



  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    mapsImplementation.useAndroidViewSurface = true;
    mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest);
  }
}
