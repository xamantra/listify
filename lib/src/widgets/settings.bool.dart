import 'package:flutter/material.dart';

import 'index.dart';

class BoolSetting extends StatelessWidget {
  final String title;
  final String description;
  final bool isChecked;
  final void Function(bool) onChanged;

  const BoolSetting({
    Key key,
    this.title,
    this.description,
    this.isChecked,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return InkWell(
      onTap: () {
        if (onChanged != null) {
          onChanged(!isChecked);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.listTileFontColor.primary,
                    ),
                  ),
                  subtitle: Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.listTileFontColor.secondary,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              Checkbox(
                value: isChecked ?? false,
                onChanged: onChanged ?? (_) {},
              ),
            ],
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
