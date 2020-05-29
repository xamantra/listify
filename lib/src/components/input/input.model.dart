import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import '../../data/list-item.dart';
import 'index.dart';

class InputModel extends MomentumModel<InputController> with EquatableMixin {
  InputModel(
    InputController controller, {
    this.listName,
    this.items,
    this.action,
    this.actionMessage,
  }) : super(controller);

  final String listName;
  final List<ListItem> items;
  final InputAction action;
  final String actionMessage;

  @override
  void update({
    String listName,
    List<ListItem> items,
    InputAction action,
    String actionMessage,
  }) {
    InputModel(
      controller,
      listName: listName ?? this.listName,
      items: items ?? this.items,
      action: action ?? InputAction.None,
      actionMessage: actionMessage ?? actionMessage,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'items': items?.map((x) => x?.toJson())?.toList(),
      'actionMessage': actionMessage,
    };
  }

  InputModel fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return InputModel(
      controller,
      listName: json['listName'],
      items: List<ListItem>.from(json['items']?.map((x) => ListItem.fromJson(x))),
      action: InputAction.None,
      actionMessage: json['actionMessage'],
    );
  }

  @override
  List<Object> get props => [listName, items, action, actionMessage];
}

enum InputAction {
  None,
  ErrorOccured,
  ListDataAdded,
}
