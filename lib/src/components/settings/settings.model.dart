import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class SettingsModel extends MomentumModel<SettingsController> with EquatableMixin {
  SettingsModel(
    SettingsController controller, {
    this.action,
    this.actionMessage,
    this.draftInputs,
    this.clearOnAdd,
    this.copyListName,
    this.copyListStates,
  }) : super(controller);

  final SettingsAction action;
  final String actionMessage;
  final bool draftInputs;
  final bool clearOnAdd;
  final bool copyListName;
  final bool copyListStates;

  @override
  void update({
    bool skipRebuild,
    SettingsAction action,
    String actionMessage,
    bool draftInputs,
    bool clearOnAdd,
    bool copyListName,
    bool copyListStates,
  }) {
    SettingsModel(
      controller,
      action: action ?? SettingsAction.None,
      actionMessage: actionMessage ?? this.actionMessage,
      draftInputs: draftInputs ?? this.draftInputs,
      clearOnAdd: clearOnAdd ?? this.clearOnAdd,
      copyListName: copyListName ?? this.copyListName,
      copyListStates: copyListStates ?? this.copyListStates,
    ).updateMomentum(skipRebuild: skipRebuild);
  }

  Map<String, dynamic> toJson() {
    return {
      'actionMessage': actionMessage,
      'draftInputs': draftInputs,
      'clearOnAdd': clearOnAdd,
      'copyListName': copyListName,
      'copyListStates': copyListStates,
    };
  }

  SettingsModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return SettingsModel(
      controller,
      action: SettingsAction.None,
      actionMessage: map['actionMessage'],
      draftInputs: map['draftInputs'],
      clearOnAdd: map['clearOnAdd'],
      copyListName: map['copyListName'],
      copyListStates: map['copyListStates'],
    );
  }

  @override
  List<Object> get props => [
        action,
        actionMessage,
        draftInputs,
        clearOnAdd,
        copyListName,
        copyListStates,
      ];
}

enum SettingsAction {
  None,
  DraftCleared,
}
