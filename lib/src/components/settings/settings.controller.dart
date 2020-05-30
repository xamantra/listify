import 'package:momentum/momentum.dart';

import '../input/index.dart';
import 'index.dart';

class SettingsController extends MomentumController<SettingsModel> {
  @override
  SettingsModel init() {
    return SettingsModel(
      this,
      draftInputs: false,
    );
  }

  void setDraftInputs(bool value) {
    model.update(draftInputs: value ?? false);
    executeDraftSetting();
  }

  void executeDraftSetting() {
    if (!model.draftInputs) {
      dependOn<InputController>().reset();
    }
  }
}
