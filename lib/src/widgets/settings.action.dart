import 'package:flutter/material.dart';

import 'index.dart';

class ActionSetting extends StatelessWidget {
  final String? title;
  final String? description;
  final void Function()? action;

  const ActionSetting({
    Key? key,
    this.title,
    this.description,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
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
                  title: Text(
                    title!,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.listTileFontColor.primary,
                    ),
                  ),
                  subtitle: Text(
                    description!,
                    style: TextStyle(
                      fontSize: 13,
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
  }
}
