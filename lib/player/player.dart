import 'dart:async';
import 'package:faculhell/map/faculhell_map.dart';
import 'package:flame/position.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:faculhell/util/sound.dart';
import 'package:flutter/material.dart';
import 'package:flame/text_config.dart';
import 'package:bonfire/util/collision/collision.dart';

import '../menu.dart';

class MyPlayer extends SimplePlayer with WithLighting {
  final Position initPosition;
  double attack = 20;
  double stamina = 100;
  double initSpeed = 135;
  IntervalTick _timerStamina = IntervalTick(100);
  IntervalTick _timerAttackRange = IntervalTick(100);
  IntervalTick _timerSeeEnemy = IntervalTick(500);
  bool showObserveEnemy = false;
  bool showTalk = false;
  double angleRadAttack = 0.0;
  Rect rectDirectionAttack;
  Sprite spriteDirectionAttack;
  bool showDirection = false;
  bool containKey = false;
  bool containKeyPrincess = false;
  bool openedFirst = false;
  bool finished = false;
  bool firstSlime = true;

  MyPlayer({
    this.initPosition,
  }) : super(
            animIdleLeft: FlameAnimation.Animation.sequenced(
              "player/player_idle_left.png",
              4,
              textureWidth: 32,
              textureHeight: 32,
            ),
            animIdleRight: FlameAnimation.Animation.sequenced(
              "player/player_idle_right.png",
              4,
              textureWidth: 32,
              textureHeight: 32,
            ),
            animRunRight: FlameAnimation.Animation.sequenced(
              "player/player_run_right.png",
              4,
              textureWidth: 32,
              textureHeight: 32,
            ),
            animRunLeft: FlameAnimation.Animation.sequenced(
              "player/player_run_left.png",
              4,
              textureWidth: 32,
              textureHeight: 32,
            ),
            width: 48,
            height: 48,
            initPosition: initPosition,
            life: 200,
            speed: 12,
            collision: Collision(width: 20, height: 16)) {
    spriteDirectionAttack = Sprite('direction_attack.png');
    lightingConfig = LightingConfig(
      gameComponent: this,
      radius: width * 1.5,
      blurBorder: width / 2,
    );
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    this.speed = initSpeed * event.intensity;
    super.joystickChangeDirectional(event);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (isDead) return;

    if (event.id == 0 && event.event == ActionEvent.DOWN) {
      Sound.attackPlayerMelee();
      actionAttack();
    }

    if (event.id == 1) {
      if (event.event == ActionEvent.MOVE) {
        decrementStamina(2);
        showDirection = true;
        angleRadAttack = event.radAngle;
        if (_timerAttackRange.update(dtUpdate)) actionAttackRange();
      }
      if (event.event == ActionEvent.UP) {
        Sound.attackRange();
        showDirection = false;
        actionAttackRange();
      }
    }

    super.joystickAction(event);
  }

  @override
  void die() {
    remove();
    gameRef.addDecoration(
      GameDecoration(
        initPosition: Position(
          position.center.dx,
          position.center.dy,
        ),
        height: 30,
        width: 30,
        sprite: Sprite('player/crypt.png'),
      ),
    );
    Sound.stopBackgroundSound();
    super.die();
  }

  void actionAttack() {
    if (stamina < 15) return;

    decrementStamina(15);
    this.simpleAttackMelee(
      damage: attack,
      animationBottom: FlameAnimation.Animation.sequenced(
        'player/attack_effect_bottom.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationLeft: FlameAnimation.Animation.sequenced(
        'player/attack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationRight: FlameAnimation.Animation.sequenced(
        'player/attack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      animationTop: FlameAnimation.Animation.sequenced(
        'player/attack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      heightArea: 45,
      widthArea: 45,
    );
  }

  void actionAttackRange() {
    if (stamina < 2) return;

//    decrementStamina(10);

    this.simpleAttackRangeByAngle(
      animationTop: FlameAnimation.Animation.sequenced(
        'player/fireball_top.png',
        3,
        textureWidth: 23,
        textureHeight: 23,
      ),
      animationDestroy: FlameAnimation.Animation.sequenced(
        'player/explosion_fire.png',
        6,
        textureWidth: 32,
        textureHeight: 32,
      ),
      destroy: () => Sound.explosion(),
      radAngleDirection: angleRadAttack,
      width: width * 0.7,
      height: width * 0.7,
      damage: 5,
      speed: initSpeed * 2,
      lightingConfig: LightingConfig(
        gameComponent: this,
        radius: 25,
        blurBorder: 15,
      ),
    );
  }

  @override
  void render(Canvas c) {
    if (showDirection) {
      double radius = position.height;
      rectDirectionAttack = Rect.fromLTWH(position.center.dx - radius,
          position.center.dy - radius, radius * 2, radius * 2);
      renderSpriteByRadAngle(
        c,
        angleRadAttack,
        rectDirectionAttack,
        spriteDirectionAttack,
      );
    }
    super.render(c);
  }

  void _verifyStamina(double dt) {
    if (_timerStamina.update(dt) && stamina < 100) {
      stamina += 2;
      if (stamina > 100) {
        stamina = 100;
      }
    }
  }

  void decrementStamina(int i) {
    stamina -= i;
    if (stamina < 0) {
      stamina = 0;
    }
  }

  @override
  void receiveDamage(double damage, int from) {
    this.showDamage(damage);
    super.receiveDamage(damage, from);
  }

  Say setupIntroductionTalk(phrase) {
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

  void slimeTalk() {
    TalkDialog.show(
      gameRef.context,
      [
        setupIntroductionTalk('Olha aquele bichinho azul, tão fofinho!'),
        setupIntroductionTalk(
            'Mas esse botão de espada na tela não deve ser atoa...'),
        setupIntroductionTalk(
            'Provavelmente tenho que exterminar aquela coisinha antes que ela o faça'),
        setupIntroductionTalk('Será que se eu matá-lo com fogo dá pra comer?'),
      ],
    );
  }

  @override
  void update(double dt) {
    if (this.finished){
      Future.delayed(Duration(seconds: 1), () {
        if (this.animation != null) {
          print("animation nao eh nulo");
        }
        Sound.stopBackgroundSound();
        Navigator.of(gameRef.context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Menu()),
              (Route<dynamic> route) => false,
        );
      });
    }

    if (this.isDead || gameRef?.size == null) return;
    _verifyStamina(dt);

    //print(gameRef.player.positionInWorld.top);
    if (firstSlime && gameRef.player.position.top < 2549) {
      firstSlime = false;
      slimeTalk();
    }

    if (_timerSeeEnemy.update(dt)) {
      this.seeEnemy(
          visionCells: 3,
          notObserved: () {
            showObserveEnemy = false;
          },
          observed: (enemies) {
            if (showObserveEnemy) return;
            showObserveEnemy = true;
            _showEmote();
          });
    }
    super.update(dt);
  }

  void _showEmote({String emote = 'player/emote_exclamacao.png'}) {
    gameRef.add(
      AnimatedFollowerObject(
        animation: FlameAnimation.Animation.sequenced(
          emote,
          8,
          textureWidth: 32,
          textureHeight: 32,
        ),
        target: this,
        width: 16,
        height: 16,
        positionFromTarget: Position(18, -6),
      ),
    );
  }
}
