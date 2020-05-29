import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import 'src/components/input/index.dart';
import 'src/components/list/index.dart';
import 'src/services/client_db.dart';
import 'src/widgets/add-list.dart';
import 'src/widgets/home.dart';

void main() {
  runApp(
    Momentum(
      child: MyApp(),
      controllers: [
        ListController()..config(maxTimeTravelSteps: 3),
        InputController()..config(maxTimeTravelSteps: 200),
      ],
      services: [
        ClientDB(),
        Router([
          Home(),
          AddNewList(),
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
    return MaterialApp(
      title: 'Listify - Momentum Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Router.getActivePage(context), // persistent routing/navigation
    );
  }
}
