import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ListItem extends Equatable {
  final String name;
  final int listState;

  ListItem({
    @required this.name,
    @required this.listState,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'listState': listState,
    };
  }

  static ListItem fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ListItem(
      name: json['name'],
      listState: json['listState'],
    );
  }

  @override
  List<Object> get props => [name, listState];
}
