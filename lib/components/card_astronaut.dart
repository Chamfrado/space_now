import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';

GFCard card_astronaut({String name = '', String aircraft = ''}) {
  return GFCard(
    boxFit: BoxFit.cover,
    title: GFListTile(
      title: GFTypography(
        text: name,
        type: GFTypographyType.typo4,
        textColor: GFColors.WHITE,
        dividerColor: GFColors.DARK,
      ),
      subTitle: GFTypography(
        text: "Espaçonave: $aircraft",
        type: GFTypographyType.typo6,
        textColor: GFColors.WHITE,
        dividerColor: GFColors.DARK,
      ),
    ),
    color: GFColors.DARK,
  );
}
