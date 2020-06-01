import 'package:flutter/material.dart';
import 'package:listify/src/components/current-list/current-list.controller.dart';
import 'package:listify/src/widgets/pages/view-list.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/list/index.dart';
import '../../data/list-data.dart';
import '../pages/add-list.dart';
import 'better-text.dart';

class ListItemHome extends StatelessWidget {
  final int i;
  final ListData listData;

  const ListItemHome({
    Key key,
    this.i,
    this.listData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _listController = Momentum.controller<ListController>(context);
    var _currentListController = Momentum.controller<CurrentListController>(context);
    return RelativeBuilder(
      builder: (context, screenHeight, screenWidth, sy, sx) {
        IconData icon;
        Color color;
        var checkState = _listController.getCheckState(i);
        if (checkState == true) {
          icon = Icons.check_circle;
          color = Colors.green;
        }
        if (checkState == false) {
          icon = Icons.crop_square;
          color = Colors.black.withOpacity(0.4);
        }
        if (checkState == null) {
          icon = Icons.remove_circle;
          color = Colors.blue;
        }
        return Card(
          margin: EdgeInsets.only(top: sy(8)),
          child: InkWell(
            onTap: () {
              _currentListController.reset(clearHistory: true);
              _listController.view(i);
              Router.goto(context, ViewList);
            },
            child: ListTile(
              leading: Icon(
                icon,
                color: color,
                size: sy(16),
              ),
              title: BetterText(
                listData.listName,
                style: TextStyle(fontSize: sy(11)),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.content_copy,
                      size: sy(18),
                    ),
                    onPressed: () {
                      _listController.createCopy(i);
                      Router.goto(context, AddNewList);
                    },
                    tooltip: 'Create Copy',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
