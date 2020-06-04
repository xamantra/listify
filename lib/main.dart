import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import 'src/components/current-list/index.dart';
import 'src/components/input/index.dart';
import 'src/components/list/index.dart';
import 'src/components/settings/index.dart';
import 'src/components/theme/index.dart';
import 'src/services/client_db.dart';
import 'src/widgets/pages/add-list.dart';
import 'src/widgets/pages/home.dart';
import 'src/widgets/pages/settings.dart';
import 'src/widgets/pages/view-list.dart';

void main() {
  runApp(
    Momentum(
      child: MyApp(),
      controllers: [
        ListController(),
        InputController()..config(maxTimeTravelSteps: 200),
        SettingsController(),
        CurrentListController(),
        ThemeController(),
      ],
      services: [
        ClientDB(),
        Router([
          Home(),
          AddNewList(),
          Settings(),
          ViewList(),
        ]),
      ],

      /* Persistent state, save data function. */
      persistSave: (context, key, value) async {
        var sharedPref = await ClientDB.getByContext(context);
        var result = await sharedPref.setString(key, value);
        return result;
      },

      /* Persistent state, get data function. */
      persistGet: (context, key) async {
        var sharedPref = await ClientDB.getByContext(context);
        var result = sharedPref.getString(key);
        return result;
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [ThemeController],
      builder: (context, snapshot) {
        var theme = snapshot<ThemeModel>().controller.selectedTheme();
        return MaterialApp(
          title: 'Listify - Momentum Demo',
          theme: ThemeData(
            primarySwatch: theme.primary,
            accentColor: theme.accent,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: Router.getActivePage(context), // persistent routing/navigation
        );
      },
    );
  }
}
