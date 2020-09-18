import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:faculhell/player/player.dart';
import 'package:faculhell/util/sound.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../menu.dart';

class Princess extends GameDecoration {
  bool done = false;

  Princess(Position position)
      : super(
          animation: FlameAnimation.Animation.sequenced(
            "npc/princess_idle_right.png",
            4,
            textureWidth: 16,
            textureHeight: 22,
          ),
          collision: Collision(
            width: 32,
            height: 32,
            align: CollisionAlign.CENTER,
          ),
          initPosition: position,
          width: 32,
          height: 32,
        );

  void update(double dt) {
    super.update(dt);

    this.seePlayer(
      observed: (player) {
        if (!done) {
          done = true;

          DialogueWithNpc();
        }

      },
      visionCells: 1,
    );
  }

  void DialogueWithNpc() {
    TalkDialog.show(gameRef.context, [
      setupIntroductionTalk('AHHHHHHHH UM MONSTRO!!!!!'),
      setupIntroductionTalk('Não, espere...'),
      setupIntroductionTalk('É uma pessoa!'),
      setupIntroductionTalk('Finalmente vou ser resgatada!'),
      setupIntroductionTalk(
          'Mal posso acreditar! Após todos esses anos presa nessa lugar horrível'),
      setupIntroductionTalk('Me diga o seu nome, meu caro cavalheiro'),
      setupIntroductionTalk('E seremos felizes para sempre!'),
      setupPlayerTalk('Meu nome é Jubileu, minha cara princesa...'),
      setupPlayerTalk(
          'Mas sinto lhe informar, minha namorada espera por mim no mundo em que eu vivia...'),
      setupPlayerTalk('Tudo que eu quero é voltar para minha realidade, e...'),
      setupPlayerTalk(
          'Sinceramente, você não faz muito meu tipo, sabe como é né, você parece ser meio fresca e tals heheh'),
      setupIntroductionTalk('...'),
      setupPlayerTalk('...'),
      setupFinalTalk('E assim acaba a história do nosso caro Jubileu.'),
      setupFinalTalk(
          'Nem todas as histórias tem um final completo e feliz, e você nunca vai saber o que aconteceu após esse momento de silêncio entre os dois...'),
      setupFinalTalk(
          'Talvez isso seja porque a história foi escrita às pressas, ou talvez eles só quisessem te trollar mesmo, nunca se sabe...'),
      setupFinalTalk('Enfim, obrigado por jogar!'),
      setupFinalTalk('THE END'),
      setupFinalTalk(
          'Créditos: Desenvolvido por Natasha, Matheus, Iago, Marcos e Caio. Unimetrocamp 2020.')
    ], finish: () {
      (gameRef.player as MyPlayer).finished = true;
    });
  }

  Say setupIntroductionTalk(phrase) {
    return Say(
      phrase,
      Flame.util.animationAsWidget(
        Position(80, 100),
        FlameAnimation.Animation.sequenced(
          "npc/princess_idle_right.png",
          4,
          textureWidth: 16,
          textureHeight: 22,
        ),
      ),
      personDirection: PersonDirection.LEFT,
    );
  }

  Say setupFinalTalk(phrase) {
    return Say(
      phrase,
      Text(''),
      personDirection: PersonDirection.LEFT,
    );
  }

  Say setupPlayerTalk(phrase) {
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
}
