import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../components/input/index.dart';
import '../components/list/index.dart';
import '../components/settings/index.dart';
import '../widgets/index.dart';
import 'index.dart';

class AddNewList extends StatefulWidget {
  @override
  _AddNewListState createState() => _AddNewListState();
}

class _AddNewListState extends MomentumState<AddNewList> with RelativeScale {
  InputController _inputController;
  ListController _listController;
  SettingsController _settingsController;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initMomentumState() {
    initRelativeScaler(context);
    _inputController ??= Momentum.controller<InputController>(context);
    _listController ??= Momentum.controller<ListController>(context);
    _settingsController ??= Momentum.controller<SettingsController>(context);
    _textEditingController.text = _inputController.model.listName;
    _inputController.addListener(
      state: this,
      invoke: (model, isTimeTravel) {
        if (isTimeTravel) {
          _textEditingController.text = model.listName;
          // for this selection code, refer to this link: https://stackoverflow.com/a/58307018
          _textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textEditingController.text.length),
          );
        }
        if (model.listName.isEmpty) _textEditingController.clear();
      },
    );
    _inputController.listen<InputEvent>(
      state: this,
      invoke: (data) {
        switch (data.action) {
          case InputAction.ErrorOccured:
            showError(data.message);
            break;
          case InputAction.ListDataAdded:
            MomentumRouter.pop(context);
            break;
          case InputAction.ListDataEdited:
            MomentumRouter.resetWithContext<Home>(context);
            MomentumRouter.goto(context, ViewList);
            break;
          default:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return RouterPage(
      onWillPop: () async {
        MomentumRouter.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackIconButton(),
          title: MomentumBuilder(
            controllers: [InputController],
            dontRebuildIf: (controller, __) {
              var editingListPrev = controller<InputController>().prevModel?.editingList;
              var editingList = controller<InputController>().model.editingList;
              return editingListPrev != editingList;
            },
            builder: (context, snapshot) {
              var input = snapshot<InputModel>();
              return BetterText(
                input.editingList ? 'Edit Existing List' : 'Add New List',
                style: TextStyle(
                  fontSize: sy(13),
                  color: theme.appbarFont,
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.undo,
                size: sy(18),
                color: theme.appbarFont,
              ),
              onPressed: () {
                _inputController.backward();
              },
              tooltip: 'Undo',
            ),
            IconButton(
              icon: Icon(
                Icons.redo,
                size: sy(18),
                color: theme.appbarFont,
              ),
              onPressed: () {
                _inputController.forward();
              },
              tooltip: 'Redo',
            ),
            IconButton(
              icon: Icon(
                Icons.cancel,
                size: sy(18),
                color: theme.appbarFont,
              ),
              onPressed: () {
                _inputController.reset(clearHistory: true);
              },
              tooltip: 'Clear',
            ),
          ],
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          color: theme.bodyBackground,
          padding: EdgeInsets.all(sy(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextInput(
                controller: _textEditingController,
                hintText: 'List Name',
                color: theme.textPrimary,
                onChanged: (value) {
                  _inputController.setListName(value);
                },
              ),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: MomentumBuilder(
                        controllers: [InputController],
                        builder: (context, snapshot) {
                          var input = snapshot<InputModel>();
                          var items = <Widget>[];
                          for (var i = 0; i < input.items.length; i++) {
                            IconData icon;
                            Color color;
                            var checkState = input.items[i].listState;
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
                                margin: EdgeInsets.only(top: sy(8)),
                                child: InkWell(
                                  onTap: () {
                                    _inputController.toggleItemState(i);
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(sy(4)).copyWith(left: sy(8)),
                                    leading: Icon(
                                      icon,
                                      color: color,
                                    ),
                                    title: BetterText(
                                      input.items[i].name,
                                      style: TextStyle(
                                        fontSize: sy(11),
                                        color: theme.listTileFontColor.primary,
                                      ),
                                      maxLines: 2,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            size: sy(18),
                                            color: theme.listTileIconColor.danger,
                                          ),
                                          onPressed: () {
                                            _inputController.removeItem(i);
                                          },
                                          tooltip: 'Remove Item',
                                        ),
                                      ],
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
                                _inputController.reorder(oldIndex, newIndex);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    AddNewItem(),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                child: RaisedButton(
                  onPressed: () {
                    _inputController.submit();
                  },
                  color: theme.buttonPrimary.background,
                  child: BetterText(
                    'Save',
                    style: TextStyle(
                      fontSize: sy(11),
                      color: Colors.white,
                    ),
                  ),
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
