import 'package:flutter/material.dart';
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

  @override
  void didChangeDependencies() {
    initRelativeScaler(context);
    _inputController ??= Momentum.of<InputController>(context);
    _listController ??= Momentum.of<ListController>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RouterPage(
      child: Scaffold(
        appBar: AppBar(
          title: BetterText(
            'Listify',
            style: TextStyle(fontSize: sy(13)),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.undo, size: sy(18)),
              onPressed: () {
                _listController.backward();
              },
              tooltip: 'Undo',
            ),
            IconButton(
              icon: Icon(Icons.redo, size: sy(18)),
              onPressed: () {
                _listController.forward();
              },
              tooltip: 'Redo',
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
              for (var i = 0; i < list.items.length; i++) {
                items.add(ListItemHome(key: Key('$i'), i: i, listData: list.items[i]));
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
            Router.goto(context, AddNewList);
          },
          child: Icon(Icons.add, size: sy(18)),
        ),
      ),
    );
  }
}
