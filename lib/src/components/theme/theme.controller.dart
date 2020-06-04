import 'package:momentum/momentum.dart';

import '../../data/color-theme.dart';
import '../../data/themes.dart';
import 'index.dart';

class ThemeController extends MomentumController<ThemeModel> {
  @override
  ThemeModel init() {
    return ThemeModel(
      this,
      activeTheme: 0,
    );
  }

  void selectTheme(int index) {
    model.update(activeTheme: index);
  }

  List<ListifyColor> themes() {
    return [
      defaultTheme(),
      darkTheme(),
    ];
  }
}
