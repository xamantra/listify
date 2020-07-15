import 'package:listify/src/components/input/index.dart';
import 'package:listify/src/pages/index.dart';
import 'package:momentum/momentum.dart';

import '../../widgets/index.dart';
import '../current-list/index.dart';
import '../list/index.dart';
import 'index.dart';

class RouteController extends MomentumController<RouteModel> with RouterMixin {
  @override
  RouteModel init() {
    return RouteModel(
      this,
    );
  }

  @override
  void onRouteChanged(RouterParam param) {
    if (param is ViewListParam) {
      dependOn<CurrentListController>().reset(clearHistory: true);
      dependOn<ListController>().view(param.index);
    }

    if (param is CopyListParam) {
      var data = getParam<CopyListParam>();
      dependOn<InputController>().reset(clearHistory: true);
      dependOn<ListController>().createCopy(data.index);
    }

    if (param is EditListParam) {
      dependOn<ListController>().editList(param.listName);
    }
  }
}
