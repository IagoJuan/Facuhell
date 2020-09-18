import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

class Npc extends GameDecoration {
  int fala = 0;
  bool done = false;
  bool doneDialogue = false;
  //Timer

  Npc(Position position)
      : super(
      animation: FlameAnimation.Animation.sequenced(
        "npc/npc1_idle.png",
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
          setupIntroductionTalk('Ah, oi!'),
          setupIntroductionTalk('Então você foi o escolhido...'),
          setupIntroductionTalk('Sabe, eu costumava ser como você'),
          setupIntroductionTalk('Andava dormindo nas aulas, até um dia vir parar aqui'),
          setupIntroductionTalk('Tem vários slimes bem rápidos por aqui mas você deve dar conta deles assim como eu dei, porém...'),
          setupIntroductionTalk('Após andar por esses corredores, encontrei um monstro terrível e ele me acertou em cheio...'),
          setupIntroductionTalk('Desde então estou preso neste lugar por muitos e muitos anos...'),
          setupIntroductionTalk('Espero que você não tenha o mesmo destino... Boa sorte. '),
        ],
      );
      fala += 1;
      return;
    }else if(fala == 1){
      TalkDialog.show(
        gameRef.context,
        [
          setupIntroductionTalk('Não me faça perguntas, estou muito ocupado agora'),
          setupIntroductionTalk('Mas saiba que você precisa de uma chave para enfrentar o monstro'),
          setupIntroductionTalk('Agora, onde ela está e como consegui-lá já é problema seu'),
        ],
      );
      fala += 1;
    }else if(fala == 2){
      TalkDialog.show(
        gameRef.context,
        [
          setupIntroductionTalk('Ah, se achar frascos vermelhos, não hesite em pegá-los'), // ref. ao SlimeBoss
          setupIntroductionTalk('Eles recuperam um pouco da sua vida miserável'),
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