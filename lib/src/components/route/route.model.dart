import 'package:momentum/momentum.dart';

import 'index.dart';

class RouteModel extends MomentumModel<RouteController> {
  RouteModel(RouteController controller) : super(controller);

  @override
  void update() {
    RouteModel(
      controller,
    ).updateMomentum();
  }
}
