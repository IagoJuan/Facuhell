import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';

class Torch extends GameDecoration with WithLighting {
  Torch(Position position)
      : super(
          animation: FlameAnimation.Animation.sequenced(
            "itens/torch_spritesheet.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          initPosition: position,
          width: 32,
          height: 32,
        ) {
    lightingConfig = LightingConfig(
      gameComponent: this,
      radius: width * 1.5,
      blurBorder: width / 2,
    );
  }
}
