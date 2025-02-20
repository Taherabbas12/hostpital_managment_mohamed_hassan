import 'package:flutter/material.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('المواعيد', style: StringStyle.headLineStyle2)),
    );
  }
}
