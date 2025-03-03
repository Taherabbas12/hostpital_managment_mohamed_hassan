// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostpital_managment/data/models/doctor_model.dart';
import 'package:hostpital_managment/ui/widgets/input_text.dart';
import 'package:hostpital_managment/utils/constants/shadow_values.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

import '../../../controllers/doctor_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/values_constant.dart';

class DoctorScreen extends StatelessWidget {
  DoctorScreen({super.key});
  DoctorController patientController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: Values.circle * 0.5),
        InputText.inputStringValidator(
          'ابحث عن اسم الدكتور',
          patientController.searchPatient,
          validator: (e) => null,
        ),
        Expanded(
          child: Obx(() {
            if (patientController.doctorsList.isEmpty) {
              return Center(
                child: Text(
                  'لا يوجد دكاترة.',
                  style: StringStyle.headLineStyle2.copyWith(
                    color: ColorApp.redColor,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: patientController.doctorsList.length,
              itemBuilder: (context, index) {
                Doctor patient = patientController.doctorsList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: ShadowValues.shadowValues,
                      color: ColorApp.backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Values.circle),
                        topRight: Radius.circular(Values.circle),
                        bottomLeft: Radius.circular(Values.circle * 0.3),
                        bottomRight: Radius.circular(Values.circle * 0.3),
                      ),
                      border: Border.all(
                        color: ColorApp.borderColor,
                        width: 0.5,
                      ),
                    ),
                    child: ExpansionTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Values.circle),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Values.circle),
                      ),

                      backgroundColor: ColorApp.backgroundColor,
                      title: Text(
                        patient.name,
                        style: StringStyle.headerStyle,
                      ), // اسم المريض فقط

                      children: [
                        SizedBox(
                          width: Values.width,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              textValue(
                                'التخصص: ${patient.specialty}',
                                Icons.person,
                              ),
                              textValue(
                                'الجنس: ${patient.gender}',
                                Icons.merge_type,
                              ),
                              textValue(
                                'رقم الهاتف: ${patient.phone}',
                                CupertinoIcons.phone,
                              ),
                              textValue(
                                'العنوان: ${patient.address}',
                                CupertinoIcons.location,
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: ColorApp.textFourColor,
                              onPressed: () {
                                patientController.editPatien(patient);
                              },
                            ),
                            IconButton(
                              icon: Icon(CupertinoIcons.trash),
                              color: const Color.fromARGB(255, 239, 21, 21),
                              onPressed: () {
                                patientController.confirmDeletePatient(patient);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget textValue(String name, IconData icons) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: Values.circle,
      vertical: Values.circle * 0.5,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icons, color: ColorApp.subColor),
        SizedBox(width: 5),
        Text(name, style: StringStyle.textLabilBold),
      ],
    ),
  );
}
