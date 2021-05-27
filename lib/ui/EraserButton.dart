import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class EraserButton extends StatefulWidget {
  final List<List<dynamic>> tablero;
  final List<List<dynamic>> unable;
  final List activeCell;
  final Function() notifyParent;

  EraserButton(this.tablero, this.unable, this.activeCell, this.notifyParent);

  @override
  _EraserButtonState createState() => _EraserButtonState();
}

class _EraserButtonState extends State<EraserButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!this.widget.unable[this.widget.activeCell[0]][this.widget.activeCell[1]]) {
          setState(() {
            this.widget.notifyParent();
            this.widget.tablero[this.widget.activeCell[0]][this.widget.activeCell[1]] = null;
          });
        }
      },
      child: Container(
        child: Column(children: [
          Image(image: new AssetImage("assets/eraser.png"), height: 60),
          Text("Erase"),
        ]),
      ),
    );
  }
}
