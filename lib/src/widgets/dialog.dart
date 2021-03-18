import 'package:flutter/material.dart';

import '../utils/index.dart';
import 'index.dart';

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final void Function()? no;
  final void Function()? yes;

  const ConfirmDialog({
    Key? key,
    this.title,
    required this.message,
    this.no,
    this.yes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    var screen = screenSize(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screen.width,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: theme.bodyBackground,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: theme.textPrimary.withOpacity(0.80),
                ),
              ),
              SizedBox(height: 8),
              Text(
                message ?? '',
                style: TextStyle(
                  fontSize: 13,
                  color: theme.textPrimary.withOpacity(0.85),
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    onPressed: no ?? () => Navigator.pop(context),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text(
                      'NO',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.textPrimary.withOpacity(0.65),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: yes ?? () => Navigator.pop(context),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text(
                      'YES',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
