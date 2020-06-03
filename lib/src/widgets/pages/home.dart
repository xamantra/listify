import 'package:flutter/material.dart';
import 'package:listify/src/components/settings/index.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../components/input/index.dart';
import '../../components/list/index.dart';
import '../sub-widgets/better-text.dart';
import '../sub-widgets/list-item.home.dart';
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

  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    _inputController ??= Momentum.controller<InputController>(context);
    _listController ??= Momentum.controller<ListController>(context);
    _settingsController ??= Momentum.controller<SettingsController>(context);
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
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search ...',
                    hintStyle: TextStyle(
                      fontSize: sy(12),
                      color: Colors.white.withOpacity(0.6),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }
              return BetterText(
                'Listify',
                style: TextStyle(fontSize: sy(13)),
              );
            },
          ),
          actions: [
            IconButton(
              icon: MomentumBuilder(
                controllers: [ListController],
                builder: (context, snapshot) {
                  var isSearching = snapshot<ListModel>().isSearching;
                  return Icon(isSearching ? Icons.close : Icons.search, size: sy(18));
                },
              ),
              onPressed: () {
                _listController.toggleSearchMode();
              },
              tooltip: 'Search',
            ),
            IconButton(
              icon: Icon(Icons.settings, size: sy(18)),
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
          child: MomentumBuilder(
            controllers: [ListController],
            builder: (context, snapshot) {
              var list = snapshot<ListModel>();
              var items = <Widget>[];
              if (list.isSearching && list.searchQuery.trim().isNotEmpty) {
                for (var i in list.controller.searchResults()) {
                  items.add(ListItemHome(key: Key('$i'), i: i, listData: list.items[i]));
                }
              } else {
                for (var i = 0; i < list.items.length; i++) {
                  items.add(ListItemHome(key: Key('$i'), i: i, listData: list.items[i]));
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
          child: Icon(Icons.add, size: sy(18)),
        ),
      ),
    );
  }
}
