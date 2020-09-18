import 'package:bonfire/bonfire.dart';
import 'package:faculhell/player/player.dart';
import 'package:flame/animation.dart' as FlameAnimation;

class FirstDialogueTable extends GameDecoration {
  bool done = false;

  FirstDialogueTable(Position position)
      : super(
          sprite: Sprite('itens/table.png'),
          initPosition: position,
          width: 32,
          height: 32,
          collision: Collision(
            width: 24,
            height: 28,
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    this.seePlayer(
      observed: (player) {
        if (!done) {
              done = true;
              Future.delayed(Duration(seconds: 2), () {
                _showIntroduction();
              });
          }
        },
      visionCells: 5,
    );
  }

  Say setupIntroductionTalk(phrase){
    return Say(
      phrase,
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
    );
  }

  void _showIntroduction() {
    TalkDialog.show(
      gameRef.context,
      [
        setupIntroductionTalk('Onde estou?'),
        setupIntroductionTalk('O que aconteceu?'),
        setupIntroductionTalk('Ah...'),
        setupIntroductionTalk('Acho que acabei pegando no sono enquanto estava na aula...'),
        setupIntroductionTalk('Agora estou preso neste sonho estranho...'),
        setupIntroductionTalk('Esse lugar não me parece nada amigável.'),
        setupIntroductionTalk('Mas não tem como ser pior do que aquela porcaria de aula.'),
        setupIntroductionTalk('A matéria já é chata e o professor consegue deixar ainda pior.'),
        setupIntroductionTalk('Enfim, vou aproveitar minha habilidade de ter sonhos lúcidos e dar uma volta por aqui.'),
        setupIntroductionTalk('Talvez isso acabe sendo interessante heheh...'),
      ],
    );
  }
}
