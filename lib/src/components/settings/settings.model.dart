import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import 'index.dart';

class SettingsModel extends MomentumModel<SettingsController> with EquatableMixin {
  SettingsModel(
    SettingsController controller, {
    this.draftInputs,
  }) : super(controller);

  final bool draftInputs;

  @override
  void update({
    bool draftInputs,
  }) {
    SettingsModel(
      controller,
      draftInputs: draftInputs ?? this.draftInputs,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'draftInputs': draftInputs,
    };
  }

  SettingsModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return SettingsModel(
      controller,
      draftInputs: map['draftInputs'],
    );
  }

  @override
  List<Object> get props => [draftInputs];
}
