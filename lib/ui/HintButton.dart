import 'package:flutter/material.dart';
import 'dart:math';
import 'package:sudoku_game/operations/solver.dart';

class HintButton extends StatefulWidget {
  final List<List<dynamic>> tablero;
  final List<List<dynamic>> resolver;
  final List<List<dynamic>> unable;
  final List activeCell;

  final Function() notifyParent;

  HintButton(this.tablero, this.resolver, this.unable, this.activeCell, this.notifyParent);

  @override
  _HintButtonState createState() => _HintButtonState();
}

class _HintButtonState extends State<HintButton> {
  @override
  var rnd = new Random();
  SolverSudoku solverSudoku = new SolverSudoku();

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          this.widget.notifyParent();
          //Poner un control de solo realizarlo si hay casillas disponibles
          bool finished = solverSudoku.checkFilled(this.widget.resolver);
          if (!finished) {
            for (int i = 0; i < 1; i++) {
              int fila_random = rnd.nextInt(9);
              int columna_random = rnd.nextInt(9);

              if (this.widget.resolver[fila_random][columna_random] != null) {
                i--;
              } else {
                //poner la nueva casilla en el tablero y unable
                this.widget.resolver[fila_random][columna_random] = this.widget.tablero[fila_random][columna_random];
                this.widget.unable[fila_random][columna_random] = true;
                //ademas marcarla como active cell
                setState(() {
                  this.widget.notifyParent();
                  this.widget.activeCell[0] = fila_random;
                  this.widget.activeCell[1] = columna_random;
                });
              }
            }
          }
        });
      },
      child: Container(
        child: Column(children: [
          Image(image: new AssetImage("assets/paper-plane.png"), height: 60),
          Text("Hint"),
        ]),
      ),
    );
  }
}
