import 'package:bonfire/bonfire.dart';
import 'package:faculhell/player/player.dart';

class PrincessKey extends GameDecoration {
  PrincessKey(Position position)
      : super(
    sprite: Sprite('itens/key_princess.png'),
    initPosition: position,
    width: 32,
    height: 32,
  );

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) if (position
        .overlaps(gameRef.player.position)) {
      (gameRef.player as MyPlayer).containKeyPrincess = true;
      remove();
    }
  }
}
