import 'package:flutter/material.dart';
import 'package:sudoku_game/home.dart';
import 'package:sudoku_game/operations/generation.dart';
import 'package:sudoku_game/operations/solver.dart';
import 'package:sudoku_game/ui/SudokuTable.dart';
import 'package:sudoku_game/ui/KeyPad.dart';
import 'package:sudoku_game/ui/EraserButton.dart';
import 'package:sudoku_game/ui/HintButton.dart';
import 'package:confetti/confetti.dart';
import 'dart:async';

class PlayPage extends StatefulWidget {
  final String levelName;

  PlayPage(this.levelName);
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  var tablero;
  var resolver;
  var unable;
  var activeCell = List(2);

  @override
  void initState() {
    super.initState();
    GenerateSudoku generateSudoku = new GenerateSudoku();

    tablero = generateSudoku.generateTable();
    //print(tablero);
    resolver = generateSudoku.generateSolveTable(tablero, this.widget.levelName);
    //print(resolver);
    unable = generateSudoku.getUnableNumbers(resolver);
    //print(unable);
  }

  refresh() {
    setState(() {});

    SolverSudoku solverSudoku = new SolverSudoku();
    bool finished = solverSudoku.checkFilled(resolver);
    ConfettiController _controllerCenter;
    //Si esta acabado muestra
    if (finished) {
      //
      bool solved = solverSudoku.solveEntireTable(tablero, resolver);
      print("Acabado: " + solved.toString());

      if (solved) {
        Timer(Duration(seconds: 3), () {
          _controllerCenter = ConfettiController(duration: const Duration(seconds: 10));
          _controllerCenter.play();
          showDialog(
            context: context,
            useSafeArea: false,
            builder: (context) {
              return Dialog(
                elevation: 16,
                backgroundColor: Colors.transparent,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xff315AAF)),
                    height: 200.0,
                    width: 360.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ConfettiWidget(
                          confettiController: _controllerCenter,
                          blastDirectionality: BlastDirectionality.explosive,
                          particleDrag: 0.05,
                          emissionFrequency: 0.01,
                          numberOfParticles: 20,
                          gravity: 0.05,
                          shouldLoop: false,
                          colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple], // manually specify the colors to be used
                        ),
                        Text("Excellent!", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white)),
                        Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.white),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                                },
                                child: Text("New Game", style: TextStyle(color: Color(0xff315AAF)))))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;

    return Scaffold(
      appBar: AppBar(title: Text(this.widget.levelName), centerTitle: true, backgroundColor: Color(0xff315AAF)),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SudokuTable(resolver, unable, activeCell, refresh),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EraserButton(resolver, unable, activeCell, refresh),
                    SizedBox(width: 20),
                    HintButton(tablero, resolver, unable, activeCell, refresh),
                  ],
                ),
                SizedBox(height: 20),
                KeyPad(activeCell, resolver, unable, refresh),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
