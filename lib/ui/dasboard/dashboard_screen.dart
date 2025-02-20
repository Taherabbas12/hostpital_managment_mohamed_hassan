// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/dashboard_controller.dart';
import '../../utils/constants/color_app.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  DashboardController dashboardController = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() => dashboardController.getWidget())),
      floatingActionButton: FloatingActionButton(
        onPressed: dashboardController.viewAddAnyType,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: dashboardController.changeIndexView,
          //
          currentIndex: dashboardController.indexView.value,
          //
          selectedItemColor: ColorApp.secondryColor,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 16,
          selectedIconTheme: IconThemeData(size: 30),
          items:
              dashboardController.widgets
                  .map(
                    (e) => BottomNavigationBarItem(
                      icon: Icon(e.icon),
                      label: e.name,
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
