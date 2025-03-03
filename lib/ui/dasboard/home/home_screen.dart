import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostpital_managment/controllers/appointment_controller.dart';
import 'package:hostpital_managment/controllers/doctor_controller.dart';
import 'package:hostpital_managment/controllers/patient_controller.dart';
import 'package:hostpital_managment/utils/constants/shadow_values.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';
import '../appointments/appointment_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  DoctorController doctorController = Get.find<DoctorController>();
  PatientController patientController = Get.find<PatientController>();
  AppointmentController appointmentController =
      Get.find<AppointmentController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 110,
            child: Row(
              children: [
                SizedBox(width: Values.circle * 0.5),
                viewTotal(
                  'المراجعين',
                  patientController.patientsList.length.toString(),
                ),
                SizedBox(width: Values.circle * 0.5),
                viewTotal(
                  'الدكاترة',
                  doctorController.doctorsList.length.toString(),
                ),
                SizedBox(width: Values.circle * 0.5),
                viewTotal(
                  'الحجوزات',
                  appointmentController.appointments.length.toString(),
                ),
                SizedBox(width: Values.circle * 0.5),
              ],
            ),
          ),

          Expanded(child: AppointmentScreen()),
        ],
      ),
    );
  }

  Widget viewTotal(String name, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Values.circle * 0.3,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: ColorApp.headerColor,
          boxShadow: ShadowValues.shadowValuesBlur,
          borderRadius: BorderRadius.circular(Values.circle),
          border: Border.all(color: ColorApp.borderColor),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: StringStyle.headLineStyle2.copyWith(
                color: ColorApp.greenColor,
              ),
            ),
            Text(name, style: StringStyle.headerStyle.copyWith()),
          ],
        ),
      ),
    );
  }
}
