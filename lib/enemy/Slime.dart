import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/text_config.dart';
import  'package:faculhell/util/sound.dart';


class Slime extends SimpleEnemy {
  final Position initPosition;
  double attack = 10;

  Slime({
    @required this.initPosition,
  }) : super(
    animationIdleRight: FlameAnimation.Animation.sequenced(
      "enemy/slime_idle.png",
      10,
      textureWidth: 16,
      textureHeight: 16,
    ),
    animationIdleLeft: FlameAnimation.Animation.sequenced(
      "enemy/slime_idle.png",
      10,
      textureWidth: 16,
      textureHeight: 16,
    ),
    animationRunRight: FlameAnimation.Animation.sequenced(
      "enemy/slime_idle.png",
      10,
      textureWidth: 16,
      textureHeight: 16,
    ),
    animationRunLeft: FlameAnimation.Animation.sequenced(
      "enemy/slime_idle.png",
      10,
      textureWidth: 16,
      textureHeight: 16,
    ),
    initPosition: initPosition,
    width: 25,
    height: 25,
    speed: 145,
    life: 75,
    collision: Collision(
      width: 25,
      height: 25,
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
          "enemy/slime_dying.png",
          10,
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