// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostpital_managment/controllers/appointment_controller.dart';
import 'package:hostpital_managment/controllers/doctor_controller.dart';
import 'package:hostpital_managment/ui/widgets/message_snak.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

import '../../../controllers/patient_controller.dart';
import '../../../data/models/appointment_model.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/shadow_values.dart';
import '../../../utils/constants/values_constant.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/more_widgets.dart';

class AddAppointment extends StatelessWidget {
  AddAppointment({super.key});
  PatientController patientController = Get.find<PatientController>();
  DoctorController doctorController = Get.find<DoctorController>();
  AppointmentController appointmentController =
      Get.find<AppointmentController>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      child: Container(
        width: Values.width * 0.9,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: Values.spacerV),
          child: Form(
            key: patientController.formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'اضافة حجز',
                  style: StringStyle.headLineStyle2.copyWith(
                    color: ColorApp.greenColor,
                  ),
                ),
                SizedBox(height: Values.circle),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: Values.circle),

                  decoration: BoxDecoration(
                    boxShadow: ShadowValues.shadowValues2,
                    border: Border.all(color: ColorApp.subColor.withAlpha(150)),
                    borderRadius: BorderRadius.circular(Values.circle),
                  ),
                  width: 300,
                  child: Obx(() {
                    return DropdownButton(
                      underline: SizedBox(),
                      padding: EdgeInsets.symmetric(
                        horizontal: Values.circle * 2,
                      ),
                      hint: Text('اختر الدكتور'),
                      value: doctorController.selectDoctor.value,
                      items:
                          doctorController.doctorsList
                              .map(
                                (element) => DropdownMenuItem(
                                  value: element,
                                  child: SizedBox(
                                    width: 240,
                                    child: Text(element.name),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        doctorController.selectDoctor.value = value;
                      },
                    );
                  }),
                ),
                SizedBox(height: Values.circle),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Values.circle),

                  decoration: BoxDecoration(
                    boxShadow: ShadowValues.shadowValues2,
                    border: Border.all(color: ColorApp.subColor.withAlpha(150)),
                    borderRadius: BorderRadius.circular(Values.circle),
                  ),
                  width: 300,
                  child: Obx(() {
                    return DropdownButton(
                      underline: SizedBox(),
                      padding: EdgeInsets.symmetric(
                        horizontal: Values.circle * 2,
                      ),
                      hint: Text('اختر المراجع'),
                      value: patientController.selectPatient.value,
                      items:
                          patientController.patientsList
                              .map(
                                (element) => DropdownMenuItem(
                                  value: element,
                                  child: SizedBox(
                                    width: 240,
                                    child: Text(element.name),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        patientController.selectPatient.value = value;
                      },
                    );
                  }),
                ),
                SizedBox(height: Values.circle),

                //
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Values.circle),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Values.circle),
                    onTap: appointmentController.selectDateTime,
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
                          appointmentController.dateTime.value != null
                              ? getFormattedDateOnlyDate(
                                appointmentController.dateTime.value.toString(),
                              )
                              : 'اختر التاريخ',
                          style: StringStyle.headerStyle,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 200,
                  width: 300,
                  child: Center(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2,
                      ),

                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap:
                              () =>
                                  !appointmentController.checkAppointment(index)
                                      ? appointmentController
                                          .selectChangeAppointment(index)
                                      : MessageSnak.message('هذا الموعد محجوز'),
                          child: Obx(() {
                            return Container(
                              margin: EdgeInsets.all(Values.circle * 0.3),
                              decoration: BoxDecoration(
                                color:
                                    appointmentController.checkAppointment(
                                          index,
                                        )
                                        ? ColorApp.redColor
                                        : appointmentController
                                                .selectAppointment
                                                .value ==
                                            index
                                        ? ColorApp.secondryColor
                                        : Colors.transparent,
                                border: Border.all(
                                  color: ColorApp.subColor.withAlpha(150),
                                ),
                                borderRadius: BorderRadius.circular(
                                  Values.circle,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (index + 8) < 12 ? 'AM' : 'PM',
                                    style: StringStyle.headerStyle.copyWith(
                                      color:
                                          appointmentController
                                                          .selectAppointment
                                                          .value ==
                                                      index ||
                                                  appointmentController
                                                      .checkAppointment(index)
                                              ? ColorApp.backgroundColor
                                              : ColorApp.backgroundColorContent,
                                    ),
                                  ),
                                  SizedBox(width: Values.circle * 0.3),
                                  Text(
                                    '${((index + 8) % 12).round() != 0 ? ((index + 8) % 12).round() : 12}:30',
                                    style: StringStyle.headerStyle.copyWith(
                                      color:
                                          appointmentController
                                                          .selectAppointment
                                                          .value ==
                                                      index ||
                                                  appointmentController
                                                      .checkAppointment(index)
                                              ? ColorApp.backgroundColor
                                              : ColorApp.backgroundColorContent,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                      itemCount: 9,
                    ),
                  ),
                ),
                //
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Obx(
                      () =>
                          patientController.isLoading.value
                              ? LoadingIndicator()
                              : BottonsC.action2(
                                'اضافة حجز',
                                appointmentController.addAppointmentUi,
                                color: ColorApp.greenColor,
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
