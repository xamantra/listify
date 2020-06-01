import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:listify/src/widgets/sub-widgets/back-icon-button.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/input/index.dart';
import '../../components/list/index.dart';
import '../../components/settings/index.dart';
import '../sub-widgets/better-text.dart';
import '../sub-widgets/new-item.dart';
import '../sub-widgets/text_input.dart';

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
    _inputController ??= Momentum.of<InputController>(context);
    _listController ??= Momentum.of<ListController>(context);
    _settingsController ??= Momentum.of<SettingsController>(context);
    _textEditingController.text = _inputController.model.listName;
    _inputController.addListener(
      state: this,
      invoke: (model, isTimeTravel) {
        if (isTimeTravel) {
          _textEditingController.text = model.itemName;
          // for this selection code, refer to this link: https://stackoverflow.com/a/58307018
          _textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textEditingController.text.length),
          );
        }
        var clear = _settingsController.model.clearOnAdd;
        switch (model.action) {
          case InputAction.ErrorOccured:
            showError(model.actionMessage);
            break;
          case InputAction.ListDataAdded:
            if (clear) _textEditingController.clear();
            Router.pop(context);
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
          leading: BackIconButton(),
          title: BetterText(
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
              TextInput(
                controller: _textEditingController,
                hintText: 'List Name',
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
                            items.add(
                              Card(
                                key: Key('$i'),
                                margin: EdgeInsets.only(top: sy(8)),
                                child: InkWell(
                                  onTap: () {
                                    _inputController.toggleItemState(i);
                                  },
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: input.items[i].listState,
                                      tristate: true,
                                      onChanged: (state) {
                                        _inputController.toggleItemState(i);
                                      },
                                    ),
                                    title: BetterText(
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
                  child: BetterText(
                    'Save List',
                    style: TextStyle(fontSize: sy(11)),
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
