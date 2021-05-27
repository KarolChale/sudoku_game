import 'package:flutter/material.dart';
import 'dart:math';

class SolverSudoku {
  bool solveEntireTable(List<List<dynamic>> original, List<List<dynamic>> solution) {
    bool igual = true;

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (original[i][j] != solution[i][j]) {
          igual = false;
          break;
        }
      }
    }

    return igual;
  }

  bool checkFilled(List<List<dynamic>> solution) {
    bool finished = true;

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (solution[i][j] == null) {
          finished = false;
          break;
        }
      }
    }
    return finished;
  }
}
