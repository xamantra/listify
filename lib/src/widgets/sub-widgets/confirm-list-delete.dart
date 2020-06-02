import 'package:flutter/material.dart';
import 'package:listify/src/components/current-list/index.dart';
import 'package:listify/src/components/list/index.dart';
import 'package:listify/src/widgets/sub-widgets/dialog.dart';
import 'package:momentum/momentum.dart';

class ConfirmListDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = Momentum.controller<ListController>(context).model;
    var currentList = Momentum.controller<CurrentListController>(context).model;
    return ConfirmDialog(
      title: 'Delete List',
      message: list.actionMessage,
      yes: () {
        list.controller.deleteList(currentList.data.listName);
        Router.pop(context);
      },
    );
  }
}
