import 'package:momentum/momentum.dart';

import '../../data/index.dart';
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

  ListifyTheme selectedTheme() {
    return themes[model.activeTheme];
  }

  List<ListifyTheme> get themes {
    return [
      indigoPinkLight,
      tealPurpleLight,
      indigoPinkDark,
      tealPurpleDark,
    ];
  }
}
