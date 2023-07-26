import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:i_note/utils/common/colors.dart';

import 'package:i_note/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
            color: AppColor.kblack,
          ),
        ),
      ),
      home:  const SplashScreen(),
    );
  }
}