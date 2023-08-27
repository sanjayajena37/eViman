import 'package:dateplan/app/constants/helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../constants/text_styles.dart';
import '../../../constants/themes.dart';
import '../../../logic/controllers/theme_provider.dart';
import '../../../models/enum.dart';
import '../../../models/setting_list_data.dart';
import '../../../widgets/common_appbar_view.dart';
import '../../../widgets/common_card.dart';
import '../../../widgets/remove_focuse.dart';
import '../controllers/settingscreen_controller.dart';

class SettingscreenView extends GetView<SettingscreenController> with Helper {
   SettingscreenView({Key? key}) : super(key: key);
  var country = 'Australia';
  var currency = '\$ AUD';
  int selectedradioTile = 0;

  @override
  Widget build(BuildContext context) {
    List<SettingsListData> settingsList = SettingsListData.settingsList;

    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "Setting",
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: settingsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {

                      } else if (index == 1) {
                        _getFontPopUI();
                      } else if (index == 2) {
                        _getColorPopUI();
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    settingsList[index].titleTxt,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                                  index == 0
                                  ? _themeUI()
                                  : Padding(
                                padding: const EdgeInsets.all(16),
                                child: Icon(
                                    settingsList[index].iconData,
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Divider(
                            height: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _themeUI() {
    final themeProvider = Get.find<ThemeController>();
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: PopupMenuButton<ThemeModeType>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onSelected: (type) {
          type == ThemeModeType.system
              ? themeProvider.updateThemeMode(ThemeModeType.system)
              : type == ThemeModeType.light
              ? themeProvider.updateThemeMode(ThemeModeType.light)
              : themeProvider.updateThemeMode(ThemeModeType.dark);
          controller.refresh();
        },
        icon: Icon(
            themeProvider.themeModeType == ThemeModeType.system
                ? FontAwesomeIcons.circleHalfStroke
                : themeProvider.themeModeType == ThemeModeType.light
                ? FontAwesomeIcons.cloudSun
                : FontAwesomeIcons.cloudMoon,
            color: Theme.of(Get.context!).primaryColor),
        offset: const Offset(10, 18),
        itemBuilder: (context) => [
          ...ThemeModeType.values.toList().map(
                (e) => PopupMenuItem(
              value: e,
              child: _getSelectedUI(
                e == ThemeModeType.system
                    ? FontAwesomeIcons.circleHalfStroke
                    : e == ThemeModeType.light
                    ? FontAwesomeIcons.cloudSun
                    : FontAwesomeIcons.cloudMoon,
                e.toString().split(".")[1],
                e == themeProvider.themeModeType,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTextUi(String text) {
    return Text(
      text,
      style: TextStyles(Get.context!).getDescriptionStyle().copyWith(
        fontSize: 16,
      ),
    );
  }

  Widget _getSelectedUI(IconData icon, String text, bool isCurrent) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color:
            isCurrent ? AppTheme.primaryColor : AppTheme.primaryTextColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              text,
              style: TextStyles(Get.context!).getRegularStyle().copyWith(
                color: isCurrent
                    ? AppTheme.primaryColor
                    : AppTheme.primaryTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  _getFontPopUI() {
    final List<Widget> fontArray = [];
    FontFamilyType.values.toList().forEach(
          (element) {
        fontArray.add(
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                Get.find<ThemeController>().updateFontType(element);
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello",
                      style: AppTheme.getTextStyle(
                        element,
                        TextStyles(Get.context!).getRegularStyle().copyWith(
                            color:
                            Get.find<ThemeController>().fontType == element
                                ? AppTheme.primaryColor
                                : AppTheme.fontcolor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: FontFamilyType.workSans == element ? 3 : 0),
                      child: Text(
                        element.toString().split('.')[1],
                        style: AppTheme.getTextStyle(
                          element,
                          TextStyles(Get.context!).getRegularStyle().copyWith(
                              color: Get.find<ThemeController>().fontType ==
                                  element
                                  ? AppTheme.primaryColor
                                  : AppTheme.fontcolor),
                        ).copyWith(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    return showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Selected fonts',
                      style: TextStyles(context)
                          .getBoldStyle()
                          .copyWith(fontSize: 22),
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            fontArray[0],
                            fontArray[1],
                            fontArray[2],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            fontArray[3],
                            fontArray[4],
                            fontArray[5],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getColorPopUI() {
    final List<Widget> fontArray = [];

    ColorType.values.toList().forEach((element) {
      fontArray.add(
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              Get.find<ThemeController>().updateColorType(element);
              Navigator.pop(Get.context!);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color:
                            Get.find<ThemeController>().colorType == element
                                ? AppTheme.getColor(element)
                                : Colors.transparent)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.getColor(element)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
    return showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                     "Selected color",
                      style: TextStyles(context)
                          .getBoldStyle()
                          .copyWith(fontSize: 22),
                    ),
                  ),
                  const Divider(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        fontArray[0],
                        fontArray[1],
                        fontArray[2],
                        fontArray[3],
                        fontArray[4],
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _gotoSplashScreen() async {
    bool isOk = await showCommonPopupNew(
      "Are you sure?",
      "You want to Sign Out.",
      Get.context!,
      barrierDismissible: true,
      isYesOrNoPopup: true,
    );
    if (isOk) {
      // ignore: use_build_context_synchronously

    }
  }
}
