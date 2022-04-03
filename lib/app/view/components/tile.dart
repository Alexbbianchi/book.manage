import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/utility/assets.dart';
import 'package:projeto_integrador_app/app/common/utility/image_parse.dart';
import 'package:projeto_integrador_app/app/view/components/my_divider.dart';

class Tile extends StatelessWidget {
  const Tile(
      {Key? key,
      this.title,
      this.subtitle,
      this.image,
      this.infoRigth,
      this.infoLeft})
      : super(key: key);

  final String? title;
  final String? subtitle;
  final String? image;
  final Widget? infoRigth;
  final Widget? infoLeft;

  dynamic _imageBook(String? uri) {
    if (uri != null) {
      return ImageParse.imageFromBase64String(uri);
    }
    return Image.asset(
      ConstantAssets.imgDefault,
      fit: BoxFit.fill,
      height: 160,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          isThreeLine: true,
          leading: _imageBook(image),
          title: Text(title!),
          subtitle: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  subtitle!,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: infoLeft ?? Expanded(flex: 1, child: infoLeft!),
                  ),
                  Expanded(
                    flex: 2,
                    child: infoRigth ?? Expanded(flex: 2, child: infoRigth!),
                  ),
                ],
              ),
            ],
          ),
        ),
        const MyDivider(),
      ],
    );
  }
}
