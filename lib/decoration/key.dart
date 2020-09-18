import 'package:bonfire/bonfire.dart';
import 'package:faculhell/player/player.dart';

class BossKey extends GameDecoration {
  BossKey(Position position)
      : super(
    sprite: Sprite('itens/key_silver.png'),
    initPosition: position,
    width: 32,
    height: 32,
  );

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) if (position
        .overlaps(gameRef.player.position)) {
      (gameRef.player as MyPlayer).containKey = true;
      remove();
    }
  }
}
