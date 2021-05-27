import 'package:flutter/material.dart';
import 'package:sudoku_game/operations/generation.dart';

class SudokuCell extends StatefulWidget {
  final int row, col;
  final List<List<dynamic>> unable;
  final List<List<dynamic>> tablero;
  final List activeCell;
  final Function() notifyParent;

  SudokuCell(this.row, this.col, this.unable, this.tablero, this.activeCell, this.notifyParent);
  @override
  _SudokuCellState createState() => _SudokuCellState();
}

class _SudokuCellState extends State<SudokuCell> {
  GenerateSudoku generateSudoku = new GenerateSudoku();
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        setState(() {
          this.widget.notifyParent();
          this.widget.activeCell[0] = this.widget.row;
          this.widget.activeCell[1] = this.widget.col;
        });
      },
      child: Container(
        height: 40,
        width: 30,
        color: _getColorCellActive(),
        child: Center(
          child: Text(
              this.widget.tablero[this.widget.row][this.widget.col] == null ? "" : this.widget.tablero[this.widget.row][this.widget.col].toString(),
              style: TextStyle(
                fontSize: 28,
                color: _getColorTextActive(),
                fontWeight: FontWeight.normal,
              )),
        ),
      ),
    );
  }

  Color _getColorTextActive() {
    Color finalColor;
    if (this.widget.unable[this.widget.row][this.widget.col]) {
      finalColor = Color(0xff2B2C2F);
    } else if (!this.widget.unable[this.widget.row][this.widget.col]) {
      finalColor = Color(0xff315AAF);
    }

    return finalColor;
  }

  Color _getColorCellActive() {
    Color finalColor = Colors.transparent;

    if (this.widget.activeCell[0] != null && this.widget.activeCell[1] != null) {
      bool equalActiveCell = this.widget.activeCell[0] == this.widget.row && this.widget.activeCell[1] == this.widget.col;
      bool equalActiveRow = this.widget.activeCell[0] == this.widget.row;
      bool equalActiveColumn = this.widget.activeCell[1] == this.widget.col;
      bool equalActiveValue =
          this.widget.tablero[this.widget.activeCell[0]][this.widget.activeCell[1]] == this.widget.tablero[this.widget.row][this.widget.col] &&
              this.widget.tablero[this.widget.activeCell[0]][this.widget.activeCell[1]] != null;

      //Si eres la cela activa
      if (equalActiveCell) {
        finalColor = Color(0xffC4DBFC);
      } else if (equalActiveRow) {
        //Si eres de la misma fila
        finalColor = Color(0xffE2E7ED);
      } else if (equalActiveColumn) {
        //Si eres de la misma columna
        finalColor = Color(0xffE2E7ED);
      } else if (equalActiveValue) {
        //Si eres del mismo valor que la cela activa, excepcion de vacio
        finalColor = Color(0xffCCD0DE);
      } else {
        //Si eres del mismo cuadrante
        List<int> cuadrantes = generateSudoku.getCuadrante(this.widget.activeCell[0], this.widget.activeCell[1]);
        int inicialX = cuadrantes[0];
        int finalX = cuadrantes[1];
        int inicialY = cuadrantes[2];
        int finalY = cuadrantes[3];
        for (int x = inicialX; x < finalX; x++) {
          for (int y = inicialY; y < finalY; y++) {
            if (x == this.widget.row && y == this.widget.col) {
              finalColor = Color(0xffE2E7ED);
            }
          }
        }
      }
    }
    return finalColor;
  }
}
