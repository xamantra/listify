import 'package:flutter/material.dart';
import 'package:listify/src/components/theme/index.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';


class ThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: RelativeBuilder(
          builder: (context, height, width, sy, sx) {
            return MomentumBuilder(
              controllers: [ThemeController],
              builder: (context, snapshot) {
                var themeModel = snapshot<ThemeModel>();
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
                                height: height,
                                width: sy(32),
                                color: theme.primary,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height,
                                width: sy(32),
                                color: theme.accent,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height,
                                width: sy(32),
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
                  width: width,
                  height: sy(300),
                  padding: EdgeInsets.all(sy(8)),
                  child: Column(
                    children: themeItems,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
