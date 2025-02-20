class Doctor {
  int? id;
  String name;
  String specialty;
  String gender;
  String address;
  String phone;

  Doctor({
    this.id,
    required this.name,
    required this.specialty,
    required this.gender,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'gender': gender,
      'address': address,
      'phone': phone,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'],
      name: map['name'],
      specialty: map['specialty'],
      gender: map['gender'],
      address: map['address'],
      phone: map['phone'],
    );
  }
}
