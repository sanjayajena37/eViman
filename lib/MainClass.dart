import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'app/constants/themes.dart';
import 'app/data/BinderData.dart';
import 'app/logic/controllers/theme_provider.dart';
import 'app/routes/app_pages.dart';

class MainClass extends StatefulWidget {
  const MainClass({Key? key}) : super(key: key);

  @override
  State<MainClass> createState() => _MainClassState();
}

class _MainClassState extends State<MainClass> {

  void _setFirstTimeSomeData(BuildContext context, ThemeData theme) {
    _setStatusBarNavigationBarTheme(theme);
    //we call some theme basic data set in app like color, font, theme mode, language
    Get.find<ThemeController>()
        // .checkAndSetThemeMode(MediaQuery.of(context).platformBrightness);
        .checkAndSetThemeMode(Brightness.light);
  }

  void _setStatusBarNavigationBarTheme(ThemeData themeData) {
    final brightness = !kIsWeb && Platform.isAndroid
        ? themeData.brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light
        : themeData.brightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
      systemNavigationBarColor: themeData.backgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: brightness,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ThemeController>(
      builder: (controller) {
        final ThemeData theme = AppTheme.getThemeData;
        return GetMaterialApp(
          theme: theme,
          themeMode:ThemeMode.light ,
          darkTheme:theme ,
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
            initialBinding: BinderData(),
          builder: (BuildContext context, Widget? child) {
            _setFirstTimeSomeData(context, theme);
            return Directionality(textDirection: TextDirection.ltr,
              child: MediaQuery(data: MediaQuery.of(context).copyWith(
                textScaleFactor: MediaQuery.of(context).size.width > 360
                    ? 1.0
                    : MediaQuery.of(context).size.width >= 340
                    ? 0.9
                    : 0.8,
              ), child: child ?? const SizedBox(),),
            );
          },
        );
      }
    );
  }
}
