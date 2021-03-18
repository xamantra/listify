import 'package:momentum/momentum.dart';

import '../input/index.dart';
import 'index.dart';

class SettingsController extends MomentumController<SettingsModel> {
  @override
  SettingsModel init() {
    return SettingsModel(
      this,
      draftInputs: true,
      clearOnAdd: true,
      copyListName: false,
      copyListStates: false,
    );
  }

  void setDraftInputs(bool value) {
    model.update(draftInputs: value);
    executeDraftSetting();
  }

  void setClearOnAdd(bool value) {
    model.update(clearOnAdd: value);
    executeClearOnAddSetting();
  }

  void setCopyListName(bool value) {
    model.update(copyListName: value);
  }

  void setCopyListStates(bool value) {
    model.update(copyListStates: value);
  }

  void executeDraftSetting() {
    if (!model.draftInputs!) {
      controller<InputController>().reset(clearHistory: true);
    }
  }

  void executeClearOnAddSetting() {
    if (model.clearOnAdd!) {
      controller<InputController>().setItemName('');
    }
  }

  void clearDraft() {
    controller<InputController>().reset(clearHistory: true);
    sendEvent('Draft inputs cleared.');
  }
}
