import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import 'src/components/current-list/index.dart';
import 'src/components/input/index.dart';
import 'src/components/list/index.dart';
import 'src/components/route/index.dart';
import 'src/components/settings/index.dart';
import 'src/components/theme/index.dart';
import 'src/pages/index.dart';
import 'src/services/client_db.dart';
import 'src/widgets/custom-theme.dart';

void main() {
  runApp(momentum());
}

Momentum momentum() {
  return Momentum(
    key: UniqueKey(),
    restartCallback: main,
    child: MyApp(),
    controllers: [
      ListController(),
      InputController()..config(maxTimeTravelSteps: 200),
      SettingsController(),
      CurrentListController(),
      ThemeController(),
      RouteController(),
    ],
    services: [
      ClientDB(),
      MomentumRouter([
        Home(),
        AddNewList(),
        Settings(),
        ViewList(),
      ]),
    ],
    persistSave: (context, key, value) async {
      var sharedPref = await (ClientDB.getByContext(context!));
      var result = await sharedPref!.setString(key, value!);
      return result;
    },
    persistGet: (context, key) async {
      var sharedPref = await (ClientDB.getByContext(context!));
      var result = sharedPref!.getString(key);
      return result;
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MomentumBuilder(
      controllers: [ThemeController],
      builder: (context, snapshot) {
        var theme = snapshot<ThemeModel>().controller.selectedTheme();
        return CustomTheme(
          theme: theme,
          child: MaterialApp(
            title: 'Listify - Momentum Demo',
            theme: ThemeData(
              primarySwatch: theme.primary,
              accentColor: theme.accent,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            home: MomentumRouter.getActivePage(context),
          ),
        );
      },
    );
  }
}
