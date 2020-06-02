import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:listify/src/widgets/sub-widgets/back-icon-button.dart';
import 'package:listify/src/widgets/sub-widgets/settings.action.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/settings/index.dart';
import '../sub-widgets/better-text.dart';
import '../sub-widgets/settings.bool.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends MomentumState<Settings> {
  @override
  void initMomentumState() {
    super.initMomentumState();
    Momentum.controller<SettingsController>(context).addListener(
      state: this,
      invoke: (model, _) {
        switch (model.action) {
          case SettingsAction.DraftCleared:
            showMessage(model.actionMessage);
            break;
          default:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RouterPage(
      child: RelativeBuilder(
        builder: (context, screenHeight, screenWidth, sy, sx) {
          return Scaffold(
            appBar: AppBar(
              leading: BackIconButton(),
              title: BetterText(
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
                      BoolSetting(
                        title: 'Clear on Add',
                        description: 'After adding new item on the list, the item name textbox will be cleared.',
                        isChecked: setting.clearOnAdd,
                        onChanged: (state) {
                          setting.controller.setClearOnAdd(state);
                        },
                      ),
                      BoolSetting(
                        title: 'Copy List Name',
                        description: 'When copying a list data, the list\'s name will also be copied.',
                        isChecked: setting.copyListName,
                        onChanged: (state) {
                          setting.controller.setCopyListName(state);
                        },
                      ),
                      BoolSetting(
                        title: 'Copy List States',
                        description: 'When copying a list data, the checkbox states will also be copied.',
                        isChecked: setting.copyListStates,
                        onChanged: (state) {
                          setting.controller.setCopyListStates(state);
                        },
                      ),
                      ActionSetting(
                        title: 'Clear Draft',
                        description: 'Clear draft inputs inside "Add New List" page.',
                        action: () {
                          setting.controller.clearDraft();
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

  void showMessage(String message) {
    Flushbar(
      messageText: RelativeBuilder(
        builder: (context, screenHeight, screenWidth, sy, sx) {
          return BetterText(
            message,
            style: TextStyle(
              fontSize: sy(11),
              color: Colors.white,
            ),
            maxLines: 2,
          );
        },
      ),
      isDismissible: true,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
      onTap: (flushbar) {
        flushbar.dismiss();
      },
    )..show(context);
  }
}
