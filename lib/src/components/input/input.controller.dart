import 'package:momentum/momentum.dart';

import '../../data/list-data.dart';
import '../../data/list-item.dart';
import '../list/index.dart';
import 'index.dart';

class InputController extends MomentumController<InputModel> {
  @override
  InputModel init() {
    return InputModel(
      this,
      listName: '',
      items: [],
      action: InputAction.None,
      actionMessage: '',
      itemName: '',
      editingList: false,
    );
  }

  /// Do not allow empty list name or empty items.
  bool validInput() {
    var inputNotEmpty = model.listName.isNotEmpty && model.items.isNotEmpty;
    return inputNotEmpty;
  }

  /// Check if list name already exists or list name and exact same list items already exist.
  bool exists() {
    // access another controller.
    var exists = dependOn<ListController>().dataExists(model.listName, model.items);
    return exists;
  }

  /// Submit the values inputted by the user and check for errors.
  void submit() {
    if (!validInput()) {
      triggerAction(
        actionMessage: "List name and items are both required.",
        action: InputAction.ErrorOccured,
      );
      return;
    }
    if (exists() && !model.editingList) {
      triggerAction(
        actionMessage: "List data with same list items or same list name already exist.",
        action: InputAction.ErrorOccured,
      );
      return;
    }
    var _listController = dependOn<ListController>();
    if (model.editingList) {
      _listController.updateList(model.editListName, model.listName, model.items);
      triggerAction(action: InputAction.ListDataEdited);
    } else {
      _listController.addList(ListData(listName: model.listName, items: model.items));
      triggerAction(action: InputAction.ListDataAdded);
    }
    reset(clearHistory: true);
  }

  void triggerAction({InputAction action, String actionMessage}) {
    model.update(
      skipRebuild: true,
      action: action,
      actionMessage: actionMessage ?? '',
    );
  }

  /// Update list name with the new user input.
  /// Currently used in text field `onChanged` callback.
  void setListName(String value) {
    model.update(listName: value);
  }

  void setItemName(String value) {
    model.update(itemName: value);
  }

  /// Add new item in the items input with the name provided.
  void addItem() {
    if (model.itemName.isEmpty) {
      triggerAction(
        actionMessage: "Item name is required!",
        action: InputAction.ErrorOccured,
      );
      return;
    }
    var items = List<ListItem>.from(model.items);
    var itemExists = items.any((x) => x.name == model.itemName);
    if (itemExists) {
      triggerAction(
        actionMessage: "Item name already exists!",
        action: InputAction.ErrorOccured,
      );
      return;
    }
    items.add(ListItem(name: model.itemName, listState: false));
    model.update(items: items);
    triggerAction(action: InputAction.ListItemAdded);
  }

  void toggleItemState(int index) {
    var items = List<ListItem>.from(model.items);
    var item = items[index];
    var state = item.listState;
    var updatedItem = ListItem(
      name: item.name,
      listState: state == false ? true : state == true ? null : false,
    );
    items
      ..removeAt(index)
      ..insert(index, updatedItem);
    model.update(items: items);
  }

  /// Set the items input from external source
  /// Currently used in copy list function.
  void setItems(List<ListItem> value) {
    model.update(items: value);
  }

  void copyFrom(String listName, List<ListItem> items) {
    model.update(
      listName: listName,
      items: items,
      editingList: false,
      editListName: '',
    );
  }

  void editList(String listName, List<ListItem> items) {
    model.update(
      listName: listName,
      items: items,
      editingList: true,
      editListName: listName,
    );
  }

  /// Reorder the items input in the model and rebuild the widgets.
  void reorder(int oldIndex, int newIndex) {
    var items = List<ListItem>.from(model.items);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    model.update(items: items);
  }

  /// Remove an item from the items input by index.
  void removeItem(int index) {
    var items = List<ListItem>.from(model.items);
    model.update(items: items..removeAt(index));
  }
}

/* This code appeared multiple times in this controller. */
// var items = List<ListItem>.from(model.items)

// we need to create new instance of list instead of modifying directly from
// the current model state, list are not purely immutable.
