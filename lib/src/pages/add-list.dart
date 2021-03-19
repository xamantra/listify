import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momentum/momentum.dart';

import '../components/input/index.dart';
import '../components/list/index.dart';
import '../components/settings/index.dart';
import '../utils/index.dart';
import '../widgets/index.dart';
import 'index.dart';

class AddNewList extends StatefulWidget {
  @override
  _AddNewListState createState() => _AddNewListState();
}

class _AddNewListState extends MomentumState<AddNewList> {
  InputController? _inputController;
  ListController? _listController;
  SettingsController? _settingsController;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initMomentumState() {
    _inputController ??= Momentum.controller<InputController>(context);
    _listController ??= Momentum.controller<ListController>(context);
    _settingsController ??= Momentum.controller<SettingsController>(context);
    _textEditingController.text = _inputController!.model.listName!;
    _inputController!.clearStateHistory(); // reset the undo/redo state every time this page is opened.
    _inputController!.addListener(
      state: this,
      invoke: (model, isTimeTravel) {
        if (isTimeTravel) {
          _textEditingController.text = model.listName!;
          // for this selection code, refer to this link: https://stackoverflow.com/a/58307018
          _textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textEditingController.text.length),
          );
        }
        if (model.listName!.isEmpty) _textEditingController.clear();
      },
    );
    _inputController!.listen<InputEvent>(
      state: this,
      invoke: (data) {
        switch (data.action) {
          case InputAction.ErrorOccured:
            showErrorMessage(data.message!);
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
    var screen = screenSize(context);
    return RouterPage(
      onWillPop: () async {
        MomentumRouter.pop(context);
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
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
                return Text(
                  input.editingList! ? 'Edit Existing List' : 'Add New List',
                  style: TextStyle(
                    color: theme.appbarFont,
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.undo,
                  color: theme.appbarFont,
                ),
                onPressed: () {
                  _inputController!.backward();
                },
                tooltip: 'Undo',
              ),
              IconButton(
                icon: Icon(
                  Icons.redo,
                  color: theme.appbarFont,
                ),
                onPressed: () {
                  _inputController!.forward();
                },
                tooltip: 'Redo',
              ),
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: theme.appbarFont,
                ),
                onPressed: () {
                  _inputController!.reset(clearHistory: true);
                },
                tooltip: 'Clear',
              ),
            ],
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: theme.bodyBackground,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextInput(
                  controller: _textEditingController,
                  hintText: 'List Name',
                  color: theme.textPrimary,
                  onChanged: (value) {
                    _inputController!.setListName(value);
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
                            for (var i = 0; i < input.items!.length; i++) {
                              IconData? icon;
                              Color? color;
                              var checkState = input.items![i].listState;
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
                                      _inputController!.toggleItemState(i);
                                    },
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(4).copyWith(left: 8),
                                      leading: Icon(
                                        icon,
                                        color: color,
                                      ),
                                      title: Text(
                                        input.items![i].name!,
                                        style: TextStyle(
                                          fontSize: 14,
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
                                              size: 20,
                                              color: theme.listTileIconColor.danger,
                                            ),
                                            onPressed: () {
                                              _inputController!.removeItem(i);
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
                              constraints: BoxConstraints(maxHeight: screen.height),
                              child: ReorderableListView(
                                children: items,
                                onReorder: (oldIndex, newIndex) {
                                  print([oldIndex, newIndex]);
                                  _inputController!.reorder(oldIndex, newIndex);
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
                  width: screen.width,
                  child: RaisedButton(
                    onPressed: () {
                      _inputController!.submit();
                    },
                    color: theme.buttonPrimary.background,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
