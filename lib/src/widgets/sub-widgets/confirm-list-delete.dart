import 'package:flutter/material.dart';
import 'package:listify/src/components/current-list/index.dart';
import 'package:listify/src/components/list/index.dart';
import 'package:listify/src/widgets/sub-widgets/dialog.dart';
import 'package:momentum/momentum.dart';

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
    return ConfirmDialog(
      title: 'Delete List',
      message: message,
      yes: () {
        list.controller.deleteList(currentList.data.listName);
        Router.pop(context);
      },
    );
  }
}
