import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:listify/src/components/settings/index.dart';
import 'package:listify/src/widgets/settings.bool.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RouterPage(
      child: RelativeBuilder(
        builder: (context, screenHeight, screenWidth, sy, sx) {
          return Scaffold(
            appBar: AppBar(
              title: AutoSizeText(
                'Settings',
                style: TextStyle(fontSize: sy(13)),
              ),
            ),
            body: Container(
              height: screenHeight,
              width: screenWidth,
              padding: EdgeInsets.symmetric(vertical: sy(8)),
              child: MomentumBuilder(
                controllers: [SettingsController],
                builder: (context, snapshot) {
                  var setting = snapshot<SettingsModel>();
                  return Column(
                    children: [
                      BoolSetting(
                        title: 'Draft inputs',
                        description: 'When pressing back button inside add list page, save the inputs as draft.',
                        isChecked: setting.draftInputs,
                        onChanged: (state) {
                          setting.controller.setDraftInputs(state);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
