import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'main.dart';

final _ingredientHeight = 58.0;
final _ingredientIconWidth = 50.0;

class PageOne extends StatefulWidget {
  final List<Ingredient> ingredientList;
  PageOne({
    Key key,
    this.ingredientList,
  }) : super(key: key);

  @override
  PageOneState createState() => PageOneState();
}

class PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Text("Pick the ingredients you have available"),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.ingredientList.length,
              itemBuilder: (context, index) {
                return Card(
                  key: PageStorageKey('${widget.ingredientList[index].id}'),
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.ingredientList[index].checked =
                            !widget.ingredientList[index].checked;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          child:
                              Image.asset(widget.ingredientList[index].iconLoc),
                          width: _ingredientIconWidth,
                          height: _ingredientHeight,
                          padding: EdgeInsets.all(7.0),
                        ),
                        Text(
                          widget.ingredientList[index].name,
                          style: TextStyle(fontSize: 22),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Checkbox(
                              value: widget.ingredientList[index].checked,
                              onChanged: (bool c) {
                                setState(() {
                                  widget.ingredientList[index].checked =
                                      !widget.ingredientList[index].checked;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
