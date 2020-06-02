import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'better-text.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final void Function() no;
  final void Function() yes;

  const ConfirmDialog({
    Key key,
    this.title,
    @required this.message,
    this.no,
    this.yes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return Material(
            color: Colors.transparent,
            child: Container(
              width: width,
              padding: EdgeInsets.all(sy(12)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BetterText(
                    title ?? '',
                    style: TextStyle(
                      fontSize: sy(14),
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.80),
                    ),
                  ),
                  SizedBox(height: sy(8)),
                  BetterText(
                    message ?? '',
                    style: TextStyle(
                      fontSize: sy(12),
                      color: Colors.black.withOpacity(0.85),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 4,
                  ),
                  SizedBox(height: sy(8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FlatButton(
                        onPressed: no ?? () => Navigator.pop(context),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: BetterText(
                          'NO',
                          style: TextStyle(
                            fontSize: sy(12),
                            color: Colors.black.withOpacity(0.65),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: yes ?? () => Navigator.pop(context),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: BetterText(
                          'YES',
                          style: TextStyle(
                            fontSize: sy(12),
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
