import 'dart:async';
import 'package:faculhell/game.dart';
import 'package:faculhell/util/sound.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool loading = false;
  bool showSplash = true;
  int currentPosition = 0;
  Timer _timer;
  List<Widget> sprites = [
    Flame.util.animationAsWidget(
      Position(80, 80),
      FlameAnimation.Animation.sequenced("enemy/slime_idle.png", 10,
          textureWidth: 16, textureHeight: 16),
    ),
    Flame.util.animationAsWidget(
      Position(80, 80),
      FlameAnimation.Animation.sequenced(
        "enemy/slime_dying.png",
        10,
        textureWidth: 16,
        textureHeight: 16,
      ),
    ),
  ];

  @override
  void initState() {
    Sound.playMenuSound();
    super.initState();
  }

  @override
  void dispose() {
    Sound.stopBackgroundSound();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: showSplash ? buildSplash() : buildMenu(),
    );
  }

  Widget buildMenu() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("FACULHELL",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Normal',
                        fontSize: 30.0)),
                SizedBox(
                  height: 20.0,
                ),
                sprites[currentPosition],
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: 150,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.blueAccent,
                    child: Text(
                      "JOGAR",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Title',
                        fontSize: 17.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      Future.delayed(
                        Duration(seconds: 3),
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Game()),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            InkWell(
              onTap: () {},
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Loading",
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'Title'),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildSplash() {
    return Scaffold(
      body: FlameSplashScreen(
        theme: FlameSplashTheme.dark,
        showBefore: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "FACULHELL",
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontFamily: 'Normal',
                ),
              ),
              Text(
                "The Game",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.blue,
                  fontFamily: 'Normal',
                ),
              ),
            ],
          );
        },
        showAfter: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "UNIMETROCAMP",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontFamily: 'Normal',
                ),
              ),
              Text(
                "2020",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.blue,
                  fontFamily: 'Normal',
                ),
              ),
            ],
          );
        },
        onFinish: (BuildContext context) {
          setState(() {
            showSplash = false;
          });
          startTimer();
        },
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentPosition++;
        if (currentPosition > sprites.length - 1) {
          currentPosition = 0;
        }
      });
    });
  }
}
