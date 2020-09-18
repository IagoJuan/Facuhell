import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flame/position.dart';

class PotionLife extends GameDecoration {
  final Position initPosition;
  final double life;
  double _lifeDistributed = 0;

  PotionLife(this.initPosition, this.life)
      : super(
          sprite: Sprite('itens/potion_red.png'),
          initPosition: initPosition,
          width: 32,
          height: 32,
        );

  @override
  void update(double dt) {
    if (gameRef.player != null && position.overlaps(gameRef.player.position)) {
      Timer.periodic(Duration(milliseconds: 100), (timer) {
        if (_lifeDistributed >= life) {
          timer.cancel();
        } else {
          _lifeDistributed += 2;
          gameRef.player.addLife(6);
        }
      });
      remove();
    }
    super.update(dt);
  }
}
