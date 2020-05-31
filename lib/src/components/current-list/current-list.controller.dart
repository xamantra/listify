import 'package:momentum/momentum.dart';

import '../../data/list-data.dart';
import '../list/index.dart';
import 'index.dart';

class CurrentListController extends MomentumController<CurrentListModel> {
  ListController listController;

  @override
  CurrentListModel init() {
    return CurrentListModel(
      this,
    );
  }

  @override
  void bootstrap() {
    listController = dependOn<ListController>();
  }

  void viewData(ListData data) {
    model.update(data: data);
  }

  void removeListItem(int index) {
    listController.removeListItem(index);
    listController.viewData();
  }

  void toggleItemState(int index) {
    listController.toggleItemState(index);
    listController.viewData();
  }

  void reorderListItems(int oldIndex, int newIndex) {
    listController.reorderListItems(oldIndex, newIndex);
    listController.viewData();
  }
}
