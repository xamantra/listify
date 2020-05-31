import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class SettingsModel extends MomentumModel<SettingsController> with EquatableMixin {
  SettingsModel(
    SettingsController controller, {
    this.draftInputs,
    this.clearOnAdd,
  }) : super(controller);

  final bool draftInputs;
  final bool clearOnAdd;

  @override
  void update({
    bool draftInputs,
    bool clearOnAdd,
  }) {
    SettingsModel(
      controller,
      draftInputs: draftInputs ?? this.draftInputs,
      clearOnAdd: clearOnAdd ?? this.clearOnAdd,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'draftInputs': draftInputs,
      'clearOnAdd': clearOnAdd,
    };
  }

  SettingsModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return SettingsModel(
      controller,
      draftInputs: map['draftInputs'],
      clearOnAdd: map['clearOnAdd'],
    );
  }

  @override
  List<Object> get props => [draftInputs, clearOnAdd];
}
