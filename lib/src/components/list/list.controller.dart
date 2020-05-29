import 'package:listify/src/data/list-item.dart';
import 'package:momentum/momentum.dart';

import '../../data/list-data.dart';
import '../input/index.dart';
import 'index.dart';

class ListController extends MomentumController<ListModel> {
  @override
  ListModel init() {
    return ListModel(
      this,
      items: [],
    );
  }

  bool dataExists(String listName, List<ListItem> items) {
    var exists = model.items.any((e) => e.listName == listName || e.items == items);
    return exists;
  }

  void addList(ListData item) {
    var lists = List<ListData>.from(model.items);
    lists.add(item);
    model.update(items: lists);
  }

  /// Reorder the items in the model and rebuild the widgets.
  void reorder(int oldIndex, int newIndex) {
    var lists = List<ListData>.from(model.items); // create new instance of list.
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = lists.removeAt(oldIndex);
    lists.insert(newIndex, item);
    model.update(items: lists);
  }

  void removeItem(int index) {
    var items = List<ListData>.from(model.items); // create new instance of list.
    model.update(items: items..removeAt(index));
  }

  void createCopy(int index) {
    var inputController = dependOn<InputController>();
    var toCopy = model.items[index];
    inputController.setListName(toCopy.listName);
    inputController.setItems(toCopy.items);
  }
}
