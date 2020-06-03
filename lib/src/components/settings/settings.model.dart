import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class SettingsModel extends MomentumModel<SettingsController> with EquatableMixin {
  SettingsModel(
    SettingsController controller, {
    this.draftInputs,
    this.clearOnAdd,
    this.copyListName,
    this.copyListStates,
  }) : super(controller);

  final bool draftInputs;
  final bool clearOnAdd;
  final bool copyListName;
  final bool copyListStates;

  @override
  void update({
    String actionMessage,
    bool draftInputs,
    bool clearOnAdd,
    bool copyListName,
    bool copyListStates,
  }) {
    SettingsModel(
      controller,
      draftInputs: draftInputs ?? this.draftInputs,
      clearOnAdd: clearOnAdd ?? this.clearOnAdd,
      copyListName: copyListName ?? this.copyListName,
      copyListStates: copyListStates ?? this.copyListStates,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
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
      draftInputs: map['draftInputs'],
      clearOnAdd: map['clearOnAdd'],
      copyListName: map['copyListName'],
      copyListStates: map['copyListStates'],
    );
  }

  @override
  List<Object> get props => [
        draftInputs,
        clearOnAdd,
        copyListName,
        copyListStates,
      ];
}
