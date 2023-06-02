import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/icon_picker_with_search.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedIconKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Flutter Icon Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IconPickerWithSearch(
                  iconPackMode: [
                    IconPack.material,
                  ],
                  iconSize: 20,
                  searchClearIconColor: Colors.black,
                  iconColor: Colors.black,
                  backgroundColor: Colors.white,
                  selectedIconKey: selectedIconKey,
                  onTap: (String? iconName, int? iconCodePoint) {
                    setState(
                      () {
                        if (selectedIconKey != null &&
                            selectedIconKey == iconName) {
                          selectedIconKey = null;
                        } else {
                          selectedIconKey = iconName;
                        }
                      },
                    );
                  },
                  filterFunction: (key, iconDataWithSearchTags) =>
                      !key.endsWith("_sharp") &&
                      !key.endsWith("_rounded") &&
                      !key.endsWith("_outlined"),
                  crossAxisCount: 5,
                  languageCode: 'en',
                  noResultsText: 'No results for: ',
                  searchHintText: 'Search icon by name',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
