import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import '../components/input/index.dart';
import '../components/settings/index.dart';
import '../utils/index.dart';
import 'index.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends MomentumState<AddNewItem> {
  InputController? _inputController;
  SettingsController? _settingsController;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    _inputController ??= Momentum.controller<InputController>(context);
    _settingsController ??= Momentum.controller<SettingsController>(context);
    _textEditingController.text = _inputController!.model.itemName!;

    _inputController!.addListener(
      state: this,
      invoke: (model, isTimeTravel) {
        if (isTimeTravel) {
          _textEditingController.text = model.itemName!;
          // for this selection code, refer to this link: https://stackoverflow.com/a/58307018
          _textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textEditingController.text.length),
          );
        }
      },
    );
    _inputController!.listen<InputEvent>(
      state: this,
      invoke: (data) {
        var clear = _settingsController!.model.clearOnAdd;
        switch (data.action) {
          case InputAction.ListDataAdded:
            if (clear!) _textEditingController.clear();
            break;
          case InputAction.ListItemAdded:
            if (clear!) _textEditingController.clear();
            break;
          default:
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    var screen = screenSize(context);
    return Container(
      width: screen.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CustomTextInput(
              controller: _textEditingController,
              hintText: 'Item Name',
              color: theme.textPrimary,
              onChanged: (value) {
                _inputController!.setItemName(value);
              },
            ),
          ),
          Container(
            width: 64,
            child: RaisedButton(
              onPressed: () {
                _inputController!.addItem();
              },
              color: theme.buttonSecondary.background,
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
