class Patient {
  int? id;
  String name;
  int age;
  String gender;
  String address;
  String phone;

  Patient({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'address': address,
      'phone': phone,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      address: map['address'],
      phone: map['phone'],
    );
  }
}
