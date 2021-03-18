import 'package:momentum/momentum.dart';

import '../../models/index.dart';
import '../list/index.dart';
import 'index.dart';

class InputController extends MomentumController<InputModel> {
  @override
  InputModel init() {
    return InputModel(
      this,
      listName: '',
      items: [],
      itemName: '',
      editingList: false,
    );
  }

  bool validInput() {
    var inputNotEmpty = model.listName!.isNotEmpty && model.items!.isNotEmpty;
    return inputNotEmpty;
  }

  bool exists() {
    var exists = controller<ListController>().dataExists(
      listName: model.listName,
      items: model.items,
      editMode: model.editingList!,
    );
    return exists;
  }

  void submit() {
    if (!validInput()) {
      triggerAction(
        actionMessage: "List name and items are both required.",
        action: InputAction.ErrorOccured,
      );
      return;
    }
    if (exists()) {
      triggerAction(
        actionMessage: "List data with same list items or same list name already exist.",
        action: InputAction.ErrorOccured,
      );
      return;
    }
    var _listController = controller<ListController>();
    if (model.editingList!) {
      _listController.updateList(model.editListName, model.listName, model.items);
      triggerAction(action: InputAction.ListDataEdited);
    } else {
      _listController.addList(ListData(listName: model.listName, items: model.items));
      triggerAction(action: InputAction.ListDataAdded);
    }
    reset(clearHistory: true);
  }

  void triggerAction({InputAction? action, String? actionMessage}) {
    sendEvent(InputEvent(action: action, message: actionMessage));
  }

  void setListName(String value) {
    model.update(listName: value);
  }

  void setItemName(String value) {
    model.update(itemName: value);
  }

  void addItem() {
    if (model.itemName!.isEmpty) {
      triggerAction(
        actionMessage: "Item name is required!",
        action: InputAction.ErrorOccured,
      );
      return;
    }
    var items = List<ListItem>.from(model.items!);
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
    var items = List<ListItem>.from(model.items!);
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

  void setItems(List<ListItem> value) {
    model.update(items: value);
  }

  void copyFrom(String? listName, List<ListItem> items) {
    model.update(
      listName: listName,
      items: items,
      editingList: false,
      editListName: '',
    );
  }

  void editList(String? listName, List<ListItem>? items) {
    model.update(
      listName: listName,
      items: items,
      editingList: true,
      editListName: listName,
    );
  }

  void reorder(int oldIndex, int newIndex) {
    var items = List<ListItem>.from(model.items!);
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    model.update(items: items);
  }

  void removeItem(int index) {
    var items = List<ListItem>.from(model.items!);
    model.update(items: items..removeAt(index));
  }
}
