import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../components/input/index.dart';
import 'text_input.dart';

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> with RelativeScale {
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
    return Dialog(
      child: Container(
        height: sy(120),
        width: screenWidth,
        padding: EdgeInsets.symmetric(horizontal: sy(18)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextInput(
              controller: controller,
              hintText: 'Item Name',
            ),
            Container(
              height: sy(46),
              width: screenWidth,
              padding: EdgeInsets.only(top: sy(8)),
              child: RaisedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    _inputController.addItem(controller.text);
                    Navigator.pop(context);
                  }
                },
                child: AutoSizeText(
                  'Save',
                  style: TextStyle(fontSize: sy(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
