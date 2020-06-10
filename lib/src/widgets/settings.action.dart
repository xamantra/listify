import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../models/index.dart';
import 'index.dart';

class ActionSetting extends StatelessWidget {
  final String title;
  final String description;
  final void Function() action;
  final ListifyTheme theme;

  const ActionSetting({
    Key key,
    this.title,
    this.description,
    this.action,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, screenHeight, screenWidth, sy, sx) {
        return InkWell(
          onTap: action ?? () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: BetterText(
                        title,
                        style: TextStyle(
                          fontSize: sy(11),
                          color: theme.listTileFontColor.primary,
                        ),
                      ),
                      subtitle: BetterText(
                        description,
                        style: TextStyle(
                          fontSize: sy(10),
                          color: theme.listTileFontColor.secondary,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 1, thickness: 1),
            ],
          ),
        );
      },
    );
  }
}
