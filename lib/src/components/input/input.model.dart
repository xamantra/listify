import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import '../../data/list-item.dart';
import 'index.dart';

enum InputAction {
  None,
  ErrorOccured,
  ListDataAdded,
  ListDataEdited,
  ListItemAdded,
}

class InputModel extends MomentumModel<InputController> with EquatableMixin {
  InputModel(
    InputController controller, {
    this.listName,
    this.items,
    this.action,
    this.actionMessage,
    this.itemName,
    this.editingList,
    this.editListName,
  }) : super(controller);

  final String listName;
  final List<ListItem> items;
  final InputAction action;
  final String actionMessage;
  final String itemName;
  final bool editingList;
  final String editListName;

  @override
  void update({
    bool skipRebuild,
    String listName,
    List<ListItem> items,
    InputAction action,
    String actionMessage,
    String itemName,
    bool editingList,
    String editListName,
  }) {
    InputModel(
      controller,
      listName: listName ?? this.listName,
      items: items ?? this.items,
      action: action ?? InputAction.None,
      actionMessage: actionMessage ?? this.actionMessage,
      itemName: itemName ?? this.itemName,
      editingList: editingList ?? this.editingList,
      editListName: editListName ?? this.editListName,
    ).updateMomentum(skipRebuild: skipRebuild);
  }

  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'items': items?.map((x) => x?.toJson())?.toList(),
      'actionMessage': actionMessage,
      'itemName': itemName,
      'editingList': editingList,
      'editListName': editListName,
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
      itemName: json['itemName'],
      editingList: json['editingList'],
      editListName: json['editListName'],
    );
  }

  @override
  List<Object> get props => [
        listName,
        items,
        action,
        actionMessage,
        itemName,
        editingList,
        editListName,
      ];
}
