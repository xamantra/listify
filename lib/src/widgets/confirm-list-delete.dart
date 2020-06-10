import 'package:flutter/material.dart';
import 'package:listify/src/components/current-list/index.dart';
import 'package:listify/src/components/list/index.dart';
import 'package:listify/src/components/theme/index.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class ConfirmListDelete extends StatelessWidget {
  final String message;

  const ConfirmListDelete({
    Key key,
    @required this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var list = Momentum.controller<ListController>(context).model;
    var currentList = Momentum.controller<CurrentListController>(context).model;
    var theme = Momentum.controller<ThemeController>(context).selectedTheme();
    return ConfirmDialog(
      title: 'Delete List',
      message: message,
      theme: theme,
      yes: () {
        list.controller.deleteList(currentList.data.listName);
        Router.pop(context);
      },
    );
  }
}
