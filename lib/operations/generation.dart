import 'package:flutter/material.dart';
import 'dart:math';

class GenerateSudoku {
  var tablero = List.generate(9, (i) => List(9), growable: false);
  var rnd = new Random();
  var cadena = new List(9);

  List<List<dynamic>> generateSolveTable(List<List<dynamic>> array, String levelName) {
    //Elegimos filas random y columnas random para copiar un cierto numero de veces
    //_resetArray(resolver, " ");
    int dificultad_copias = _getCopiesLevel(levelName);
    var resolver = List.generate(9, (i) => List(9), growable: false);
    _resetArray(resolver, null);

    for (int i = 0; i < dificultad_copias; i++) {
      int fila_random = rnd.nextInt(9);
      int columna_random = rnd.nextInt(9);

      //if (resolver[fila_random][columna_random] != " ") {
      if (resolver[fila_random][columna_random] != null) {
        i--;
      } else {
        resolver[fila_random][columna_random] = array[fila_random][columna_random];
      }
    }
    return resolver;
  }

  int _getCopiesLevel(String cadena) {
    int copies = 76;

    if (cadena == 'Easy') {
      copies = 60;
    } else if (cadena == 'Medium') {
      copies = 40;
    } else if (cadena == 'Hard') {
      copies = 30;
    } else if (cadena == 'Expert') {
      copies = 25;
    }

    return copies;
  }

  List<List<dynamic>> getUnableNumbers(List<List<dynamic>> array) {
    var unable = List.generate(9, (i) => List(9), growable: false);

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (array[i][j] != null) {
          unable[i][j] = true;
        } else {
          unable[i][j] = false;
        }
      }
    }

    return unable;
  }

  bool _getRestart() {
    int holder = 0;
    bool restart = false;

    for (int i = 0; i < tablero.length; i++) {
      for (int j = 0; j < tablero[i].length; j++) {
        if (tablero[i][j] == 0) {
          holder++;
        }
      }
    }

    if (holder == 0) {
      restart = true;
    }

    return restart;
  }

  List<List<dynamic>> generateTable() {
    bool restart = false;

    do {
      int numero = 1;
      int contador = 0;
      int fila = 0;
      bool salida = false;
      int posibilidad = 0;
      _cleanArrays();

      do {
        _resetCadena();
        do {
          int columna = rnd.nextInt(9);
          bool igual = _existsCadena(columna);

          //Si no existe en la cadena entonces verificamos las 3 reglas
          if (!igual) {
            if (tablero[fila][columna] == 0) {
              bool existe = _existsTable(numero, fila, columna);

              if (!existe) {
                tablero[fila][columna] = numero;
                contador++;
                fila++;
                _resetCadena();
                posibilidad = 0;
              } else {
                cadena[posibilidad] = columna;
                posibilidad++;
              }
            } else if (tablero[fila][columna] != 0) {
              cadena[posibilidad] = columna;
              posibilidad++;
            }
          }
          if (cadena[8] != 55 && igual && contador < 9) {
            salida = true;
          }
          igual = false;
        } while (contador < 9 && !salida);

        if (contador == 9) {
          fila = 0;
          contador = 0;
          numero++;
        }
      } while (numero <= 9 && !salida);

      restart = _getRestart();
    } while (!restart);

    restart = false;

    return tablero;
  }

  void _cleanArrays() {
    _resetCadena();
    _resetArray(tablero, 0);
  }

  void _resetCadena() {
    for (int i = 0; i < 9; i++) {
      cadena[i] = 55;
    }
  }

  bool _existsCadena(int columna) {
    bool igual = false;
    for (int i = 0; i < 9; i++) {
      if (cadena[i] == columna) {
        igual = true;
      }
    }

    return igual;
  }

  void _resetArray(List<List<dynamic>> array, dynamic valor) {
    for (int i = 0; i < array.length; i++) {
      for (int j = 0; j < array[i].length; j++) {
        array[i][j] = valor;
      }
    }
  }

  List<int> getCuadrante(int fila, int columna) {
    List<int> cuadrantes = [0, 0, 0, 0];
    //Dependiendo de la fila que este, el EJE X sera, inicial y final X
    if (fila >= 0 && fila < 3) {
      cuadrantes[0] = 0;
      cuadrantes[1] = 3;
    } else if (fila >= 3 && fila < 6) {
      cuadrantes[0] = 3;
      cuadrantes[1] = 6;
    } else if (fila >= 6 && fila < 9) {
      cuadrantes[0] = 6;
      cuadrantes[1] = 9;
    }

    //Dependiendo de la columna que este, el EJE Y sera, inicial y final Y
    if (columna >= 0 && columna < 3) {
      cuadrantes[2] = 0;
      cuadrantes[3] = 3;
    } else if (columna >= 3 && columna < 6) {
      cuadrantes[2] = 3;
      cuadrantes[3] = 6;
    } else if (columna >= 6 && columna < 9) {
      cuadrantes[2] = 6;
      cuadrantes[3] = 9;
    }
    return cuadrantes;
  }

  bool _existsTable(int numero, int fila, int columna) {
    bool checkColumna = false;
    bool checkFila = false;
    bool checkCuadrante = false;
    bool exists = false;

    //Revisar filas
    for (int j = 0; j < 9; j++) {
      if (tablero[fila][j] == numero) {
        checkColumna = true;
      }
    }

    //Revisar columnas
    for (int i = 0; i < 9; i++) {
      if (tablero[i][columna] == numero) {
        checkFila = true;
      }
    }

    List<int> cuadrantes = getCuadrante(fila, columna);
    int inicialX = cuadrantes[0];
    int finalX = cuadrantes[1];
    int inicialY = cuadrantes[2];
    int finalY = cuadrantes[3];

    //Revisar cuadrante
    for (int x = inicialX; x < finalX; x++) {
      for (int y = inicialY; y < finalY; y++) {
        if (tablero[x][y] == numero) {
          checkCuadrante = true;
        }
      }
    }

    if (!checkCuadrante && !checkColumna && !checkFila) {
      exists = false;
    } else if (checkCuadrante || checkFila || checkColumna) {
      exists = true;
    }

    return exists;
  }
}
