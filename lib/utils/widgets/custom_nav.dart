import 'package:flutter/cupertino.dart';

class CustomCupertinoNavBar extends StatelessWidget {
  final Widget? leading;
  final Widget middle;
  final Widget? trailing;

  const CustomCupertinoNavBar({
    Key? key,
    this.leading,
    required this.middle,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      border: null,
      leading: leading,
      middle: middle,
      trailing: trailing,
    );
  }
}
