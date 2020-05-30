import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../components/input/index.dart';
import '../components/list/index.dart';
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
          title: AutoSizeText(
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
                items.add(
                  Card(
                    key: Key('$i'),
                    margin: EdgeInsets.only(top: sy(8)),
                    child: InkWell(
                      onTap: () {},
                      child: ListTile(
                        leading: Checkbox(
                          value: _listController.getCheckState(i),
                          tristate: true,
                          onChanged: (state) {
                            _inputController.toggleItemState(i);
                          },
                        ),
                        title: AutoSizeText(
                          list.items[i].listName,
                          style: TextStyle(fontSize: sy(11)),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.content_copy,
                                size: sy(18),
                              ),
                              onPressed: () {
                                _listController.createCopy(i);
                                Router.goto(context, AddNewList);
                              },
                              tooltip: 'Create Copy',
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                size: sy(18),
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _listController.removeItem(i);
                              },
                              tooltip: 'Remove Item',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
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
