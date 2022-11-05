import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/controllers/icon_controller.dart';
import 'package:flutter_iconpicker/IconPicker/icon_picker_with_search.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:fluttericonpickerexample/app/icon_notifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  IconNotifier? notifier;
  IconController? controller;

  String? selectedIconKey;

  bool isAdaptive = true;
  bool showTooltips = false;
  bool showSearch = true;

  @override
  void initState() {
    super.initState();
    notifier = Provider.of<IconNotifier>(context, listen: false);
    controller = Provider.of<IconController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Flutter Icon Picker Demo'),
      ),
      body: ChangeNotifierProvider.value(
        value: controller,
        builder: (ctx, w) {
          print("builder");
          return Center(
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
                      iconController: controller!,
                      searchClearIconColor: Colors.black,
                      iconColor: Colors.black,
                      backgroundColor: Colors.white,
                      selectedIconKey: selectedIconKey,
                      onTap: (String? iconKey) {
                        print("Selected ${iconKey}");
                        setState(
                          () {
                            if (selectedIconKey != null &&
                                selectedIconKey == iconKey) {
                              selectedIconKey = null;
                            } else {
                              selectedIconKey = iconKey;
                            }
                          },
                        );
                      },
                    ),
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
