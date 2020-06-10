import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../components/input/index.dart';
import '../components/list/index.dart';
import '../components/settings/index.dart';
import '../components/theme/index.dart';
import '../models/index.dart';
import '../widgets/index.dart';
import 'add-list.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RelativeScale {
  InputController _inputController;
  ListController _listController;
  SettingsController _settingsController;
  ListifyTheme theme;

  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    _inputController ??= Momentum.controller<InputController>(context);
    _listController ??= Momentum.controller<ListController>(context);
    _settingsController ??= Momentum.controller<SettingsController>(context);
    theme = Momentum.controller<ThemeController>(context).selectedTheme();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RouterPage(
      child: Scaffold(
        appBar: AppBar(
          title: MomentumBuilder(
            controllers: [ListController],
            builder: (context, snapshot) {
              var list = snapshot<ListModel>();
              if (list.isSearching) {
                return TextFormField(
                  initialValue: list.searchQuery,
                  onChanged: (value) {
                    _listController.search(value);
                  },
                  style: TextStyle(
                    fontSize: sy(12),
                    color: theme.appbarFont,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search ...',
                    hintStyle: TextStyle(
                      fontSize: sy(12),
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
              return BetterText(
                'Listify',
                style: TextStyle(
                  fontSize: sy(13),
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
                  var isSearching = snapshot<ListModel>().isSearching;
                  return Icon(
                    isSearching ? Icons.close : Icons.search,
                    size: sy(18),
                    color: theme.appbarFont,
                  );
                },
              ),
              onPressed: () {
                _listController.toggleSearchMode();
              },
              tooltip: 'Search',
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                size: sy(18),
                color: theme.appbarFont,
              ),
              onPressed: () {
                Router.goto(context, Settings);
              },
              tooltip: 'Settings',
            ),
          ],
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.all(sy(12)),
          color: theme.bodyBackground,
          child: MomentumBuilder(
            controllers: [ListController],
            builder: (context, snapshot) {
              var list = snapshot<ListModel>();
              var items = <Widget>[];
              if (list.isSearching && list.searchQuery.trim().isNotEmpty) {
                for (var i in list.controller.searchResults()) {
                  items.add(ListItemHome(key: Key('$i'), index: i, listData: list.items[i], theme: theme));
                }
              } else {
                for (var i = 0; i < list.items.length; i++) {
                  items.add(ListItemHome(key: Key('$i'), index: i, listData: list.items[i], theme: theme));
                }
              }
              return Container(
                constraints: BoxConstraints(maxHeight: screenHeight),
                child: ReorderableListView(
                  children: items,
                  onReorder: (oldIndex, newIndex) {
                    print([oldIndex, newIndex]);
                    _listController.reorder(oldIndex, newIndex);
                  },
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _settingsController.executeDraftSetting();
            Router.goto(context, AddNewList);
          },
          child: Icon(
            Icons.add,
            size: sy(18),
            color: theme.appbarFont,
          ),
        ),
      ),
    );
  }
}
