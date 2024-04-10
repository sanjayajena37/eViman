import 'package:flutter/animation.dart';

import 'package:get/get.dart';

import '../modules/DocumentUpload/bindings/document_upload_binding.dart';
import '../modules/DocumentUpload/views/document_upload_view.dart';
import '../modules/ImageDetailsPage/bindings/image_details_page_binding.dart';
import '../modules/ImageDetailsPage/views/image_details_page_view.dart';
import '../modules/UpComingRideDetailsPage/bindings/up_coming_ride_details_page_binding.dart';
import '../modules/UpComingRideDetailsPage/views/up_coming_ride_details_page_view.dart';
import '../modules/bluetoothscreen/bindings/bluetoothscreen_binding.dart';
import '../modules/bluetoothscreen/views/bluetoothscreen_view.dart';
import '../modules/driverDashboard/bindings/driver_dashboard_binding.dart';
import '../modules/driverDashboard/views/driver_dashboard_view.dart';
import '../modules/driverprofile/bindings/driverprofile_binding.dart';
import '../modules/driverprofile/views/driverprofile_view.dart';
import '../modules/earningpage/bindings/earningpage_binding.dart';
import '../modules/earningpage/views/earningpage_view.dart';
import '../modules/galleryscreen/bindings/galleryscreen_binding.dart';
import '../modules/galleryscreen/views/galleryscreen_view.dart';
import '../modules/help_line_screen/bindings/help_line_screen_binding.dart';
import '../modules/help_line_screen/views/help_line_screen_view.dart';
import '../modules/historyscreen/bindings/historyscreen_binding.dart';
import '../modules/historyscreen/views/historyscreen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introscreen/bindings/introscreen_binding.dart';
import '../modules/introscreen/views/introscreen_view.dart';
import '../modules/invitescreen/bindings/invitescreen_binding.dart';
import '../modules/invitescreen/views/invitescreen_view.dart';
import '../modules/keyscreen/bindings/keyscreen_binding.dart';
import '../modules/keyscreen/views/keyscreen_view.dart';
import '../modules/kycscreen/bindings/kycscreen_binding.dart';
import '../modules/kycscreen/views/kycscreen_view.dart';
import '../modules/logesticdashboard/bindings/logesticdashboard_binding.dart';
import '../modules/logesticdashboard/views/logesticdashboard_view.dart';
import '../modules/loginscreen/bindings/loginscreen_binding.dart';
import '../modules/loginscreen/views/loginscreen_view.dart';
import '../modules/otpscreen/bindings/otpscreen_binding.dart';
import '../modules/otpscreen/views/otpscreen_view.dart';
import '../modules/profilescreen/bindings/profilescreen_binding.dart';
import '../modules/profilescreen/views/profilescreen_view.dart';
import '../modules/settingscreen/bindings/settingscreen_binding.dart';
import '../modules/settingscreen/views/settingscreen_view.dart';
import '../modules/signupscreen/bindings/signupscreen_binding.dart';
import '../modules/signupscreen/views/signupscreen_view.dart';
import '../modules/spalshscreen/bindings/spalshscreen_binding.dart';
import '../modules/spalshscreen/views/spalshscreen_view.dart';
import '../modules/vehicleDetails/bindings/vehicle_details_binding.dart';
import '../modules/vehicleDetails/views/vehicle_details_view.dart';
import '../modules/waletscreen/bindings/waletscreen_binding.dart';
import '../modules/waletscreen/views/waletscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPALSHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPALSHSCREEN,
      page: () => SpalshscreenView(),
      binding: SpalshscreenBinding(),
    ),
    GetPage(
      name: _Paths.INTROSCREEN,
      /*transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 900000),*/
      page: () => IntroscreenView(),
      binding: IntroscreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGINSCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      // curve: Curves.easeInOutCubic,
      page: () => LoginscreenView(),
      binding: LoginscreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUPSCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => SignupscreenView(),
      binding: SignupscreenBinding(),
    ),
    GetPage(
      name: _Paths.OTPSCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => OtpscreenView(),
      binding: OtpscreenBinding(),
    ),
    GetPage(
      name: _Paths.KYCSCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => KycscreenView(),
      binding: KycscreenBinding(),
    ),
    GetPage(
      name: _Paths.DRIVERPROFILE,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => const DriverprofileView(),
      binding: DriverprofileBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_DASHBOARD,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => DriverDashboardView(),
      binding: DriverDashboardBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGSCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => SettingscreenView(),
      binding: SettingscreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILESCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => ProfilescreenView(),
      binding: ProfilescreenBinding(),
    ),
    GetPage(
      name: _Paths.DOCUMENT_UPLOAD,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => DocumentUploadView(),
      binding: DocumentUploadBinding(),
    ),
    GetPage(
      name: _Paths.KEYSCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => KeyscreenView(),
      binding: KeyscreenBinding(),
    ),
    GetPage(
      name: _Paths.BLUETOOTHSCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => const BluetoothscreenView(),
      binding: BluetoothscreenBinding(),
    ),
    GetPage(
      name: _Paths.WALETSCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => WaletscreenView(),
      binding: WaletscreenBinding(),
    ),
    GetPage(
      name: _Paths.HISTORYSCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => HistoryscreenView(),
      binding: HistoryscreenBinding(),
    ),
    GetPage(
      name: _Paths.INVITESCREEN,
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 1000),
      page: () => InvitescreenView(),
      binding: InvitescreenBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE_DETAILS,
      page: () => VehicleDetailsView(),
      binding: VehicleDetailsBinding(),
    ),
    GetPage(
      name: _Paths.EARNINGPAGE,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 1000),
      page: () => EarningpageView(),
      binding: EarningpageBinding(),
    ),
    GetPage(
      name: _Paths.GALLERYSCREEN,
      page: () => GalleryscreenView(),
      binding: GalleryscreenBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_DETAILS_PAGE,
      page: () => const ImageDetailsPageView(),
      binding: ImageDetailsPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGESTICDASHBOARD,
      page: () => LogesticdashboardView(),
      binding: LogesticdashboardBinding(),
    ),
    GetPage(
      name: _Paths.UP_COMING_RIDE_DETAILS_PAGE,
      page: () => UpComingRideDetailsPageView(),
      binding: UpComingRideDetailsPageBinding(),
    ),
    GetPage(
      name: _Paths.HELP_LINE_SCREEN,
      page: () =>  HelpLineScreenView(),
      binding: HelpLineScreenBinding(),
    ),
  ];
}
