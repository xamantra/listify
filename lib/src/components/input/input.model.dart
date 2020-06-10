import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:momentum/momentum.dart';

import '../../models/index.dart';
import 'index.dart';

enum InputAction {
  None,
  ErrorOccured,
  ListDataAdded,
  ListDataEdited,
  ListItemAdded,
}

class InputEvent {
  final InputAction action;
  final String message;

  InputEvent({
    @required this.action,
    this.message,
  });
}

class InputModel extends MomentumModel<InputController> with EquatableMixin {
  InputModel(
    InputController controller, {
    this.listName,
    this.items,
    this.itemName,
    this.editingList,
    this.editListName,
  }) : super(controller);

  final String listName;
  final List<ListItem> items;
  final String itemName;
  final bool editingList;
  final String editListName;

  @override
  void update({
    String listName,
    List<ListItem> items,
    String actionMessage,
    String itemName,
    bool editingList,
    String editListName,
  }) {
    InputModel(
      controller,
      listName: listName ?? this.listName,
      items: items ?? this.items,
      itemName: itemName ?? this.itemName,
      editingList: editingList ?? this.editingList,
      editListName: editListName ?? this.editListName,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'items': items?.map((x) => x?.toJson())?.toList(),
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
      itemName: json['itemName'],
      editingList: json['editingList'],
      editListName: json['editListName'],
    );
  }

  @override
  List<Object> get props => [
        listName,
        items,
        itemName,
        editingList,
        editListName,
      ];
}
