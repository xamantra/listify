import 'package:flutter/material.dart';
import 'package:listify/src/components/settings/index.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/input/index.dart';
import 'better-text.dart';
import 'text_input.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends MomentumState<AddNewItem> with RelativeScale {
  InputController _inputController;
  SettingsController _settingsController;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    _inputController ??= Momentum.controller<InputController>(context);
    _settingsController ??= Momentum.controller<SettingsController>(context);
    _textEditingController.text = _inputController.model.itemName;
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
          case InputAction.ListDataAdded:
            if (clear) _textEditingController.clear();
            break;
          case InputAction.ListItemAdded:
            if (clear) _textEditingController.clear();
            break;
          default:
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextInput(
              controller: _textEditingController,
              hintText: 'Item Name',
              onChanged: (value) {
                _inputController.setItemName(value);
              },
            ),
          ),
          Container(
            width: sy(64),
            child: RaisedButton(
              onPressed: () {
                _inputController.addItem();
              },
              child: BetterText(
                'Add',
                style: TextStyle(fontSize: sy(11)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
