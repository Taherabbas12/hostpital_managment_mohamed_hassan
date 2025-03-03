import 'package:get/get.dart';

import '../controllers/appointment_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/doctor_controller.dart';
import '../controllers/patient_controller.dart';

class AppBindings extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(() => DashboardController()),
      Bind.lazyPut(() => PatientController(), fenix: true),
      Bind.lazyPut(() => DoctorController(), fenix: true),
      Bind.lazyPut(() => AppointmentController(), fenix: true),
    ];
  }
}
