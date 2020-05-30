import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../components/input/index.dart';
import 'text_input.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends MomentumState<AddNewItem> with RelativeScale {
  InputController _inputController;
  final TextEditingController controller = TextEditingController(text: '');

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
      padding: EdgeInsets.only(right: sy(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextInput(
              controller: controller,
              hintText: 'Item Name',
            ),
          ),
          Container(
            width: sy(64),
            child: RaisedButton(
              onPressed: () {
                _inputController.addItem(controller.text);
              },
              child: AutoSizeText(
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
