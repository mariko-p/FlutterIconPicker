/// IconPicker
/// Author Rebar Ahmad
/// https://github.com/Ahmadre
/// rebar.ahmad@gmail.com

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/controllers/icon_controller.dart';
import 'package:provider/provider.dart';
import 'icons.dart';
import '../Models/IconPack.dart';
import '../Helpers/ColorBrightness.dart';

class IconPicker extends StatefulWidget {
  final IconController iconController;
  final List<IconPack>? iconPack;
  final Map<String, IconData>? customIconPack;
  final double? iconSize;
  final Color? iconColor;
  final String? noResultsText;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final Color? backgroundColor;
  final bool? showTooltips;
  final String? selectedIconKey;
  final Function(String?)? onTap;

  const IconPicker({
    Key? key,
    required this.iconController,
    required this.iconPack,
    required this.iconSize,
    required this.noResultsText,
    required this.backgroundColor,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.iconColor,
    this.showTooltips,
    this.customIconPack,
    this.selectedIconKey,
    this.onTap,
  }) : super(key: key);

  @override
  _IconPickerState createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  String? selectedIconKey;
  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.customIconPack != null) {
        if (mounted) widget.iconController.addAll(widget.customIconPack ?? {});
      }

      if (widget.iconPack != null)
        for (var pack in widget.iconPack!) {
          if (mounted)
            widget.iconController.addAll(IconManager.getSelectedPack(pack));
        }
    });
  }

  Widget _getListEmptyMsg() => Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: RichText(
            text: TextSpan(
              text: widget.noResultsText! + ' ',
              style: TextStyle(
                color: ColorBrightness(widget.backgroundColor!).isLight()
                    ? Colors.black
                    : Colors.white,
              ),
              children: [
                TextSpan(
                  text: widget.iconController.searchTextController.text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorBrightness(widget.backgroundColor!).isLight()
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  bool isItemSelected(String key) {
    return isItemInitiallySelected(key) || isItemNewlySelected(key);
  }

  bool isItemInitiallySelected(String key) {
    return isEdited == false &&
        widget.selectedIconKey != null &&
        widget.selectedIconKey == key;
  }

  bool isItemNewlySelected(String key) {
    return isEdited == true &&
        selectedIconKey != null &&
        selectedIconKey == key;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IconController>(
      builder: (ctx, controller, _) => Stack(
        children: <Widget>[
          if (controller.icons.length == 0)
            _getListEmptyMsg()
          else
            Positioned.fill(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 1 / 1,
                      maxCrossAxisExtent: 75,
                    ),
                    itemBuilder: (context, index) {
                      var item = controller.entries.elementAt(index);

                      return Material(
                        color: Colors.white,
                        child: InkWell(
                          customBorder: new CircleBorder(),
                          onTap: () {
                            if (selectedIconKey == item.key) {
                              widget.onTap?.call(null);
                            } else {
                              widget.onTap?.call(item.key);
                            }

                            setState(() {
                              if (selectedIconKey == item.key) {
                                selectedIconKey = null;
                              } else {
                                selectedIconKey = item.key;
                              }
                              isEdited = true;
                            });
                          },
                          child: Center(
                            child: Container(
                              decoration: isItemSelected(item.key)
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xff05AD56),
                                        style: BorderStyle.solid,
                                      ),
                                    )
                                  : null,
                              width: 30,
                              height: 30,
                              child: Center(
                                child: widget.showTooltips!
                                    ? Tooltip(
                                        message: item.key,
                                        child: Icon(
                                          item.value,
                                          size: widget.iconSize,
                                          color: widget.iconColor,
                                        ),
                                      )
                                    : Icon(
                                        item.value,
                                        size: widget.iconSize,
                                        color: widget.iconColor,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.lerp(
                        Alignment.topCenter, Alignment.center, .05)!,
                    colors: [
                      widget.backgroundColor!,
                      widget.backgroundColor!.withOpacity(.1),
                    ],
                    stops: [
                      0.0,
                      1.0
                    ]),
              ),
              child: Container(),
            ),
          ),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.lerp(
                        Alignment.bottomCenter, Alignment.center, .05)!,
                    colors: [
                      widget.backgroundColor!,
                      widget.backgroundColor!.withOpacity(.1),
                    ],
                    stops: [
                      0.0,
                      1.0
                    ]),
              ),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}
