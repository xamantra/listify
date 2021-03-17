import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import '../components/theme/index.dart';
import '../utils/index.dart';

class ThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: Builder(
          builder: (context) {
            var screen = screenSize(context);
            var themeModel = Momentum.controller<ThemeController>(context).model;
            var themes = themeModel.controller.themes;
            var themeItems = <Widget>[];
            for (var i = 0; i < themes.length; i++) {
              var theme = themes[i];
              themeItems.addAll([
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      themeModel.controller.selectTheme(i);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: screen.height,
                            width: 32,
                            color: theme.primary,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: screen.height,
                            width: 32,
                            color: theme.accent,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: screen.height,
                            width: 32,
                            color: theme.bodyBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
              ]);
            }
            return Container(
              width: screen.width,
              height: 300,
              padding: EdgeInsets.all(8),
              child: Column(
                children: themeItems,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
            );
          },
        ),
      ),
    );
  }
}
