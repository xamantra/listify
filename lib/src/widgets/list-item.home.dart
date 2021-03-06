import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import '../components/list/index.dart';
import '../models/index.dart';
import '../pages/index.dart';
import 'index.dart';

class ViewListParam extends RouterParam {
  final int? index;

  ViewListParam(this.index);
}

class CopyListParam extends RouterParam {
  final int? index;

  CopyListParam(this.index);
}

class ListItemHome extends StatelessWidget {
  final int? index;
  final ListData? listData;

  const ListItemHome({
    Key? key,
    this.index,
    this.listData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    var _listController = Momentum.controller<ListController>(context);
    IconData? icon;
    Color? color;
    var checkState = _listController.getCheckState(index!);
    if (checkState == true) {
      icon = Icons.check_circle;
      color = theme.listTileIconColor.primary;
    }
    if (checkState == false) {
      icon = Icons.crop_square;
      color = theme.listTileIconColor.normal;
    }
    if (checkState == null) {
      icon = Icons.remove_circle;
      color = theme.primary;
    }
    return Card(
      margin: EdgeInsets.only(top: 8),
      color: theme.listTileCardBackground,
      child: InkWell(
        onTap: () {
          // _currentListController.reset(clearHistory: true);
          // _listController.view(index);
          MomentumRouter.goto(context, ViewList, params: ViewListParam(index));
        },
        child: ListTile(
          contentPadding: EdgeInsets.all(4).copyWith(left: 8),
          leading: Icon(
            icon,
            color: color,
          ),
          title: Text(
            listData!.listName!,
            style: TextStyle(
              fontSize: 16,
              color: theme.listTileFontColor.primary,
            ),
            maxLines: 2,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.content_copy,
                  color: theme.listTileIconColor.normal,
                ),
                onPressed: () {
                  // _inputController.reset(clearHistory: true);
                  // _listController.createCopy(index);
                  MomentumRouter.goto(context, AddNewList, params: CopyListParam(index));
                },
                tooltip: 'Create Copy',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
