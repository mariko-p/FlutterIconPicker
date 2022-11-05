/// IconSearchbar
/// Author Rebar Ahmad
/// https://github.com/Ahmadre
/// rebar.ahmad@gmail.com

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/controllers/icon_controller.dart';
import 'package:provider/provider.dart';
import '../Helpers/ColorBrightness.dart';
import '../Models/IconPack.dart';
import 'icons.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    required this.iconController,
    required this.iconPack,
    required this.searchHintText,
    required this.searchClearIcon,
    required this.backgroundColor,
    this.customIconPack,
    this.iconColor,
    Key? key,
  }) : super(key: key);

  final IconController iconController;
  final List<IconPack>? iconPack;
  final Map<String, IconData>? customIconPack;
  final String? searchHintText;
  final Icon? searchClearIcon;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  _search(String searchValue) {
    Map<String, IconData> searchResult = Map<String, IconData>();

    for (var pack in widget.iconPack!) {
      IconManager.getSelectedPack(pack).forEach((String key, IconData val) {
        if (key.toLowerCase().contains(searchValue.toLowerCase())) {
          searchResult.putIfAbsent(key, () => val);
        }
      });
    }

    if (widget.customIconPack != null) {
      widget.customIconPack!.forEach((String key, IconData val) {
        if (key.toLowerCase().contains(searchValue.toLowerCase())) {
          searchResult.putIfAbsent(key, () => val);
        }
      });
    }

    setState(() {
      if (searchResult.length != 0) {
        widget.iconController.icons = searchResult;
      } else {
        widget.iconController.removeAll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IconController>(builder: (ctx, controller, _) {
      return SizedBox(
        height: 32,
        child: TextField(
          onChanged: (val) => _search(val),
          controller: controller.searchTextController,
          textAlign: TextAlign.justify,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: ColorBrightness(widget.backgroundColor!).isLight()
                ? Colors.black
                : Colors.white,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5),
            ),
            filled: true,
            fillColor: Color.alphaBlend(
              Color(0xf4ffffff),
              Color(0xff2979FF),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
            hintStyle: TextStyle(
              color: ColorBrightness(widget.backgroundColor!).isLight()
                  ? Colors.black54
                  : Colors.white54,
              fontSize: 14,
            ),
            hintText: widget.searchHintText,
            suffixIcon: AnimatedSwitcher(
              child: controller.searchTextController.text.isNotEmpty
                  ? IconButton(
                      color: widget.iconColor,
                      icon: widget.searchClearIcon!,
                      onPressed: () => setState(() {
                        controller.searchTextController.clear();
                        if (widget.customIconPack != null)
                          controller.addAll(widget.customIconPack ?? {});

                        if (widget.iconPack != null)
                          for (var pack in widget.iconPack!) {
                            controller.addAll(
                              IconManager.getSelectedPack(pack),
                            );
                          }
                      }),
                    )
                  : const SizedBox(
                      width: 10,
                    ),
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
      );
    });
  }
}
