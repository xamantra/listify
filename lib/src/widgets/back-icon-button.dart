import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

class BackIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 20),
      onPressed: () {
        MomentumRouter.pop(context);
      },
      tooltip: 'Back',
    );
  }
}
