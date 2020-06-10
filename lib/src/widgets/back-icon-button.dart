import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

class BackIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (_, __, ___, sy, sx) {
        return IconButton(
          icon: Icon(Icons.arrow_back, size: sy(18)),
          onPressed: () {
            Router.pop(context);
          },
          tooltip: 'Back',
        );
      },
    );
  }
}
