import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import '../components/current-list/index.dart';
import '../components/list/index.dart';
import 'index.dart';

class ConfirmListDelete extends StatelessWidget {
  final String? message;

  const ConfirmListDelete({
    Key? key,
    required this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ListModel list = Momentum.controller<ListController>(context).model;
    CurrentListModel currentList = Momentum.controller<CurrentListController>(context).model;
    return ConfirmDialog(
      title: 'Delete List',
      message: message,
      yes: () {
        list.controller.deleteList(currentList.data!.listName);
        MomentumRouter.pop(context);
      },
    );
  }
}
