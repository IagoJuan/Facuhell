import 'package:faculhell/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showGameOver(BuildContext context, VoidCallback playAgain) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/game_over.png',
                height: 100,
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                color: Colors.transparent,
                onPressed: playAgain,
                child: Text(
                  "JOGAR NOVAMENTE",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 20.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showCongratulations(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Parabéns, você venceu o jogo!!!",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Normal',
                      fontSize: 30.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Color.fromARGB(255, 118, 82, 78),
                  child: Text("OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Normal',
                          fontSize: 17.0)),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Menu()),
                          (Route<dynamic> route) => false,
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}