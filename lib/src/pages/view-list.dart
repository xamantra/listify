import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import '../components/current-list/index.dart';
import '../components/list/index.dart';
import '../utils/index.dart';
import '../widgets/index.dart';
import 'index.dart';

class EditListParam extends RouterParam {
  final String listName;

  EditListParam(this.listName);
}

class ViewList extends StatefulWidget {
  @override
  _ViewListState createState() => _ViewListState();
}

class _ViewListState extends MomentumState<ViewList> {
  CurrentListController currentListController;
  ListController listController;

  @override
  void initMomentumState() {
    currentListController ??= Momentum.controller<CurrentListController>(context);
    listController ??= Momentum.controller<ListController>(context);
    listController.listen<ListEvent>(
      state: this,
      invoke: (data) {
        switch (data.action) {
          case ListAction.ListConfirmDelete:
            showDialog(context: context, builder: (context) => ConfirmListDelete(message: data.message));
            break;
          case ListAction.ListDataDeleted:
            MomentumRouter.pop(context);
            break;
          default:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    var screen = screenSize(context);
    var listName = currentListController.model.data.listName;
    return RouterPage(
      onWillPop: () async {
        MomentumRouter.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackIconButton(),
          title: Text(
            listName,
            style: TextStyle(
              fontSize: 14,
              color: theme.appbarFont,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                size: 20,
                color: theme.appbarFont,
              ),
              onPressed: () {
                // listController.editList(listName);
                MomentumRouter.goto(context, AddNewList, params: EditListParam(listName));
              },
              tooltip: 'Edit List',
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                size: 20,
                color: theme.appbarFont,
              ),
              onPressed: () {
                listController.confirmDelete(listName);
              },
              tooltip: 'Delete List',
            ),
          ],
        ),
        body: Container(
          height: screen.height,
          width: screen.width,
          padding: EdgeInsets.all(13),
          color: theme.bodyBackground,
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
                            IconData icon;
                            Color color;
                            var checkState = list.data.items[i].listState;
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

                            items.add(
                              Card(
                                key: Key('$i'),
                                color: theme.listTileCardBackground,
                                margin: EdgeInsets.only(top: 8),
                                child: InkWell(
                                  onTap: () {
                                    currentListController.toggleItemState(i);
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(4).copyWith(left: 8),
                                    leading: Icon(
                                      icon,
                                      color: color,
                                    ),
                                    title: Text(
                                      list.data.items[i].name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: theme.listTileFontColor.primary,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container(
                            constraints: BoxConstraints(maxHeight: screen.height),
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
}
