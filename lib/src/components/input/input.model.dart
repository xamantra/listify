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
    this.addingItem,
  }) : super(controller);

  final String listName;
  final List<ListItem> items;
  final InputAction action;
  final String actionMessage;
  final bool addingItem;

  @override
  void update({
    String listName,
    List<ListItem> items,
    InputAction action,
    String actionMessage,
    bool addingItem,
  }) {
    InputModel(
      controller,
      listName: listName ?? this.listName,
      items: items ?? this.items,
      action: action ?? InputAction.None,
      actionMessage: actionMessage ?? this.actionMessage,
      addingItem: addingItem ?? this.addingItem,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'items': items?.map((x) => x?.toJson())?.toList(),
      'actionMessage': actionMessage,
      'addingItem': addingItem,
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
      addingItem: json['addingItem'],
    );
  }

  @override
  List<Object> get props => [
        listName,
        items,
        action,
        actionMessage,
        addingItem,
      ];
}

enum InputAction {
  None,
  ErrorOccured,
  ListDataAdded,
}
