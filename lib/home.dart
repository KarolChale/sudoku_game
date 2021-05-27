import 'package:flutter/material.dart';
import 'package:sudoku_game/play.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    double sizeCube = 75;

    return Scaffold(
      backgroundColor: Color(0xff315AAF),
      body: SafeArea(
        child: Center(
          child: Container(
            width: width - 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Colors.white),
            height: height - 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width - 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        SizedBox(width: sizeCube, child: Align(alignment: Alignment.center, child: Text("S", style: TextStyle(fontSize: sizeCube)))),
                        SizedBox(width: sizeCube, child: Align(alignment: Alignment.center, child: Text("U", style: TextStyle(fontSize: sizeCube)))),
                        SizedBox(width: sizeCube, child: Image(image: new AssetImage("assets/pencil-fill.png"), height: sizeCube)),
                      ]),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        SizedBox(width: sizeCube, child: Image(image: new AssetImage("assets/eraser-fill.png"), height: sizeCube)),
                        SizedBox(width: sizeCube, child: Align(alignment: Alignment.center, child: Text("D", style: TextStyle(fontSize: sizeCube)))),
                        SizedBox(width: sizeCube, child: Align(alignment: Alignment.center, child: Text("O", style: TextStyle(fontSize: sizeCube)))),
                      ]),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        SizedBox(width: sizeCube, child: Align(alignment: Alignment.center, child: Text("K", style: TextStyle(fontSize: sizeCube)))),
                        SizedBox(width: sizeCube, child: Align(alignment: Alignment.center, child: Text("U", style: TextStyle(fontSize: sizeCube)))),
                        SizedBox(width: sizeCube, child: Image(image: new AssetImage("assets/graduation-cap-fill.png"), height: sizeCube)),
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  width: width - 150,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xff315AAF)),
                  child: TextButton(
                    onPressed: () {
                      showCupertinoModalPopup(context: context, builder: (context) => _buildCupertinoActionSheet(context));
                    },
                    child: Text("New Game", style: TextStyle(color: Colors.white, fontSize: 17)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _navigateToPlay(BuildContext context, String levelName) {
  _dimiss(context);
  Route route = MaterialPageRoute(builder: (context) => PlayPage(levelName));
  Navigator.push(context, route);
}

void _dimiss(BuildContext context) {
  Navigator.of(context).pop();
}

Widget _buildCupertinoActionSheet(BuildContext context) {
  return CupertinoActionSheet(
    title: Text("Choose level"),
    cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        onPressed: () {
          _dimiss(context);
        },
        child: Text("Cancel")),
    actions: [
      CupertinoActionSheetAction(
          onPressed: () {
            _navigateToPlay(context, "Easy");
          },
          child: Text("Easy")),
      CupertinoActionSheetAction(
          onPressed: () {
            _navigateToPlay(context, "Medium");
          },
          child: Text("Medium")),
      CupertinoActionSheetAction(
          onPressed: () {
            _navigateToPlay(context, "Hard");
          },
          child: Text("Hard")),
      CupertinoActionSheetAction(
          onPressed: () {
            _navigateToPlay(context, "Expert");
          },
          child: Text("Expert"))
    ],
  );
}
