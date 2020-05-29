import 'package:equatable/equatable.dart';

import 'list-item.dart';

class ListData extends Equatable {
  final String listName;
  final List<ListItem> items;

  ListData({
    this.listName,
    this.items,
  });
  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'items': items?.map((x) => x?.toJson())?.toList(),
    };
  }

  static ListData fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return ListData(
      listName: map['listName'],
      items: List<ListItem>.from(map['items']?.map((x) => ListItem.fromJson(x))),
    );
  }

  @override
  List<Object> get props => [listName, items];
}
