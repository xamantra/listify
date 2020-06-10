import 'package:flutter/foundation.dart';
import 'package:momentum/momentum.dart';

import '../../models/index.dart';
import '../current-list/index.dart';
import '../input/index.dart';
import '../settings/index.dart';
import 'index.dart';

class ListController extends MomentumController<ListModel> {
  @override
  ListModel init() {
    return ListModel(
      this,
      items: [],
      isSearching: false,
      searchQuery: '',
    );
  }

  void toggleSearchMode() {
    model.update(isSearching: !model.isSearching);
  }

  void search(String query) {
    model.update(searchQuery: query);
  }

  List<int> searchResults() {
    var results = <int>[];
    var q = model.searchQuery.trim().toLowerCase();
    for (var i = 0; i < model.items.length; i++) {
      if (model.items[i].listName.toLowerCase().contains(q)) {
        results.add(i);
      }
    }
    return results;
  }

  bool dataExists({
    String listName,
    List<ListItem> items,
    bool editMode,
  }) {
    var shouldCheckListName = false;
    var current = dependOn<CurrentListController>().model;
    if (editMode) {
      if (current.data.listName != listName) {
        shouldCheckListName = true;
      }
    }
    var exists = model.items.any((e) {
      var itemsEqual = e.items.length == items.length;
      if (itemsEqual) {
        for (var i = 0; i < items.length; i++) {
          if (items[i].name != e.items[i].name) {
            itemsEqual = false;
            break;
          }
        }
      }
      var listNameExists = shouldCheckListName ? e.listName == listName : false;
      return listNameExists || itemsEqual;
    });
    return exists;
  }

  void addList(ListData item) {
    var lists = List<ListData>.from(model.items);
    lists.add(item);
    model.update(items: lists);
  }

  void reorder(int oldIndex, int newIndex) {
    var lists = List<ListData>.from(model.items);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = lists.removeAt(oldIndex);
    lists.insert(newIndex, item);
    model.update(items: lists);
  }

  void reorderListItems(int oldIndex, int newIndex) {
    var dataItems = List<ListData>.from(model.items);
    var items = List<ListItem>.from(dataItems[model.viewingIndex].items);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    var data = ListData(
      listName: dataItems[model.viewingIndex].listName,
      items: items,
    );
    dataItems
      ..removeAt(model.viewingIndex)
      ..insert(model.viewingIndex, data);
    model.update(items: dataItems);
  }

  void removeItem(int index) {
    var items = List<ListData>.from(model.items);
    model.update(items: items..removeAt(index));
  }

  void removeListItem(int index) {
    var dataItems = List<ListData>.from(model.items);
    var items = List<ListItem>.from(dataItems[model.viewingIndex].items);
    items.removeAt(index);
    var data = ListData(
      listName: dataItems[model.viewingIndex].listName,
      items: items,
    );
    dataItems
      ..removeAt(model.viewingIndex)
      ..insert(model.viewingIndex, data);
    model.update(items: dataItems);
  }

  void createCopy(int index) {
    var inputController = dependOn<InputController>();
    var settings = dependOn<SettingsController>().model;
    var copyListStates = settings.copyListStates;
    var copyListName = settings.copyListName;
    var toCopy = model.items[index];
    var items = List<ListItem>.from(toCopy.items);
    if (!copyListStates) {
      for (var i = 0; i < items.length; i++) {
        items[i] = ListItem(
          name: items[i].name,
          listState: false,
        );
      }
    }
    inputController.copyFrom(
      copyListName ? toCopy.listName : '',
      items,
    );
  }

  void editList(String listName) {
    var toEdit = model.items.firstWhere((x) => x.listName == listName, orElse: () => null);
    if (toEdit != null) {
      var inputController = dependOn<InputController>();
      inputController.editList(toEdit.listName, toEdit.items);
    }
  }

  void updateList(
    String listName,
    String newListName,
    List<ListItem> newItems,
  ) {
    var items = List<ListData>.from(model.items);
    var index = items.indexWhere((x) => x.listName == listName);
    if (index != -1) {
      items.removeAt(index);
      items.insert(index, ListData(listName: newListName, items: newItems));
      model.update(items: items);
      dependOn<CurrentListController>().viewData(model.items[index]);
    }
  }

  void trigger({
    @required ListAction action,
    String actionMessage,
  }) {
    sendEvent(ListEvent(action: action, message: actionMessage ?? ''));
  }

  void confirmDelete(String listName) {
    var items = List<ListData>.from(model.items);
    var toDelete = items.firstWhere((x) => x.listName == listName);
    if (toDelete != null) {
      trigger(
        action: ListAction.ListConfirmDelete,
        actionMessage: 'Are you sure you want to delete the list "${toDelete.listName}" and its ${toDelete.items.length} items? There\'s no going back.',
      );
    }
  }

  void deleteList(String listName) {
    var items = List<ListData>.from(model.items);
    var index = items.indexWhere((x) => x.listName == listName);
    if (index != -1) {
      items.removeAt(index);
      model.update(items: items);
    }
  }

  bool getCheckState(int index) {
    var hasChecked = model.items[index].items.any((x) => x.listState == true);
    var hasUnchecked = model.items[index].items.any((x) => x.listState == false);
    var hasPartial = model.items[index].items.any((x) => x.listState == null);
    if (hasChecked && hasUnchecked) return null;
    if (hasPartial) return null;
    return hasChecked && !hasUnchecked && !hasPartial;
  }

  void view(int index) {
    model.update(viewingIndex: index);
    viewData();
  }

  void viewData() {
    var data = model.items[model.viewingIndex];
    dependOn<CurrentListController>().viewData(data);
  }

  void toggleItemState(int index) {
    var dataItems = List<ListData>.from(model.items);
    var items = List<ListItem>.from(dataItems[model.viewingIndex].items);
    var item = items[index];
    var state = item.listState;
    var updatedItem = ListItem(
      name: item.name,
      listState: state == false ? true : state == true ? null : false,
    );
    items
      ..removeAt(index)
      ..insert(index, updatedItem);
    var data = ListData(
      listName: dataItems[model.viewingIndex].listName,
      items: items,
    );
    dataItems
      ..removeAt(model.viewingIndex)
      ..insert(model.viewingIndex, data);
    model.update(items: dataItems);
  }
}
