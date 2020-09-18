import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/text_config.dart';
import  'package:faculhell/util/sound.dart';

class Guardian extends SimpleEnemy {
  final Position initPosition;
  double attack = 25;

  Guardian({
    @required this.initPosition,
  }) : super(
    animationIdleRight: FlameAnimation.Animation.sequenced(
      "enemy/ForestGuardian_Idle_right.png",
      4,
      textureWidth: 32,
      textureHeight: 32,
    ),
    animationIdleLeft: FlameAnimation.Animation.sequenced(
      "enemy/ForestGuardian_Idle_left.png",
      4,
      textureWidth: 32,
      textureHeight: 32,
    ),
    animationRunRight: FlameAnimation.Animation.sequenced(
      "enemy/ForestGuardian_walk_right.png",
      4,
      textureWidth: 32,
      textureHeight: 32,
    ),
    animationRunLeft: FlameAnimation.Animation.sequenced(
      "enemy/ForestGuardian_walk_left.png",
      4,
      textureWidth: 32,
      textureHeight: 32,
    ),
    initPosition: initPosition,
    width: 48,
    height: 48,
    speed: 1.0,
    life: 200,
    collision: Collision(
      width: 16,
      height: 20,
      align: CollisionAlign.CENTER,
    ),
  );

  @override
  void render(Canvas canvas) {
    this.drawDefaultLifeBar(canvas);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    this.seeAndMoveToPlayer(
      closePlayer: (player) {
        execAttack();
      },
      visionCells: 4,
    );
  }



  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: FlameAnimation.Animation.sequenced(
          "smoke_explosion.png",
          6,
          textureWidth: 16,
          textureHeight: 16,
        ),
        position: position,
      ),
    );
    remove();
    super.die();
  }

  void execAttack() {
    this.simpleAttackMelee(
      heightArea: 20,
      widthArea: 20,
      damage: attack,
      interval: 800,
      attackEffectBottomAnim: FlameAnimation.Animation.sequenced(
        'enemy/attack_effect_bottom.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectLeftAnim: FlameAnimation.Animation.sequenced(
        'enemy/attack_effect_left.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectRightAnim: FlameAnimation.Animation.sequenced(
        'enemy/attack_effect_right.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      attackEffectTopAnim: FlameAnimation.Animation.sequenced(
        'enemy/attack_effect_top.png',
        6,
        textureWidth: 16,
        textureHeight: 16,
      ),
      execute: (){
    Sound.attackEnemyMelee();

      }
    );
  }

  @override
  void receiveDamage(double damage, int id) {
    this.showDamage(
      damage,
      config: TextConfig(
        fontSize: 10,
        color: Colors.white,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(damage, id);
  }
}