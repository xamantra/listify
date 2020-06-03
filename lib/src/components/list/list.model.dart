import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:momentum/momentum.dart';

import '../../data/list-data.dart';
import 'index.dart';

enum ListAction {
  None,
  ListConfirmDelete,
  ListDataDeleted,
}

class ListEvent {
  final ListAction action;
  final String message;

  ListEvent({
    @required this.action,
    this.message,
  });
}

class ListModel extends MomentumModel<ListController> with EquatableMixin {
  ListModel(
    ListController controller, {
    this.items,
    this.viewingIndex,
  }) : super(controller);

  final List<ListData> items;
  final int viewingIndex;

  @override
  void update({
    List<ListData> items,
    int viewingIndex,
  }) {
    ListModel(
      controller,
      items: items ?? this.items,
      viewingIndex: viewingIndex ?? this.viewingIndex,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((x) => x?.toJson())?.toList(),
      'viewingIndex': viewingIndex,
    };
  }

  ListModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ListModel(
      controller,
      items: List<ListData>.from(json['items']?.map((x) => ListData.fromJson(x))),
      viewingIndex: json['viewingIndex'],
    );
  }

  @override
  List<Object> get props => [
        items,
        viewingIndex,
      ];
}
