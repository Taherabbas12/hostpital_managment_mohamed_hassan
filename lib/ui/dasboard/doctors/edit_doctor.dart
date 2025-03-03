import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostpital_managment/controllers/doctor_controller.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

import '../../../controllers/patient_controller.dart';
import '../../../utils/constants/color_app.dart';
import '../../../utils/constants/shadow_values.dart';
import '../../../utils/constants/values_constant.dart';
import '../../../utils/validators.dart';
import '../../widgets/actions_button.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/show_modal_bottom_sheet_c.dart';
import '../../widgets/input_text.dart';

class EditDoctor extends StatelessWidget {
  EditDoctor({super.key});
  DoctorController patientController = Get.find<DoctorController>();
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'تعديل الدكتور',
                  style: StringStyle.headLineStyle2.copyWith(
                    color: ColorApp.secondryColor,
                  ),
                ),
                InputText.inputStringValidator(
                  'اسم الدكتور',
                  patientController.namePatient,
                  validator:
                      (value) => Validators.notEmpty(value, 'اسم الدكتور'),
                ),

                //
                Padding(
                  padding: EdgeInsets.all(Values.circle * 0.3),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Values.circle),
                    onTap: patientController.selectGender,
                    child: Container(
                      margin: EdgeInsets.all(Values.circle * 0.1),
                      width: 300,
                      height: 45,
                      padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Values.circle),

                        boxShadow: ShadowValues.shadowValues2,

                        border: Border.all(
                          color: ColorApp.subColor.withAlpha(150),
                          width: 0.5,
                        ),
                      ),
                      child: Obx(
                        () => Text(
                          patientController.gender.isNotEmpty
                              ? patientController.gender.value
                              : 'جنس الدكتور/ة',
                        ),
                      ),
                    ),
                  ),
                ),

                //
                InputText.inputStringValidator(
                  'تخصص الدكتور',
                  patientController.specialtyPatient,
                  validator:
                      (value) => Validators.notEmpty(value, 'تخصص الدكتور'),
                ),
                InputText.inputStringValidator(
                  'عنوان الدكتور',
                  patientController.addressPatient,
                  validator:
                      (value) => Validators.notEmpty(value, 'عنوان الدكتور'),
                ),
                InputText.inputStringValidator(
                  isNumber: 11,

                  'رقم الهاتف',
                  patientController.phoneNumberPatient,
                  validator: Validators.phone,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Obx(
                      () =>
                          patientController.isLoading.value
                              ? LoadingIndicator()
                              : BottonsC.action2(
                                'تعديل الدكتور',
                                patientController.updataPatien,
                                color: ColorApp.secondryColor,
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
