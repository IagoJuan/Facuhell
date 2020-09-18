import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

class Npc2 extends GameDecoration {
  int fala = 0;
  bool done = false;
  bool doneDialogue = false;
  //Timer

  Npc2(Position position)
      : super(
      animation: FlameAnimation.Animation.sequenced(
        "npc/Ranger_Idle_left.png",
        4,
        textureWidth: 32,
        textureHeight: 32,
      ),
      collision: Collision(
        width: 32,
        height: 32,
        align: CollisionAlign.CENTER,
      ),
      initPosition: position,
      width: 45,
      height: 45,

  );

  void update(double dt) {
    super.update(dt);

    this.seePlayer(
      observed: (player) {
        if (!done) {
          done = true;
          Future.delayed(Duration(seconds: 1), () {
            if(this.animation != null){
              print("animation nao eh nulo");
            }
            if (!doneDialogue) DialogueWithNpc();
          });
        }
      },
      notObserved: () {
        setDone();
      },
      visionCells: 2,
    );

  }

  void setDone(){
    //print("setdone executado");
    done = false;
  }

  void DialogueWithNpc(){
    if(fala == 0) {
      TalkDialog.show(
        gameRef.context,
        [
          setupIntroductionTalk('Opa, então você chegou até aqui'),
          setupIntroductionTalk('Estou surpreso, você parecia muito fraquinho para sobreviver'),
          setupIntroductionTalk('Mesmo assim você tá meio lerdo em, vim andando de lá até aqui numa boa e só agora você chegou'),
          setupIntroductionTalk('Enfim, continue em frente e vai achar a chave para abrir a sala do monstro'),
          setupIntroductionTalk('Já vou avisando, tome cuidado...'),
          setupIntroductionTalk('Porque a última coisa que quero é ficar aqui preso com outro cara!'),
          setupIntroductionTalk('Então trate de derrotar aquele monstro e dar o fora daqui... Boa sorte. '),
        ],
      );
      fala += 1;
      return;
    }else if(fala == 1){
      TalkDialog.show(
        gameRef.context,
        [
          setupIntroductionTalk('Me lembrei de uma coisa'),
          setupIntroductionTalk('A lenda diz que se você derrotar o monstro, terá acesso à uma chave'),
          setupIntroductionTalk('E com essa chave você pode resgatar uma princesa'),
          setupIntroductionTalk('Mas enfim, devem ser só boatos...'),
        ],
      );
      fala += 1;
    }else if(fala == 2){
      TalkDialog.show(
        gameRef.context,
        [
          setupIntroductionTalk('Você devia parar de perder tempo tentando conversar comigo e ir fazer alguma coisa pra sair daqui logo!'), // ref. ao SlimeBoss
          setupIntroductionTalk('Vamos, mete o pé daqui!'),
        ],
      );
      doneDialogue = true;
    }


  }

  Say setupIntroductionTalk(phrase){
    return Say(
      phrase,
      Flame.util.animationAsWidget(
        Position(80, 100),
        FlameAnimation.Animation.sequenced(
          "npc/npc1_idle.png",
          4,
          textureWidth: 32,
          textureHeight: 32,
        ),
      ),
      personDirection: PersonDirection.LEFT,
    );
  }




}