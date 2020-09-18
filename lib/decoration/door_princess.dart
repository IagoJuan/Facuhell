import 'package:bonfire/bonfire.dart';
import 'package:faculhell/player/player.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class PrincessDoor extends GameDecoration {
  bool open = false;
  bool showDialog = false;

  PrincessDoor(Position position)
      : super(
          sprite: Sprite('itens/door_closed.png'),
          initPosition: position,
          width: 64,
          height: 64,
          frontFromPlayer: true,
          collision: Collision(
            width: 64,
            height: 20,
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    this.seePlayer(
      observed: (player) {
        if (!open) {
          if ((player as MyPlayer).containKeyPrincess) {
            open = true;
            gameRef.add(
              AnimatedObjectOnce(
                animation: FlameAnimation.Animation.sequenced(
                  'itens/door_open.png',
                  14,
                  textureWidth: 32,
                  textureHeight: 32,
                ),
                position: position,
                onFinish: () {
                  (player as MyPlayer).containKeyPrincess = false;
                },
              ),
            );
            Future.delayed(Duration(milliseconds: 200), () {
              remove();
            });
          } else {
            if (!showDialog) {
              showDialog = true;
              _showIntroduction();
            }
          }
        }
      },

      notObserved: () {
        showDialog = false;
      },
      visionCells: 1,
    );
  }

  void _showIntroduction() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          'Parece que preciso de uma chave para abrir essa porta...',
          Flame.util.animationAsWidget(
            Position(80, 100),
            FlameAnimation.Animation.sequenced(
              "player/player_idle_right.png",
              4,
              textureWidth: 32,
              textureHeight: 32,
            ),
          ),
          personDirection: PersonDirection.LEFT,
        ),
      ],
    );
  }
}
