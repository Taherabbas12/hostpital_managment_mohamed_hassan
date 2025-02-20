// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

import '../../controllers/dashboard_controller.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/values_constant.dart';
import '../widgets/actions_button.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  DashboardController dashboardController = Get.find<DashboardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () => Text(
            dashboardController.getTitle(),
            style: StringStyle.textButtom,
          ),
        ),
        backgroundColor: ColorApp.secondryColor,
      ),
      body: SafeArea(child: Obx(() => dashboardController.getWidget())),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () =>
            dashboardController.indexView.value > 0 &&
                    dashboardController.indexView.value < 4
                ? SizedBox(
                  width: Values.width * 0.5,
                  child: BottonsC.action2(
                    dashboardController.getText(),
                    dashboardController.viewAddAnyType,
                    color: ColorApp.secondryColor,
                  ),
                )
                : SizedBox(),
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
