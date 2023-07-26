import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:i_note/utils/common/colors.dart';
import 'package:i_note/utils/common/textstyles.dart';
import 'package:i_note/view/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadHomePage();
  }

  Future<void> _loadHomePage() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => const Homepage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColor.kwhite,
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              "I_NOTE",
              textStyle: CustomTextStyles.h3,
              speed: const Duration(milliseconds: 200),
            ),
          ],
          totalRepeatCount: 1,
          onFinished: () => _loadHomePage(),
        ),
      ),
    );
  }
}
