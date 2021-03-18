import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:momentum/momentum.dart';

import '../components/input/index.dart';
import '../components/list/index.dart';
import '../components/settings/index.dart';
import '../utils/index.dart';
import '../widgets/index.dart';
import 'index.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  InputController? _inputController;
  ListController? _listController;
  SettingsController? _settingsController;

  @override
  void didChangeDependencies() {
    _inputController ??= Momentum.controller<InputController>(context);
    _listController ??= Momentum.controller<ListController>(context);
    _settingsController ??= Momentum.controller<SettingsController>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    var screen = screenSize(context);
    return RouterPage(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            title: MomentumBuilder(
              controllers: [ListController],
              builder: (context, snapshot) {
                var list = snapshot<ListModel>();
                if (list.isSearching!) {
                  return TextFormField(
                    initialValue: list.searchQuery,
                    onChanged: (value) {
                      _listController!.search(value);
                    },
                    style: TextStyle(
                      color: theme.appbarFont,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search ...',
                      hintStyle: TextStyle(
                        color: theme.appbarFont.withOpacity(0.6),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.appbarFont,
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.appbarFont,
                          width: 2,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.appbarFont,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }
                return Text(
                  'Listify',
                  style: TextStyle(
                    color: theme.appbarFont,
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                icon: MomentumBuilder(
                  controllers: [ListController],
                  builder: (context, snapshot) {
                    var isSearching = snapshot<ListModel>().isSearching!;
                    return Icon(
                      isSearching ? Icons.close : Icons.search,
                      color: theme.appbarFont,
                    );
                  },
                ),
                onPressed: () {
                  _listController!.toggleSearchMode();
                },
                tooltip: 'Search',
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: theme.appbarFont,
                ),
                onPressed: () {
                  MomentumRouter.goto(context, Settings);
                },
                tooltip: 'Settings',
              ),
            ],
          ),
          body: Container(
            height: screen.height,
            width: screen.width,
            padding: EdgeInsets.all(13),
            color: theme.bodyBackground,
            child: MomentumBuilder(
              controllers: [ListController],
              builder: (context, snapshot) {
                var list = snapshot<ListModel>();
                var items = <Widget>[];
                if (list.isSearching! && list.searchQuery!.trim().isNotEmpty) {
                  for (var i in list.controller.searchResults()) {
                    items.add(ListItemHome(key: Key('$i'), index: i, listData: list.items![i]));
                  }
                } else {
                  for (var i = 0; i < list.items!.length; i++) {
                    items.add(ListItemHome(key: Key('$i'), index: i, listData: list.items![i]));
                  }
                }
                return Container(
                  constraints: BoxConstraints(maxHeight: screen.height),
                  child: ReorderableListView(
                    children: items,
                    onReorder: (oldIndex, newIndex) {
                      print([oldIndex, newIndex]);
                      _listController!.reorder(oldIndex, newIndex);
                    },
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _settingsController!.executeDraftSetting();
              MomentumRouter.goto(context, AddNewList);
            },
            child: Icon(
              Icons.add,
              size: 20,
              color: theme.appbarFont,
            ),
          ),
        ),
      ),
    );
  }
}
