import 'package:momentum/momentum.dart';

import '../input/index.dart';
import 'index.dart';

class SettingsController extends MomentumController<SettingsModel> {
  @override
  SettingsModel init() {
    return SettingsModel(
      this,
      draftInputs: false,
      clearOnAdd: false,
    );
  }

  void setDraftInputs(bool value) {
    model.update(draftInputs: value ?? false);
    executeDraftSetting();
  }

  void setClearOnAdd(bool value) {
    model.update(clearOnAdd: value ?? false);
    executeClearOnAddSetting();
  }

  void executeDraftSetting() {
    if (!model.draftInputs) {
      dependOn<InputController>().reset();
    }
  }

  void executeClearOnAddSetting() {
    if (model.clearOnAdd) {
      dependOn<InputController>().setItemName('');
    }
  }
}
