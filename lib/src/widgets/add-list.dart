import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:listify/src/components/settings/index.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../components/input/index.dart';
import '../components/list/index.dart';
import 'home.dart';
import 'new-item.dart';
import 'text_input.dart';

class AddNewList extends StatefulWidget {
  @override
  _AddNewListState createState() => _AddNewListState();
}

class _AddNewListState extends MomentumState<AddNewList> with RelativeScale {
  InputController _inputController;
  ListController _listController;
  SettingsController _settingsController;

  @override
  void initMomentumState() {
    initRelativeScaler(context);
    _inputController ??= Momentum.of<InputController>(context);
    _listController ??= Momentum.of<ListController>(context);
    _settingsController ??= Momentum.of<SettingsController>(context);
    _inputController.addListener(
      state: this,
      invoke: (model, _) {
        switch (model.action) {
          case InputAction.ErrorOccured:
            showError(model.actionMessage);
            break;
          case InputAction.ListDataAdded:
            Router.goto(context, Home);
            break;
          default:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RouterPage(
      onWillPop: () async {
        _settingsController.executeDraftSetting();
        Router.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            'Add New List',
            style: TextStyle(fontSize: sy(13)),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.undo, size: sy(18)),
              onPressed: () {
                _inputController.backward();
              },
              tooltip: 'Undo',
            ),
            IconButton(
              icon: Icon(Icons.redo, size: sy(18)),
              onPressed: () {
                _inputController.forward();
              },
              tooltip: 'Redo',
            ),
          ],
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.all(sy(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MomentumBuilder(
                controllers: [InputController],
                dontRebuildIf: (controller, isTimeTravel) {
                  // only rebuild if time travel method is
                  // responsible for the model update (undo/redo)
                  return !isTimeTravel;
                },
                builder: (context, snapshot) {
                  var input = snapshot<InputModel>();
                  return TextInput(
                    value: input.listName,
                    hintText: 'List Name',
                    onChanged: (value) {
                      _inputController.setListName(value);
                    },
                  );
                },
              ),
              Flexible(
                child: MomentumBuilder(
                  controllers: [InputController],
                  builder: (context, snapshot) {
                    var input = snapshot<InputModel>();
                    var items = <Widget>[];
                    for (var i = 0; i < input.items.length; i++) {
                      items.add(
                        Card(
                          key: Key('$i'),
                          margin: EdgeInsets.only(top: sy(8)),
                          child: InkWell(
                            onTap: () {},
                            child: ListTile(
                              title: AutoSizeText(
                                input.items[i].name,
                                style: TextStyle(fontSize: sy(11)),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.close, size: sy(18), color: Colors.red),
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
              AutoSizeText(
                'NOTE: Long press and drag to reorder items.',
                style: TextStyle(fontSize: sy(11)),
              ),
              Container(
                height: sy(52),
                width: screenWidth,
                padding: EdgeInsets.only(top: sy(8)),
                child: RaisedButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) => AddNewItem());
                  },
                  child: AutoSizeText(
                    'Add Item',
                    style: TextStyle(fontSize: sy(11)),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _inputController.submit();
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.check, size: sy(18)),
          tooltip: 'Save',
        ),
      ),
    );
  }

  void showError(String message) {
    Flushbar(
      messageText: AutoSizeText(
        message,
        style: TextStyle(
          fontSize: sy(11),
          color: Colors.white,
        ),
        maxLines: 2,
        minFontSize: 1,
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
