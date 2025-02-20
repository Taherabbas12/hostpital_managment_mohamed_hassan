import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/dasboard/appointments/appointment_screen.dart';
import '../ui/dasboard/doctors/add_Doctor.dart';
import '../ui/dasboard/doctors/doctor_screen.dart';
import '../ui/dasboard/home/home_screen.dart';
import '../ui/dasboard/patients/add_patinet.dart';
import '../ui/dasboard/patients/patient_screen.dart';
import '../ui/dasboard/profile/profile_screen.dart';

class DashboardController extends GetxController {
  //
  List<WidgetIconTitle> widgets = [
    WidgetIconTitle('الرئيسية', Icons.home, HomeScreen()),
    WidgetIconTitle('المرضى', CupertinoIcons.person_2, PatientScreen()),
    WidgetIconTitle('الأطباء', Icons.house_outlined, DoctorScreen()),
    WidgetIconTitle('المواعيد', Icons.timelapse_rounded, AppointmentScreen()),
    WidgetIconTitle(
      'الملف الشخصي',
      CupertinoIcons.person_alt_circle,
      ProfileScreen(),
    ),
  ];
  RxInt indexView = RxInt(0);
  Widget getWidget() => widgets[indexView.value].widget;
  void changeIndexView(int index) {
    indexView.value = index;
  }

  //Floating Action Buttons
  void viewAddAnyType() {
    if (indexView.value == 1) {
      Get.generalDialog(
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: (context, animation, secondaryAnimation) => AddPatinet(),
      );
    } else if (indexView.value == 2) {
      Get.generalDialog(
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: (context, animation, secondaryAnimation) => AddDoctor(),
      );
    }
  }
}

//Model
class WidgetIconTitle {
  String name;
  IconData icon;
  Widget widget;
  WidgetIconTitle(this.name, this.icon, this.widget);
}
