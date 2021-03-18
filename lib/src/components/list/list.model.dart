import 'package:equatable/equatable.dart';
import 'package:momentum/momentum.dart';

import '../../models/index.dart';
import 'index.dart';

enum ListAction {
  None,
  ListConfirmDelete,
  ListDataDeleted,
}

class ListEvent {
  final ListAction action;
  final String? message;

  ListEvent({
    required this.action,
    this.message,
  });
}

class ListModel extends MomentumModel<ListController> with EquatableMixin {
  ListModel(
    ListController controller, {
    this.items,
    this.viewingIndex,
    this.isSearching,
    this.searchQuery,
  }) : super(controller);

  final List<ListData>? items;
  final int? viewingIndex;
  final bool? isSearching;
  final String? searchQuery;

  @override
  void update({
    List<ListData>? items,
    int? viewingIndex,
    bool? isSearching,
    String? searchQuery,
  }) {
    ListModel(
      controller,
      items: items ?? this.items,
      viewingIndex: viewingIndex ?? this.viewingIndex,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
    ).updateMomentum();
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((x) => x.toJson()).toList(),
      'viewingIndex': viewingIndex,
      'isSearching': isSearching,
      'searchQuery': searchQuery,
    };
  }

  ListModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return ListModel(
      controller,
      items: List<ListData>.from(json['items']?.map((x) => ListData.fromJson(x))),
      viewingIndex: json['viewingIndex'],
      isSearching: json['isSearching'],
      searchQuery: json['searchQuery'],
    );
  }

  @override
  List<Object?> get props => [
        items,
        viewingIndex,
        isSearching,
        searchQuery,
      ];
}
