import 'package:bonfire/bonfire.dart';
import 'package:faculhell/menu.dart';
import 'package:faculhell/util/sound.dart';
import 'package:faculhell/map/faculhell_map.dart';
import 'package:faculhell/player/player.dart';
import 'package:faculhell/player/player_interface.dart';
import 'package:flutter/material.dart';
import 'package:faculhell/util/dialogue.dart';
import 'package:flutter/rendering.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> implements GameListener {
  bool showGameOver = false;

  GameController _controller;

  @override
  void initState() {
    _controller = GameController()..setListener(this);
    Sound.playBackgroundSound();
    super.initState();
  }

  @override
  void dispose() {
    Sound.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      joystick: Joystick(
        directional: JoystickDirectional(
          spriteBackgroundDirectional: Sprite('joystick_background.png'),
          spriteKnobDirectional: Sprite('joystick_knob.png'),
          size: 100,
          isFixed: false,
        ),
        actions: [
          JoystickAction(
            actionId: 0,
            sprite: Sprite('joystick_attack.png'),
            spritePressed: Sprite('joystick_attack_selected.png'),
            size: 80,
            margin: EdgeInsets.only(bottom: 50, right: 50),
          ),
          JoystickAction(
            actionId: 1,
            sprite: Sprite('joystick_attack_power.png'),
            spriteBackgroundDirection: Sprite('joystick_attack_power_selected.png'),
            enableDirection: true,
            size: 50,
            margin: EdgeInsets.only(bottom: 50, right: 160),
          )
        ],
      ),
      player: MyPlayer(
        initPosition: Position(41 * 32.0, 94 * 32.0), // 41, 94
      ),
      interface: MyPlayerInterface(),
      map: FaculhellMap.map(),
      background: BackgroundColorGame(Colors.blueGrey[900]),
      decorations: FaculhellMap.decorations(),
      enemies: FaculhellMap.enemies(),
      lightingColorGame: Colors.black.withOpacity(0.4),
      gameController: _controller..setListener(this),
      constructionMode: false,
    );
  }

  void _showDialogGameOver() {
    setState(() {
      showGameOver = true;
    });
    Dialogs.showGameOver(
      context,
          () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Menu()),
              (Route<dynamic> route) => false,
        );
      },
    );
  }

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {
    if (_controller.player != null && _controller.player.isDead) {
      if (!showGameOver) {
        showGameOver = true;
        _showDialogGameOver();
      }
    }
  }
}
