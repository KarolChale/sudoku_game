import 'package:flutter/material.dart';
import 'package:sudoku_game/ui/KeyPadCell.dart';

class KeyPad extends StatefulWidget {
  final List<List<dynamic>> tablero;
  final List<List<dynamic>> unable;
  final List activeCell;
  final Function() notifyParent;

  KeyPad(this.activeCell, this.tablero, this.unable, this.notifyParent);
  @override
  _KeyPadState createState() => _KeyPadState();
}

class _KeyPadState extends State<KeyPad> {
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _getTableRows(),
    );
  }

  List<TableRow> _getTableRows() {
    return List.generate(1, (index) {
      return TableRow(children: _getRow());
    });
  }

  List<Widget> _getRow() {
    return List.generate(9, (index) {
      return KeyPadCell(index + 1, this.widget.activeCell, this.widget.tablero, this.widget.unable, this.widget.notifyParent);
    });
  }
}
