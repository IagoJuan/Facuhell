import 'package:bonfire/bonfire.dart';

class WallGoo extends GameDecoration {
  WallGoo(Position position)
      : super(
      sprite: Sprite('itens/wall_goo.png'),
      initPosition: position,
      width: 32,
      height: 32,
      collision: Collision(
        width: 24,
        height: 28,
        align: CollisionAlign.TOP_CENTER,
      ));
}