import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hostpital_managment/controllers/doctor_controller.dart';
import 'package:hostpital_managment/controllers/patient_controller.dart';
import 'package:hostpital_managment/ui/widgets/message_snak.dart';

import '../data/models/appointment_model.dart';
import '../data/models/patient_model.dart';
import '../data/repositories/database_helper.dart';
import '../ui/widgets/common/loading_indicator.dart';
import '../ui/widgets/more_widgets.dart';
import '../utils/constants/color_app.dart';

class AppointmentController extends GetxController {
  //
  TextEditingController searchPatient = TextEditingController();
  var appointments = <Appointment>[].obs;
  var appointmentsSelectDate = <Appointment>[].obs;
  var appointmentsSelectDateFilter = <Appointment>[].obs;
  @override
  void onInit() {
    super.onInit();

    fetchAppointments().then((v) {
      print(appointments.value);

      appointmentsSelectDateFilter.value = appointments.value;
      print(appointmentsSelectDateFilter.value);
    });
  }

  // ✅ إضافة موعد جديد
  Future<void> addAppointment(Appointment appointment) async {
    final db = await _dbHelper.database;
    await db.insert('appointments', appointment.toMap());
    fetchAppointments();
  }

  // ✅ جلب جميع المواعيد مع تفاصيل المرضى والأطباء
  Future<void> fetchAppointments() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT 
        a.id, a.patient_id, a.doctor_id, a.appointment_date, a.appointment_number, a.status,
        p.name AS patient_name, p.age AS patient_age, p.gender AS patient_gender, p.address AS patient_address, p.phone AS patient_phone,
        d.name AS doctor_name, d.specialty AS doctor_specialty, d.gender AS doctor_gender, d.address AS doctor_address, d.phone AS doctor_phone
      FROM appointments a
      JOIN patients p ON a.patient_id = p.id
      JOIN doctors d ON a.doctor_id = d.id
    ''');

    appointments.value = maps.map((map) => Appointment.fromMap(map)).toList();
  }

  // ✅ تحديث موعد
  Future<void> updateAppointment(Appointment appointment) async {
    final db = await _dbHelper.database;
    await db.update(
      'appointments',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
    fetchAppointments();
  }

  // ✅ حذف موعد
  Future<void> deleteAppointment(int id) async {
    final db = await _dbHelper.database;
    await db.delete('appointments', where: 'id = ?', whereArgs: [id]);
    fetchAppointments();
  }

  RxInt time = RxInt(8);
  RxInt selectAppointment = RxInt(-1);
  void selectChangeAppointment(int index) {
    selectAppointment(index);
  }

  Rx<DateTime?> dateTime = Rx(null);

  Future<void> selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      dateTime.value = pickedDate;
      appointmentsSelectDate.value =
          appointments
              .where(
                (p0) =>
                    getFormattedDateOnlyDate(dateTime.value.toString()) ==
                    p0.appointmentDate,
              )
              .toList();
      print('_____________');
      print(appointmentsSelectDate.value);
      print('_____________');
    }
  }

  Rx<DateTime?> dateTimeFilter = Rx(null);
  Future<void> selectDateTimeFilter() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      dateTimeFilter.value = pickedDate;
      appointmentsSelectDateFilter.value =
          appointments
              .where(
                (p0) =>
                    getFormattedDateOnlyDate(dateTimeFilter.value.toString()) ==
                    p0.appointmentDate,
              )
              .toList();
      print('_____________');
      print(appointmentsSelectDate.value);
      print('_____________');
    }
  }

  void clearFilter() {
    dateTimeFilter.value = null;
    appointmentsSelectDateFilter.value = appointments.value;
  }

  bool checkAppointment(int index) {
    Appointment? select =
        appointmentsSelectDate
            .where((p0) => p0.appointmentNumber == (index + 8).toString())
            .firstOrNull;
    return select != null;
  }

  DoctorController doctorController = Get.find<DoctorController>();
  PatientController patientController = Get.find<PatientController>();
  RxBool isLoading = false.obs;
  void addAppointmentUi() async {
    if (doctorController.selectDoctor.value != null &&
        patientController.selectPatient.value != null &&
        dateTime.value != null &&
        selectAppointment.value >= 0) {
      isLoading(true);
      await addAppointment(
        Appointment(
          appointmentDate: getFormattedDateOnlyDate(dateTime.value.toString()),
          appointmentNumber: (selectAppointment.value + 8).toString(),
          doctorId: doctorController.selectDoctor.value!.id!,
          patientId: patientController.selectPatient.value!.id!,
          status: '',
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
    doctorController.selectDoctor.value = null;
    patientController.selectPatient.value = null;
    dateTime.value = null;
    selectAppointment(-1);
  }

  //

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
                        // await deletePatient(patient.id!);
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
}
