import 'package:listify/src/widgets/index.dart';
import 'package:momentum/momentum.dart';

import '../../models/index.dart';
import '../list/index.dart';
import 'index.dart';

class CurrentListController extends MomentumController<CurrentListModel> with RouterMixin {
  ListController listController;

  @override
  CurrentListModel init() {
    return CurrentListModel(
      this,
    );
  }

  @override
  void onRouteChanged(RouterParam param) {
    if (param is ViewListParam) {
      reset(clearHistory: true);
      dependOn<ListController>().view(param.index);
    }
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
