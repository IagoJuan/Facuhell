import 'package:bonfire/bonfire.dart';

class GreenFlag extends GameDecoration {
  GreenFlag(Position position)
      : super(
    sprite: Sprite('itens/flag_green.png'),
    initPosition: position,
    width: 32,
    height: 32,
  );
}