/// FlutterIconMap
/// Author Rebar Ahmad
/// https://github.com/Ahmadre
/// rebar.ahmad@gmail.com

export 'Packs/Material.dart';
export 'Packs/Cupertino.dart';
export 'Packs/FontAwesome.dart';
export 'Packs/LineIcons.dart';

import '../Models/IconPack.dart';

import 'Packs/Material.dart';
import 'Packs/Cupertino.dart';
import 'Packs/FontAwesome.dart';
import 'Packs/LineIcons.dart';

import 'package:flutter/widgets.dart';

typedef FilterFunction = bool Function(
  String key,
  IconData iconData,
);

class IconManager {
  static Map<String, IconData> getSelectedPack({
    required IconPack? pickedPack,
    FilterFunction? filterFunction,
  }) {
    switch (pickedPack) {
      case IconPack.material:
        return Map.fromEntries(icons.entries.where((element) =>
            filterFunction?.call(element.key, element.value) ?? true));
      case IconPack.cupertino:
        return Map.fromEntries(cupertinoIcons.entries.where((element) =>
            filterFunction?.call(element.key, element.value) ?? true));
      case IconPack.fontAwesomeIcons:
        return Map.fromEntries(fontAwesomeIcons.entries.where((element) =>
            filterFunction?.call(element.key, element.value) ?? true));
      case IconPack.lineAwesomeIcons:
        return Map.fromEntries(lineAwesomeIcons.entries.where((element) =>
            filterFunction?.call(element.key, element.value) ?? true));
      default:
        return <String, IconData>{};
    }
  }
}
