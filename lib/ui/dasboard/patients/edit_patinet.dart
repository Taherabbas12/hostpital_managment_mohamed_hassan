import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class EditPatinet extends StatelessWidget {
  EditPatinet({super.key});
  PatientController patientController = Get.find<PatientController>();
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

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'اضافة المراجع',
                  style: StringStyle.headLineStyle2.copyWith(
                    color: ColorApp.greenColor,
                  ),
                ),
                SizedBox(height: Values.circle * 0.5),
                InputText.inputStringValidator(
                  'اسم المراجع',
                  patientController.namePatient,
                  validator:
                      (value) => Validators.notEmpty(value, 'اسم المراجع'),
                ),

                //
                InkWell(
                  onTap: patientController.selectGender,
                  child: Container(
                    margin: EdgeInsets.all(Values.circle * 0.5),
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
                            : 'جنس المراجع',
                      ),
                    ),
                  ),
                ),

                //
                InputText.inputStringValidator(
                  isNumber: 2,
                  'عمر المراجع',
                  patientController.agePatient,
                  validator:
                      (value) => Validators.notEmpty(value, 'عمر المراجع'),
                ),
                InputText.inputStringValidator(
                  'عنوان المراجع',
                  patientController.addressPatient,
                  validator:
                      (value) => Validators.notEmpty(value, 'عنوان المراجع'),
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
                                'تعديل المراجع',
                                patientController.updataPatien,
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
