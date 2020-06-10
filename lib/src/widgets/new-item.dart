import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../components/input/index.dart';
import '../components/settings/index.dart';
import '../components/theme/index.dart';
import '../models/index.dart';
import 'index.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends MomentumState<AddNewItem> with RelativeScale {
  InputController _inputController;
  SettingsController _settingsController;
  TextEditingController _textEditingController = TextEditingController();
  ListifyTheme theme;

  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    _inputController ??= Momentum.controller<InputController>(context);
    _settingsController ??= Momentum.controller<SettingsController>(context);
    _textEditingController.text = _inputController.model.itemName;
    theme = Momentum.controller<ThemeController>(context).selectedTheme();

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
      },
    );
    _inputController.listen<InputEvent>(
      state: this,
      invoke: (data) {
        var clear = _settingsController.model.clearOnAdd;
        switch (data.action) {
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
              color: theme.textPrimary,
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
              color: theme.buttonSecondary.background,
              child: BetterText(
                'Add',
                style: TextStyle(
                  fontSize: sy(11),
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
