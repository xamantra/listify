import 'package:flutter/material.dart';
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

  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    _inputController ??= Momentum.of<InputController>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      child: MomentumBuilder(
        controllers: [InputController],
        dontRebuildIf: (_, isTimeTravel) {
          var listItemAdded = _<InputController>().model.action == InputAction.ListItemAdded;
          if (listItemAdded) return false;
          return !isTimeTravel;
        },
        builder: (context, snapshot) {
          var input = snapshot<InputModel>();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextInput(
                  value: input.itemName,
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
          );
        },
      ),
    );
  }
}
