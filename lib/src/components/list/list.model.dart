import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import '../../data/list-data.dart';
import 'index.dart';

enum ListAction {
  None,
  ListConfirmDelete,
  ListDataDeleted,
}

class ListModel extends MomentumModel<ListController> with EquatableMixin {
  ListModel(
    ListController controller, {
    this.action,
    this.actionMessage,
    this.items,
    this.viewingIndex,
  }) : super(controller);

  final ListAction action;
  final String actionMessage;
  final List<ListData> items;
  final int viewingIndex;

  @override
  void update({
    bool skipRebuild,
    ListAction action,
    String actionMessage,
    List<ListData> items,
    int viewingIndex,
  }) {
    ListModel(
      controller,
      action: action ?? ListAction.None,
      actionMessage: actionMessage ?? this.actionMessage,
      items: items ?? this.items,
      viewingIndex: viewingIndex ?? this.viewingIndex,
    ).updateMomentum(skipRebuild: skipRebuild);
  }

  Map<String, dynamic> toJson() {
    return {
      'actionMessage': actionMessage,
      'items': items?.map((x) => x?.toJson())?.toList(),
      'viewingIndex': viewingIndex,
    };
  }

  ListModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ListModel(
      controller,
      action: ListAction.None,
      actionMessage: json['actionMessage'],
      items: List<ListData>.from(json['items']?.map((x) => ListData.fromJson(x))),
      viewingIndex: json['viewingIndex'],
    );
  }

  @override
  List<Object> get props => [
        items,
        viewingIndex,
        action,
        actionMessage,
      ];
}
