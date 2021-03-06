import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momentum/momentum.dart';

import '../../main.dart';
import '../components/input/index.dart';
import '../components/list/index.dart';
import '../components/settings/index.dart';
import '../utils/index.dart';
import '../widgets/index.dart';
import 'index.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends MomentumState<Settings> {
  @override
  void initMomentumState() {
    super.initMomentumState();
    Momentum.controller<SettingsController>(context).listen<String>(
      state: this,
      invoke: (data) {
        showErrorMessage(data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screen = screenSize(context);
    return RouterPage(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            leading: BackIconButton(),
            title: Text('Settings'),
          ),
          body: Container(
            height: screen.height,
            width: screen.width,
            padding: EdgeInsets.symmetric(vertical: 8),
            color: CustomTheme.of(context).bodyBackground,
            child: MomentumBuilder(
              controllers: [SettingsController],
              builder: (context, snapshot) {
                var setting = snapshot<SettingsModel>();
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      BoolSetting(
                        title: 'Draft inputs',
                        description: 'When pressing "+" button inside home page, the previous inputs will be shown on Add List Page including edit session.',
                        isChecked: setting.draftInputs,
                        onChanged: (state) {
                          setting.controller.setDraftInputs(state!);
                        },
                      ),
                      BoolSetting(
                        title: 'Clear on Add',
                        description: 'After adding new item on the list, the item name textbox will be cleared.',
                        isChecked: setting.clearOnAdd,
                        onChanged: (state) {
                          setting.controller.setClearOnAdd(state!);
                        },
                      ),
                      BoolSetting(
                        title: 'Copy List Name',
                        description: 'When copying a list data, the list\'s name will also be copied.',
                        isChecked: setting.copyListName,
                        onChanged: (state) {
                          setting.controller.setCopyListName(state!);
                        },
                      ),
                      BoolSetting(
                        title: 'Copy List States',
                        description: 'When copying a list data, the checkbox states will also be copied.',
                        isChecked: setting.copyListStates,
                        onChanged: (state) {
                          setting.controller.setCopyListStates(state!);
                        },
                      ),
                      ActionSetting(
                        title: 'Clear Draft',
                        description: 'Clear draft inputs inside "Add New List" page.',
                        action: () {
                          setting.controller.clearDraft();
                        },
                      ),
                      ActionSetting(
                        title: 'Select Theme',
                        description: 'An app without a theme switcher isn\'t an app at all.',
                        action: () {
                          showDialog(
                            context: context,
                            builder: (context) => ThemeSelector(),
                          );
                        },
                      ),
                      ActionSetting(
                        title: 'Restart App',
                        description: 'Clear input draft, reset navigation history and go to home page.',
                        action: () async {
                          await MomentumRouter.resetWithContext<Home>(context);
                          Momentum.controller<InputController>(context).reset(clearHistory: true);
                          Momentum.controller<ListController>(context).clearSearch();
                          Momentum.restart(context, momentum());
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
