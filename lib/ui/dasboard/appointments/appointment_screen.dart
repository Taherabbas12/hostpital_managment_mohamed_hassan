import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostpital_managment/controllers/appointment_controller.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

import '../../../data/models/appointment_model.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/shadow_values.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/more_widgets.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({super.key});
  AppointmentController appointmentController =
      Get.find<AppointmentController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: Values.circle * 0.5),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Values.circle),
                child: InkWell(
                  borderRadius: BorderRadius.circular(Values.circle),
                  onTap: appointmentController.selectDateTimeFilter,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(1),

                    decoration: BoxDecoration(
                      boxShadow: ShadowValues.shadowValues2,

                      border: Border.all(
                        color: ColorApp.subColor.withAlpha(150),
                      ),
                      borderRadius: BorderRadius.circular(Values.circle),
                    ),
                    width: 300,
                    child: Obx(
                      () => Text(
                        appointmentController.dateTimeFilter.value != null
                            ? getFormattedDateOnlyDate(
                              appointmentController.dateTimeFilter.value
                                  .toString(),
                            )
                            : 'اختر التاريخ',
                        style: StringStyle.headerStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BottonsC.actionIcon(
              size: 44,
              CupertinoIcons.trash,
              color: ColorApp.redColor,
              'حذف التاريخ المحدد',
              appointmentController.clearFilter,
            ),
            SizedBox(width: Values.circle),
          ],
        ),
        Expanded(
          child: Obx(() {
            if (appointmentController.appointmentsSelectDateFilter.isEmpty) {
              return Center(
                child: Text(
                  'لا يوجد حجوزات.',
                  style: StringStyle.headLineStyle2,
                ),
              );
            }
            return ListView.builder(
              itemCount:
                  appointmentController.appointmentsSelectDateFilter.length,
              itemBuilder: (context, index) {
                Appointment patient =
                    appointmentController.appointmentsSelectDateFilter[index];
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
                        '${patient.appointmentDate}  ${int.parse(patient.appointmentNumber) % 12}:30 ${int.parse(patient.appointmentNumber) > 12 ? 'PM' : 'AM'}',
                        style: StringStyle.headerStyle,
                      ), // اسم المريض فقط

                      children: [
                        SizedBox(
                          width: Values.width,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              textValue(
                                'الدكتور: ${patient.doctorName}',
                                Icons.person,
                              ),
                              textValue(
                                'المراجع: ${patient.patientName}',
                                Icons.merge_type,
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
                                // patientController.editPatien(patient);
                              },
                            ),
                            IconButton(
                              icon: Icon(CupertinoIcons.trash),
                              color: const Color.fromARGB(255, 239, 21, 21),
                              onPressed: () {
                                // patientController.confirmDeletePatient(patient);
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
