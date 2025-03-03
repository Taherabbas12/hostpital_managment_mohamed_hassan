import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/app_pages.dart';
import 'utils/constants/color_app.dart';
import 'utils/constants/values_constant.dart';
// import 'app/utils/constants/values_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Values.width = MediaQuery.sizeOf(context).width;
    Values.height = MediaQuery.sizeOf(context).height;
    return
    //  ScreenUtilInit(
    //   designSize: Size(
    //     MediaQuery.sizeOf(context).width,
    //     MediaQuery.sizeOf(context).height,
    //   ), // حجم التصميم (عرض × ارتفاع)
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //   builder: (context, child) {
    //     return
    GetMaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: AppPages.INITIAL,
      theme: ThemeData(
        textTheme: GoogleFonts.almaraiTextTheme(),
        // textTheme: GoogleFonts.readexProTextTheme(),
        fontFamily: 'readexPro',

        appBarTheme: AppBarTheme(backgroundColor: ColorApp.greenColor),
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        // احسب معامل التحجيم بناءً على عرض الشاشة
        double textScaleFactor =
            mediaQuery.size.width / 400; // 400 هي قيمة مرجعية

        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(textScaleFactor.clamp(0.7, 0.9)),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
        );
      },
      getPages: AppPages.routes,
    );
  }
}
