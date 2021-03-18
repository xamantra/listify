import 'package:momentum/momentum.dart';

import '../../pages/index.dart';
import '../../widgets/index.dart';
import '../current-list/index.dart';
import '../input/index.dart';
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
  void onRouteChanged(RouterParam? param) {
    if (param is ViewListParam) {
      controller<CurrentListController>().reset(clearHistory: true);
      controller<ListController>().view(param.index);
    }

    if (param is CopyListParam) {
      var data = getParam<CopyListParam>()!;
      controller<InputController>().reset(clearHistory: true);
      controller<ListController>().createCopy(data.index!);
    }

    if (param is EditListParam) {
      controller<ListController>().editList(param.listName);
    }
  }
}
