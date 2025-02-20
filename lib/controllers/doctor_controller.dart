import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart'
    show StringStyle;

import '../data/models/doctor_model.dart';
import '../data/repositories/database_helper.dart';
import '../ui/dasboard/doctors/edit_doctor.dart';
import '../ui/widgets/common/loading_indicator.dart';
import '../ui/widgets/common/show_modal_bottom_sheet_c.dart';
import '../ui/widgets/message_snak.dart';
import '../utils/constants/color_app.dart';
import '../utils/constants/values_constant.dart';

class DoctorController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController searchPatient = TextEditingController();
  TextEditingController namePatient = TextEditingController();
  TextEditingController specialtyPatient = TextEditingController();
  TextEditingController addressPatient = TextEditingController();
  TextEditingController phoneNumberPatient = TextEditingController();
  RxString gender = RxString('');
  RxBool isLoading = false.obs;
  void addPatien() async {
    if (formKey.currentState!.validate() && gender.isNotEmpty) {
      isLoading(true);
      await addDoctor(
        Doctor(
          address: addressPatient.text.trim(),
          specialty: specialtyPatient.text.trim(),
          gender: gender.value,
          name: namePatient.text.trim(),
          phone: phoneNumberPatient.text.trim(),
        ),
      );

      await Future.delayed(Duration(seconds: 1));
      isLoading(false);
      Get.backLegacy();
      clearData();
      MessageSnak.message('تمت اضافة المريض بنجاح', color: ColorApp.greenColor);
    } else {
      MessageSnak.message('يرجى ملأ كل الحقول');
    }
  }

  clearData() {
    addressPatient.text = '';
    specialtyPatient.text = '';
    gender.value = '';
    namePatient.text = '';
    phoneNumberPatient.text = '';
  }

  //
  Doctor? patientUpdata;
  void editPatien(Doctor patient) {
    patientUpdata = patient;
    addressPatient.text = patient.address;
    specialtyPatient.text = patient.specialty;
    gender.value = patient.gender;
    namePatient.text = patient.name;
    phoneNumberPatient.text = patient.phone;

    Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation, secondaryAnimation) => EditDoctor(),
    );
  }

  void updataPatien() async {
    if (formKey.currentState!.validate() && gender.isNotEmpty) {
      isLoading(true);
      patientUpdata!.address = addressPatient.text.trim();
      patientUpdata!.specialty = specialtyPatient.text.trim();
      patientUpdata!.gender = gender.value;
      patientUpdata!.name = namePatient.text.trim();
      patientUpdata!.phone = phoneNumberPatient.text.trim();

      await Future.delayed(Duration(seconds: 1));

      await updateDoctor(patientUpdata!);

      isLoading(false);
      Get.backLegacy();
      clearData();
      MessageSnak.message('تمت اضافة المريض بنجاح', color: ColorApp.greenColor);
    } else {
      MessageSnak.message('يرجى ملأ كل الحقول');
    }
  }

  //
  void selectGender() {
    List<String> genders = ['ذكر', 'أنثى'];
    ShowModalBottomSheetC.showBottomSheet2(
      data: Column(
        children:
            genders
                .map(
                  (e) => Container(
                    margin: EdgeInsets.symmetric(vertical: Values.circle),
                    width: Values.width * 0.8,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Values.circle),
                      ),
                      tileColor: ColorApp.stapperColor,
                      title: Text(e, style: StringStyle.textButtom),
                      leading: Icon(
                        e == 'ذكر' ? Icons.elderly : Icons.elderly_woman,
                        color: ColorApp.whiteColor,
                      ),

                      onTap: () {
                        gender(e);
                        Get.backLegacy();
                      },
                    ),
                  ),
                )
                .toList(),
      ),
      title: 'اختر الجنس',
    );
  }

  //
  Future<void> confirmDeletePatient(Doctor doctor) async {
    showDialog(
      context: Get.context!,
      builder:
          (context) => AlertDialog(
            title: const Text('تأكيد الحذف'),
            content: Text('هل أنت متأكد أنك تريد حذف  (${doctor.name})'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.backLegacy();
                },
                child: const Text('إلغاء'),
              ),
              Obx(() {
                return isLoading.value
                    ? LoadingIndicator()
                    : TextButton(
                      onPressed: () async {
                        isLoading(true);
                        await Future.delayed(Duration(seconds: 1));
                        await deleteDoctor(doctor.id!);
                        isLoading(false);
                        Get.backLegacy();
                      },
                      child: const Text('حذف'),
                    );
              }),
            ],
          ),
    );
  }

  //controller Database -->

  //_______----__---___---__-->
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var doctorsList = <Doctor>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('doctors');
    doctorsList.assignAll(maps.map((map) => Doctor.fromMap(map)).toList());
  }

  Future<void> addDoctor(Doctor doctor) async {
    final db = await _dbHelper.database;
    await db.insert('doctors', doctor.toMap());
    fetchDoctors();
  }

  Future<void> updateDoctor(Doctor doctor) async {
    final db = await _dbHelper.database;
    await db.update(
      'doctors',
      doctor.toMap(),
      where: 'id = ?',
      whereArgs: [doctor.id],
    );
    fetchDoctors();
  }

  Future<void> deleteDoctor(int id) async {
    final db = await _dbHelper.database;
    await db.delete('doctors', where: 'id = ?', whereArgs: [id]);
    fetchDoctors();
  }
}
