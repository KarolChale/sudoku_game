import 'package:flutter/material.dart';
import 'package:sudoku_game/operations/solver.dart';

class KeyPadCell extends StatefulWidget {
  final List<List<dynamic>> tablero;
  final List<List<dynamic>> unable;
  final int number;
  final List activeCell;
  final Function() notifyParent;

  KeyPadCell(this.number, this.activeCell, this.tablero, this.unable, this.notifyParent);
  @override
  _KeyPadCellState createState() => _KeyPadCellState();
}

class _KeyPadCellState extends State<KeyPadCell> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 50,
      child: InkResponse(
          onTap: () {
            setState(() {
              this.widget.notifyParent();
              if (!this.widget.unable[this.widget.activeCell[0]][this.widget.activeCell[1]]) {
                this.widget.tablero[this.widget.activeCell[0]][this.widget.activeCell[1]] = this.widget.number;
              }
            });
          },
          child: Container(child: Center(child: Text(this.widget.number.toString(), style: TextStyle(fontSize: 38))))),
    );
  }
}
