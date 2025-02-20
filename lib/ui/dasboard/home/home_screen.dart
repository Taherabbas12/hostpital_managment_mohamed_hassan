import 'package:flutter/material.dart';
import 'package:hostpital_managment/utils/constants/style_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('الرئيسية', style: StringStyle.headLineStyle2)),
    );
  }
}
