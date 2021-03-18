import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import '../../models/index.dart';
import 'index.dart';

class CurrentListModel extends MomentumModel<CurrentListController> with EquatableMixin {
  CurrentListModel(
    CurrentListController controller, {
    this.data,
  }) : super(controller);

  final ListData? data;

  @override
  void update({
    ListData? data,
  }) {
    CurrentListModel(
      controller,
      data: data ?? this.data,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }

  CurrentListModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return CurrentListModel(
      controller,
      data: ListData.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [data];
}
