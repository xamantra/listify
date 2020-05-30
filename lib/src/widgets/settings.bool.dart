import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class BoolSetting extends StatelessWidget {
  final String title;
  final String description;
  final bool isChecked;
  final void Function(bool) onChanged;

  const BoolSetting({
    Key key,
    this.title,
    this.description,
    this.onChanged,
    this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, screenHeight, screenWidth, sy, sx) {
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
                      title: AutoSizeText(
                        title,
                        style: TextStyle(fontSize: sy(11)),
                        maxLines: 1,
                        minFontSize: 1,
                      ),
                      subtitle: AutoSizeText(
                        description,
                        style: TextStyle(fontSize: sy(10)),
                        maxLines: 2,
                        minFontSize: 1,
                      ),
                    ),
                  ),
                  Checkbox(
                    value: isChecked ?? false,
                    onChanged: onChanged ?? (_) {},
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
