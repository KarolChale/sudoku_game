import 'package:flutter/material.dart';
import 'package:sudoku_game/ui/SudokuCell.dart';

class SudokuTable extends StatefulWidget {
  final List<List<dynamic>> tablero;
  final List<List<dynamic>> unable;
  final List activeCell;
  final Function() notifyParent;
  SudokuTable(this.tablero, this.unable, this.activeCell, this.notifyParent);

  @override
  _SudokuTableState createState() => _SudokuTableState();
}

class _SudokuTableState extends State<SudokuTable> {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder(
        left: BorderSide(width: 2.5, color: Colors.black),
        top: BorderSide(width: 2.5, color: Colors.black),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _getTableRows(),
    );
  }

  List<TableRow> _getTableRows() {
    return List.generate(9, (int rowNumber) {
      return TableRow(children: _getRow(rowNumber));
    });
  }

  List<Widget> _getRow(int rowNumber) {
    return List.generate(9, (int colNumber) {
      return Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: (colNumber % 3 == 2) ? 2.5 : 0.7,
                color: (colNumber % 3 == 2) ? Colors.black : Color(0xffBDC6D4),
              ),
              bottom: BorderSide(
                width: (rowNumber % 3 == 2) ? 2.5 : 0.7,
                color: (rowNumber % 3 == 2) ? Colors.black : Color(0xffBDC6D4),
              ),
            ),
          ),
          child: SudokuCell(rowNumber, colNumber, this.widget.unable, this.widget.tablero, this.widget.activeCell, this.widget.notifyParent));
    });
  }
}
