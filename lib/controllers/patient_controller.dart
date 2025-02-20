import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hostpital_managment/ui/widgets/message_snak.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

import '../data/models/patient_model.dart';
import '../data/repositories/database_helper.dart';
import '../ui/dasboard/patients/edit_patinet.dart';
import '../ui/widgets/common/loading_indicator.dart';
import '../ui/widgets/common/show_modal_bottom_sheet_c.dart';
import '../utils/constants/color_app.dart';
import '../utils/constants/values_constant.dart';

class PatientController extends GetxController {
  //
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController searchPatient = TextEditingController();
  TextEditingController namePatient = TextEditingController();
  TextEditingController agePatient = TextEditingController();
  TextEditingController addressPatient = TextEditingController();
  TextEditingController phoneNumberPatient = TextEditingController();
  RxString gender = RxString('');
  RxBool isLoading = false.obs;
  void addPatien() async {
    if (formKey.currentState!.validate() && gender.isNotEmpty) {
      isLoading(true);
      await addPatient(
        Patient(
          address: addressPatient.text.trim(),
          age: int.parse(agePatient.text.trim()),
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
    agePatient.text = '';
    gender.value = '';
    namePatient.text = '';
    phoneNumberPatient.text = '';
  }

  //
  Patient? patientUpdata;
  void editPatien(Patient patient) {
    patientUpdata = patient;
    addressPatient.text = patient.address;
    agePatient.text = patient.age.toString();
    gender.value = patient.gender;
    namePatient.text = patient.name;
    phoneNumberPatient.text = patient.phone;

    Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation, secondaryAnimation) => EditPatinet(),
    );
  }

  void updataPatien() async {
    if (formKey.currentState!.validate() && gender.isNotEmpty) {
      isLoading(true);
      patientUpdata!.address = addressPatient.text.trim();
      patientUpdata!.age = int.parse(agePatient.text.trim());
      patientUpdata!.gender = gender.value;
      patientUpdata!.name = namePatient.text.trim();
      patientUpdata!.phone = phoneNumberPatient.text.trim();

      await Future.delayed(Duration(seconds: 1));

      await updatePatient(patientUpdata!);

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
  Future<void> confirmDeletePatient(Patient patient) async {
    showDialog(
      context: Get.context!,
      builder:
          (context) => AlertDialog(
            title: const Text('تأكيد الحذف'),
            content: Text('هل أنت متأكد أنك تريد حذف  (${patient.name})'),
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
                        await deletePatient(patient.id!);
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
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var patientsList = <Patient>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPatients();
    searchPatient.addListener(() {
      //
      fetchPatients();
    });
  }

  Future<void> fetchPatients() async {
    final db = await _dbHelper.database;

    List<Map<String, dynamic>> maps;

    if (searchPatient.text.trim().isNotEmpty) {
      // البحث عن المرضى الذين يحتوي اسمهم على النص المدخل
      maps = await db.query(
        'patients',
        where: 'name LIKE ?',
        whereArgs: [
          '%${searchPatient.text.trim()}%',
        ], // البحث باستخدام النسبة المئوية للبحث الجزئي
      );
    } else {
      // جلب جميع المرضى إذا لم يتم توفير اسم
      maps = await db.query('patients');
    }

    patientsList.assignAll(maps.map((map) => Patient.fromMap(map)).toList());
  }

  Future<void> addPatient(Patient patient) async {
    final db = await _dbHelper.database;
    await db.insert('patients', patient.toMap());
    fetchPatients();
  }

  Future<void> updatePatient(Patient patient) async {
    print("AAAA");

    print(patient.toMap());
    print("AAAA");
    final db = await _dbHelper.database;
    await db.update(
      'patients',
      patient.toMap(),
      where: 'id = ?',
      whereArgs: [patient.id],
    );
    fetchPatients();
  }

  Future<void> deletePatient(int id) async {
    final db = await _dbHelper.database;
    await db.delete('patients', where: 'id = ?', whereArgs: [id]);
    fetchPatients();
  }
}
