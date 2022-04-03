import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';

class ButtonEditIcon extends StatelessWidget {
  final Function _onPressed;

  const ButtonEditIcon(this._onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      label: 'Editar',
      icon: Icons.edit,
      backgroundColor: Constants.myDarkBeige,
      foregroundColor: Constants.myOrange,
      onPressed: (ctx) => _onPressed(),
    );
  }
}
