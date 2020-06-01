import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:listify/src/components/current-list/index.dart';
import 'package:listify/src/components/list/index.dart';
import 'package:listify/src/widgets/sub-widgets/back-icon-button.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../sub-widgets/better-text.dart';

class ViewList extends StatefulWidget {
  @override
  _ViewListState createState() => _ViewListState();
}

class _ViewListState extends MomentumState<ViewList> with RelativeScale {
  CurrentListController currentListController;
  ListController listController;

  @override
  void initMomentumState() {
    initRelativeScaler(context);
    currentListController ??= Momentum.controller<CurrentListController>(context);
    listController ??= Momentum.controller<ListController>(context);
  }

  @override
  Widget build(BuildContext context) {
    return RouterPage(
      onWillPop: () async {
        Router.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackIconButton(),
          title: BetterText(
            currentListController.model.data.listName,
            style: TextStyle(fontSize: sy(13)),
          ),
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.all(sy(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: MomentumBuilder(
                        controllers: [CurrentListController],
                        builder: (context, snapshot) {
                          var list = snapshot<CurrentListModel>();
                          var items = <Widget>[];
                          for (var i = 0; i < list.data.items.length; i++) {
                            items.add(
                              Card(
                                key: Key('$i'),
                                margin: EdgeInsets.only(top: sy(8)),
                                child: InkWell(
                                  onTap: () {
                                    currentListController.toggleItemState(i);
                                  },
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: list.data.items[i].listState,
                                      tristate: true,
                                      onChanged: (state) {
                                        currentListController.toggleItemState(i);
                                      },
                                    ),
                                    title: BetterText(
                                      list.data.items[i].name,
                                      style: TextStyle(fontSize: sy(11)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container(
                            constraints: BoxConstraints(maxHeight: screenHeight),
                            child: ReorderableListView(
                              children: items,
                              onReorder: (oldIndex, newIndex) {
                                print([oldIndex, newIndex]);
                                currentListController.reorderListItems(oldIndex, newIndex);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showError(String message) {
    Flushbar(
      messageText: BetterText(
        message,
        style: TextStyle(
          fontSize: sy(11),
          color: Colors.white,
        ),
        maxLines: 2,
      ),
      isDismissible: true,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 5),
      onTap: (flushbar) {
        flushbar.dismiss();
      },
    )..show(context);
  }
}
