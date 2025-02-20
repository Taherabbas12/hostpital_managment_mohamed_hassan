import 'package:flutter/material.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('الملف الشخصي', style: StringStyle.headLineStyle2),
      ),
    );
  }
}
