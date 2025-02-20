// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../bindings/app_binding.dart';
import '../ui/dasboard/dashboard_screen.dart';

part 'app_routes.dart';

class AppPages {
  static String INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardScreen(),
      binding: AppBindings(),
    ),
  ];
}
