class Appointment {
  int? id;
  int patientId;
  int doctorId;
  String appointmentDate;
  String appointmentNumber;
  String status;

  // معلومات المريض
  String? patientName;
  int? patientAge;
  String? patientGender;
  String? patientAddress;
  String? patientPhone;

  // معلومات الطبيب
  String? doctorName;
  String? doctorSpecialty;
  String? doctorGender;
  String? doctorAddress;
  String? doctorPhone;

  Appointment({
    this.id,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.appointmentNumber,
    required this.status,
    this.patientName,
    this.patientAge,
    this.patientGender,
    this.patientAddress,
    this.patientPhone,
    this.doctorName,
    this.doctorSpecialty,
    this.doctorGender,
    this.doctorAddress,
    this.doctorPhone,
  });

  // تحويل الكائن إلى `Map` للتخزين في قاعدة البيانات
  Map<String, dynamic> toMap() {
    return {
      'patient_id': patientId,
      'doctor_id': doctorId,
      'appointment_date': appointmentDate,
      'appointment_number': appointmentNumber,
      'status': status,
    };
  }

  // إنشاء كائن `Appointment` من بيانات قاعدة البيانات
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      patientId: map['patient_id'],
      doctorId: map['doctor_id'],
      appointmentDate: map['appointment_date'],
      appointmentNumber: map['appointment_number'],
      status: map['status'],
      patientName: map['patient_name'],
      patientAge: map['patient_age'],
      patientGender: map['patient_gender'],
      patientAddress: map['patient_address'],
      patientPhone: map['patient_phone'],
      doctorName: map['doctor_name'],
      doctorSpecialty: map['doctor_specialty'],
      doctorGender: map['doctor_gender'],
      doctorAddress: map['doctor_address'],
      doctorPhone: map['doctor_phone'],
    );
  }
}
