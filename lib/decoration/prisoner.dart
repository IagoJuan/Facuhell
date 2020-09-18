import 'package:bonfire/bonfire.dart';

class Prisoner extends GameDecoration {
  Prisoner(Position position)
      : super(
      sprite: Sprite('itens/prisoner.png'),
      initPosition: position,
      width: 32,
      height: 32,
  );
}