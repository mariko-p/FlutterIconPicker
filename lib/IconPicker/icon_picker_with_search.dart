import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/controllers/icon_controller.dart';
import 'package:provider/provider.dart';
import 'iconPicker.dart';
import 'icons.dart';
import 'searchBar.dart';
import '../Models/IconPack.dart';

class IconPickerWithSearch extends StatefulWidget {
  const IconPickerWithSearch({
    Key? key,
    this.showTooltips = true,
    this.iconSize = 20,
    this.searchClearIcon = const Icon(Icons.close),
    this.customIconPack,
    this.filterFunction,
    this.crossAxisCount,
    required this.searchClearIconColor,
    required this.backgroundColor,
    required this.iconPackMode,
    required this.iconColor,
    required this.selectedIconKey,
    required this.onTap,
    required this.languageCode,
    required this.noResultsText,
    required this.searchHintText,
  }) : super(key: key);

  final bool? showTooltips;
  final Icon? searchClearIcon;
  final String searchHintText;
  final String noResultsText;
  final double iconSize;
  final Color? backgroundColor;
  final List<IconPack>? iconPackMode;
  final Map<String, IconData>? customIconPack;
  final Color? iconColor;
  final Color? searchClearIconColor;
  final String? selectedIconKey;
  final Function(String?, int?)? onTap;
  final FilterFunction? filterFunction;
  final int? crossAxisCount;
  final String languageCode;

  @override
  _IconPickerWithSearchState createState() => _IconPickerWithSearchState();
}

class _IconPickerWithSearchState extends State<IconPickerWithSearch> {
  IconData? selectedIcon;
  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IconController>(
      create: (context) => IconController(),
      child: Consumer<IconController>(
        builder: (context, iconController, consumerWidget) {
          return Container(
            color: widget.backgroundColor,
            child: Column(
              children: <Widget>[
                SearchBar(
                  iconController: iconController,
                  iconPack: widget.iconPackMode,
                  customIconPack: widget.customIconPack,
                  searchClearIcon: widget.searchClearIcon,
                  iconColor: widget.searchClearIconColor,
                  searchHintText: widget.searchHintText,
                  backgroundColor: widget.backgroundColor,
                  filterFunction: widget.filterFunction,
                  languageCode: widget.languageCode,
                ),
                Expanded(
                  child: IconPicker(
                    iconController: iconController,
                    showTooltips: widget.showTooltips,
                    iconPack: widget.iconPackMode,
                    customIconPack: widget.customIconPack,
                    iconColor: widget.iconColor,
                    backgroundColor: widget.backgroundColor,
                    noResultsText: widget.noResultsText,
                    iconSize: widget.iconSize,
                    selectedIconKey: widget.selectedIconKey,
                    onTap: widget.onTap,
                    filterFunction: widget.filterFunction,
                    crossAxisCount: widget.crossAxisCount,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
