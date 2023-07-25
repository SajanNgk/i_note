import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_note/utils/common/colors.dart';
import 'package:i_note/view/home_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColor.kwhite,
        primaryColor: AppColor.kblack,
        barBackgroundColor: AppColor.kwhite,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            color: AppColor.kblack, // Customize text color
          ),
        ),
      ),
      home: Homepage(),
    );
  }
}
