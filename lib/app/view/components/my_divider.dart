import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 2,
      endIndent: 15,
      indent: 15,
      color: Constants.myGrey,
    );
  }
}
