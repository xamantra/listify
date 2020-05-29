import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import '../../data/list-data.dart';
import 'index.dart';

class ListModel extends MomentumModel<ListController> with EquatableMixin {
// class ListModel extends MomentumModel<ListController> {
  ListModel(
    ListController controller, {
    this.items,
  }) : super(controller);

  final List<ListData> items;

  @override
  void update({
    List<ListData> items,
  }) {
    ListModel(
      controller,
      items: items ?? this.items,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((x) => x?.toJson())?.toList(),
    };
  }

  ListModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListModel(
      controller,
      items: List<ListData>.from(map['items']?.map((x) => ListData.fromJson(x))),
    );
  }

  @override
  List<Object> get props => [items];
}
