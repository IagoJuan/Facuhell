import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:faculhell/decoration/chest.dart';
import 'package:faculhell/decoration/door_princess.dart';
import 'package:faculhell/decoration/key_princess.dart';
import 'package:faculhell/decoration/npc_2.dart';
import 'package:faculhell/decoration/potion_life.dart';
import 'package:faculhell/decoration/princess.dart';
import 'package:faculhell/decoration/red_flag.dart';
import 'package:faculhell/decoration/npc.dart';
import 'package:faculhell/decoration/barrel.dart';
import 'package:faculhell/decoration/big_table.dart';
import 'package:faculhell/decoration/bookshelf.dart';
import 'package:faculhell/decoration/coins.dart';
import 'package:faculhell/decoration/common_table.dart';
import 'package:faculhell/decoration/door.dart';
import 'package:faculhell/decoration/green_flag.dart';
import 'package:faculhell/decoration/prisoner.dart';
import 'package:faculhell/decoration/spikes.dart';
import 'package:faculhell/decoration/torch.dart';
import 'package:faculhell/decoration/wall_goo.dart';
import 'package:faculhell/decoration/key.dart';
import 'package:faculhell/enemy/Guardian.dart';
import 'package:faculhell/enemy/SlimeBoss.dart';
import 'package:faculhell/enemy/Slime.dart';
import 'package:faculhell/enemy/Knight.dart';
import 'package:faculhell/enemy/TrollBoss.dart';
import 'package:flame/position.dart';
import 'package:faculhell/decoration/first_dialogue_table.dart';

class FaculhellMap {
  static const int tileSize = 32;

  /// Top walls
  static const String wallTopMid = 'tile/wall_top_mid.png';
  static const String wallTopLeft = 'tile/wall_side_mid_left.png';
  static const String wallTopRight = 'tile/wall_side_mid_right.png';

  /// Mid Walls
  static const String wallMid = 'tile/wall_mid.png';
  static const String wallMidLeft = 'tile/wall_mid_left.png';
  static const String wallMidRight = 'tile/wall_mid_right.png';
  static const String wallMidLastLeft = 'tile/wall_corner_left.png';
  static const String wallMidLastRight = 'tile/wall_corner_right.png';

  /// Side walls
  static const String wallLeft = 'tile/wall_left.png';
  static const String wallRight = 'tile/wall_right.png';

  /// Bottom corner inners
  static const String bottomInnerLeft = 'tile/wall_corner_bottom_left.png';
  static const String bottomInnerRight = 'tile/wall_corner_bottom_right.png';

  /// Bottom walls
  static const String wallBottomOne = 'tile/wall_hole_1.png';
  static const String wallBottomTwo = 'tile/wall_hole_2.png';

  /// Flags
  static const String greenFlag = 'tile/wall_banner_green.png';
  static const String yellowFlag = 'tile/wall_banner_yellow.png';
  static const String redFlag = 'tile/wall_banner_red.png';
  static const String blueFlag = 'tile/wall_banner_blue.png';

  /// Column
  static const String columnBase = 'tile/column_base.png';
  static const String columnMid = 'tile/column_mid.png';
  static const String columnTop = 'tile/column_top.png';

  static Tile addTile(tile, x, y) {
    Tile tmp = (Tile(
      tile,
      Position(x.toDouble(), y.toDouble()),
    ));
    return tmp;
  }

  static Tile addTileWithC(tile, x, y) {
    Tile tmp = (Tile(
      tile,
      Position(x.toDouble(), y.toDouble()),
      collision: true,
    ));
    return tmp;
  }

  static MapWorld map() {
    List<List<Tile>> mundo = [];

    // essa fun adicionar em qualquer coordenadas x e y
    // um muro dessa forma =
    //
    // # # #
    // #
    // #

    void addWall(List<List<Tile>> w, x, y) {
      w[x][y] = addTileWithC(wallMid, x, y);
    }

    void addSalaInicial(List<List<Tile>> w, x, y) {
      int i = 0;
      for (i = 0; i < 17; i++) {
        if (i != 14 && i != 13)
          w[x + i][y] = addTileWithC(randomTile(), x + i, y);
      }

      for (i = 0; i < 17; i++) {
        w[x + i][y + 7] = addTileWithC(randomTile(), x + i, y + 7);
      }

      for (i = 1; i < 7; i++) {
        w[x][y + i] = addTileWithC(randomTile(), x, y + i);
      }

      for (i = 1; i < 7; i++) {
        w[x + 16][y + i] = addTileWithC(randomTile(), x + 16, y + i);
      }
    }

    void addCorredorV(List<List<Tile>> w, x, y) {
      int i;
      for (i = 0; i < 11; i++) {
        w[x][y - i] = addTileWithC(randomTile(), x, y - i);
        w[x + 5][y - i] = addTileWithC(randomTile(), x + 5, y - i);
      }
    }

    void addDiv(List<List<Tile>> w, x, y) {
      //w[x][y] = addTileWithC(wallMid, x, y);
      //w[x][y-1] = addTileWithC(wallMid, x, y-1);
      //w[x][y-2] = addTileWithC(wallMid, x, y-2);
      //w[x+1][y] = addTileWithC(wallMid, x+1, y);
      //w[x+2][y] = addTileWithC(wallMid, x+2, y);

      w[x + 7][y] = addTileWithC(wallMid, x + 7, y);
      w[x + 8][y] = addTileWithC(wallMid, x + 8, y);
      w[x + 9][y] = addTileWithC(wallMid, x + 9, y);
      w[x + 9][y - 1] = addTileWithC(wallMid, x + 9, y - 1);
      w[x + 9][y - 2] = addTileWithC(wallMid, x + 9, y - 2);

      int i;
      for (i = 0; i < 10; i++) {
        w[x + 2][y - i] = addTileWithC(wallMid, x + 2, y - i);
      }

      w[x + 9][y - 7] = addTileWithC(wallMid, x + 9, y - 7);
      w[x + 9][y - 8] = addTileWithC(wallMid, x + 9, y - 8);
      w[x + 9][y - 9] = addTileWithC(wallMid, x + 9, y - 9);
      w[x + 8][y - 9] = addTileWithC(wallMid, x + 8, y - 9);
      w[x + 7][y - 9] = addTileWithC(wallMid, x + 7, y - 9);

      //w[x+2][y-9] = addTileWithC(wallMid, x+2, y-9);
      //w[x+1][y-9] = addTileWithC(wallMid, x+1, y-9);
      //w[x][y-9] = addTileWithC(wallMid, x, y-9);
      //w[x][y-8] = addTileWithC(wallMid, x, y-8);
      //w[x][y-7] = addTileWithC(wallMid, x, y-7);
    }

    void addCorredorH(List<List<Tile>> w, x, y) {
      int i;
      for (i = 0; i < 16; i++) {
        w[x + i][y] = addTileWithC(randomTile(), x + i, y);
        w[x + i][y + 5] = addTileWithC(randomTile(), x + i, y + 5);
      }
    }

    void addParedeN(List<List<Tile>> w, x, y, n) {
      int i;
      for (i = 0; i < n; i++) {
        w[x][y - i] = addTileWithC(randomTile(), x, y - i);
      }
    }

    void addParedeS(List<List<Tile>> w, x, y, n) {
      int i;
      for (i = 0; i < n; i++) {
        w[x][y + i] = addTileWithC(randomTile(), x, y + i);
      }
    }

    void addParedeE(List<List<Tile>> w, x, y, n) {
      int i;
      for (i = 0; i < n; i++) {
        w[x + i][y] = addTileWithC(randomTile(), x + i, y);
      }
    }

    void addParedeO(List<List<Tile>> w, x, y, n) {
      int i;
      for (i = 0; i < n; i++) {
        w[x - i][y] = addTileWithC(randomTile(), x - i, y);
      }
    }

    void addSala02(List<List<Tile>> w, x, y) {
      int i;
      for (i = 0; i < 11; i++) {
        w[x + i][y] = addTileWithC(randomTile(), x + i, y);
        w[x + i][y + 15] = addTileWithC(randomTile(), x + i, y + 15);
      }
      for (i = 1; i < 15; i++) {
        w[x][y + i] = addTileWithC(randomTile(), x, y + i);
        w[x + 1][y + i] = addTileWithC(randomTile(), x + 1, y + i);

        if (i != 2 && i != 3) {
          w[x + 10][y + i] = addTileWithC(randomTile(), x + 10, y + i);
        }
      }
    }

    void addSala03(List<List<Tile>> w, x, y) {
      int i;
      for (i = 0; i < 5; i++) {
        w[x + i][y] = addTileWithC(randomTile(), x + i, y);
        w[x][y + i] = addTileWithC(randomTile(), x, y + i);
      }
      w[x + 1][y + 4] = addTileWithC(randomTile(), x + 1, y + 4);
      w[x + 4][y + 4] = addTileWithC(randomTile(), x + 4, y + 4);
    }

    void addSala04(List<List<Tile>> w, x, y) {
      int i;
      for (i = 0; i < 20; i++) {
        if (!(i >= 3 && i <= 6))
          w[x][y + i] = addTileWithC(randomTile(), x, y + i);
        w[x - 8][y + i] = addTileWithC(randomTile(), x - 8, y + i);
      }
      for (i = 1; i < 8; i++) {
        w[x - i][y] = addTileWithC(randomTile(), x - i, y);
        w[x - i][y + 19] = addTileWithC(randomTile(), x - i, y + 19);
      }
    }

    void addSala05(List<List<Tile>> w, x, y) {
      int i;
      for (i = 0; i < 18; i++) {
        w[x + i][y] = addTileWithC(randomTile(), x + i, y);
        w[x + i][y + 16] = addTileWithC(randomTile(), x + i, y + 16);
      }
      for (i = 1; i < 16; i++) {
        if (i != 3 && i != 4) {
          w[x][y + i] = addTileWithC(randomTile(), x, y + i);
          w[x + 17][y + i] = addTileWithC(randomTile(), x + 17, y + i);
        }
        w[x + 8][y + i] = addTileWithC(randomTile(), x + 8, y + i);
      }
    }

    void addSala06(List<List<Tile>> w, x, y) {
      int i;
      for (i = 0; i < 8; i++) {
        w[x + i][y] = addTileWithC(randomTile(), x + i, y);
        w[x + i][y + 12] = addTileWithC(randomTile(), x + i, y + 12);
      }
      for (i = 1; i < 12; i++) {
        if (i != 11 && i != 10)
          w[x][y + i] = addTileWithC(randomTile(), x, y + i);
        w[x + 7][y + i] = addTileWithC(randomTile(), x + 7, y + i);
      }
    }

    void addSala07(List<List<Tile>> w, x, y) {
      int i;
      for (i = 0; i < 16; i++) {
        if (!(i >= 4 && i <= 6))
          w[x + i][y] = addTileWithC(randomTile(), x + i, y);
        if (!(i >= 9 && i <= 11))
          w[x + i][y + 10] = addTileWithC(randomTile(), x + i, y + 10);
      }
      for (i = 1; i < 10; i++) {
        w[x][y + i] = addTileWithC(randomTile(), x, y + i);
        w[x + 15][y + i] = addTileWithC(randomTile(), x + 15, y + i);
      }
    }

    // inicia o mundo e adiciona o chão no mesmo
    for (int x = 0; x < 100; x++) {
      List<Tile> ltile = [];
      for (int y = 0; y < 100; y++) {
        ltile.add(addTile(randomFloor(), x, y));
      }
      mundo.add(ltile);
    }

    //addWall(mundo, 51, 70);
    addSalaInicial(mundo, 38, 90);
    addCorredorV(mundo, 49, 89);
    addDiv(mundo, 47, 78);
    addCorredorH(mundo, 56, 71);
    addParedeN(mundo, 71, 70, 4);
    addParedeE(mundo, 71, 66, 20);
    addSala02(mundo, 76, 71);
    addParedeS(mundo, 90, 71, 19);
    addParedeO(mundo, 75, 86, 9);
    addParedeE(mundo, 67, 81, 5);
    addParedeN(mundo, 71, 80, 4);
    addParedeE(mundo, 87, 90, 4);
    addParedeS(mundo, 86, 90, 8);

    addSala03(mundo, 81, 90);
    addSala03(mundo, 76, 90);
    addSala03(mundo, 71, 90);

    addParedeO(mundo, 86, 98, 20);

    addSala04(mundo, 66, 79);

    //       nessa sala que ficara a saida da Dungeon
    addParedeS(mundo, 94, 71, 20);
    addParedeS(mundo, 90, 91, 5);
    addParedeE(mundo, 91, 95, 8);
    addParedeN(mundo, 98, 94, 5);

    addParedeN(mundo, 90, 65, 9);
    addParedeN(mundo, 94, 65, 9);
    addParedeS(mundo, 94, 66, 5);
    addWall(mundo, 97, 90);

    // parte de cima
    addCorredorV(mundo, 49, 68);
    addParedeO(mundo, 48, 58, 9);
    addParedeE(mundo, 55, 58, 12);
    addParedeN(mundo, 40, 57, 21);

    addSala05(mundo, 45, 37);

    addParedeN(mundo, 67, 58, 9);
    addSala06(mundo, 67, 37);

    addParedeE(mundo, 40, 33, 30); //
    addParedeS(mundo, 40, 34, 3);
    addParedeE(mundo, 70, 33, 20);
    addParedeE(mundo, 75, 37, 11);
    addParedeS(mundo, 85, 38, 8);
    addParedeS(mundo, 89, 34, 12);

    addSala07(mundo, 82, 46);
    addWall(mundo, 86, 46);
    addWall(mundo, 91, 56);
    addWall(mundo, 91, 90);
    //82  46
    //addWall(mundo, 98, 94);

    //   40 ,  88

    List<Tile> res;

    res = mundo[0];
    for (int i = 1; i < mundo.length; i++) res += mundo[i];

    return MapWorld(res);
  }

  static List<GameDecoration> decorations() {
    return [
      Barrel(getRelativeTilePosition(52, 73)),
      Barrel(getRelativeTilePosition(53, 73)),
      Barrel(getRelativeTilePosition(52, 74)),
      Barrel(getRelativeTilePosition(53, 74)),

      Torch(getRelativeTilePosition(55, 69)),
      Torch(getRelativeTilePosition(55, 78)),
      Torch(getRelativeTilePosition(49, 74)),

      // sala acima do X lado A
      BigTable(getRelativeTilePosition(47, 38)),
      Bookshelf(getRelativeTilePosition(51, 38)),
      Bookshelf(getRelativeTilePosition(52, 38)),
      Torch(getRelativeTilePosition(47, 37)),
      Torch(getRelativeTilePosition(51, 37)),
      CommonTable(getRelativeTilePosition(52, 42)),
      Torch(getRelativeTilePosition(47, 53)),
      Torch(getRelativeTilePosition(51, 53)),
      //WallGoo(getRelativeTilePosition(46, 53)),
      //Coins(getRelativeTilePosition(46, 47)),
      Bookshelf(getRelativeTilePosition(46, 47)),
      Bookshelf(getRelativeTilePosition(47, 47)),
      Bookshelf(getRelativeTilePosition(48, 47)),
      Bookshelf(getRelativeTilePosition(49, 47)),
      Chest(getRelativeTilePosition(47, 40)),
      Chest(getRelativeTilePosition(55, 43)),
      CommonTable(getRelativeTilePosition(46, 50)),
      Torch(getRelativeTilePosition(53, 45)),
      Torch(getRelativeTilePosition(45, 45)),

      // lado b
      Torch(getRelativeTilePosition(62, 45)),
      Torch(getRelativeTilePosition(60, 53)),
      Torch(getRelativeTilePosition(55, 53)),
      Torch(getRelativeTilePosition(55, 37)),
      Torch(getRelativeTilePosition(60, 37)),

      BigTable(getRelativeTilePosition(54, 49)),
      BigTable(getRelativeTilePosition(60, 49)),
      Coins(getRelativeTilePosition(61, 51)),
      Bookshelf(getRelativeTilePosition(55, 38)),
      Bookshelf(getRelativeTilePosition(56, 38)),
      Bookshelf(getRelativeTilePosition(59, 38)),
      Bookshelf(getRelativeTilePosition(54, 42)),
      Bookshelf(getRelativeTilePosition(55, 42)),
      Bookshelf(getRelativeTilePosition(56, 42)),
      Bookshelf(getRelativeTilePosition(59, 44)),
      Bookshelf(getRelativeTilePosition(60, 44)),
      Bookshelf(getRelativeTilePosition(61, 44)),

      // armazem
      Barrel(getRelativeTilePosition(73, 48)),
      Barrel(getRelativeTilePosition(73, 47)),
      Barrel(getRelativeTilePosition(72, 48)),
      Barrel(getRelativeTilePosition(68, 38)),
      Barrel(getRelativeTilePosition(69, 38)),
      Barrel(getRelativeTilePosition(70, 38)),
      Barrel(getRelativeTilePosition(68, 39)),
      Barrel(getRelativeTilePosition(69, 39)),
      Barrel(getRelativeTilePosition(68, 40)),

      Barrel(getRelativeTilePosition(68, 46)),
      Barrel(getRelativeTilePosition(69, 46)),
      Barrel(getRelativeTilePosition(68, 45)),
      Barrel(getRelativeTilePosition(69, 45)),

      Barrel(getRelativeTilePosition(73, 43)),
      Barrel(getRelativeTilePosition(73, 42)),
      Barrel(getRelativeTilePosition(73, 44)),

      Torch(getRelativeTilePosition(72, 49)),
      Torch(getRelativeTilePosition(69, 49)),
      Torch(getRelativeTilePosition(72, 37)),
      Torch(getRelativeTilePosition(69, 37)),
      Torch(getRelativeTilePosition(67, 44)),

      CommonTable(getRelativeTilePosition(73, 38)),

      // sala inicial

      Torch(getRelativeTilePosition(38, 95)),
      Torch(getRelativeTilePosition(38, 92)),
      Torch(getRelativeTilePosition(49, 97)),

      FirstDialogueTable(getRelativeTilePosition(40, 91)),

      Coins(getRelativeTilePosition(43, 96)),
      Coins(getRelativeTilePosition(44, 96)),
      GreenFlag(getRelativeTilePosition(44, 90)),
      RedFlag(getRelativeTilePosition(43, 90)),
      BigTable(getRelativeTilePosition(52, 96)),
      CommonTable(getRelativeTilePosition(53, 94)),

      // Corredor
      Torch(getRelativeTilePosition(49, 89)),
      Torch(getRelativeTilePosition(54, 89)),

      // sala de npc
      Torch(getRelativeTilePosition(66, 94)),
      Torch(getRelativeTilePosition(58, 94)),
      Torch(getRelativeTilePosition(66, 81)),
      Torch(getRelativeTilePosition(66, 86)),

      BigTable(getRelativeTilePosition(64, 92)),

      Bookshelf(getRelativeTilePosition(62, 95)),
      Bookshelf(getRelativeTilePosition(62, 96)),
      Bookshelf(getRelativeTilePosition(62, 97)),

      CommonTable(getRelativeTilePosition(60, 80)),
      CommonTable(getRelativeTilePosition(63, 80)),
      Coins(getRelativeTilePosition(59, 85)),

      // salas dos prisonerios
      RedFlag(getRelativeTilePosition(72, 94)),
      RedFlag(getRelativeTilePosition(75, 94)),
      RedFlag(getRelativeTilePosition(77, 94)),
      RedFlag(getRelativeTilePosition(80, 94)),
      RedFlag(getRelativeTilePosition(82, 94)),
      RedFlag(getRelativeTilePosition(85, 94)),

      Prisoner(getRelativeTilePosition(72, 91)),
      Prisoner(getRelativeTilePosition(75, 91)),
      Prisoner(getRelativeTilePosition(78, 91)),
      Prisoner(getRelativeTilePosition(85, 91)),
      Coins(getRelativeTilePosition(75, 93)),
      WallGoo(getRelativeTilePosition(83, 90)),

      Torch(getRelativeTilePosition(74, 98)),
      Torch(getRelativeTilePosition(79, 98)),
      Torch(getRelativeTilePosition(84, 98)),

      Spikes(getRelativeTilePosition(67, 93)),
      Spikes(getRelativeTilePosition(68, 93)),
      Spikes(getRelativeTilePosition(69, 93)),
      Spikes(getRelativeTilePosition(70, 93)),
      Spikes(getRelativeTilePosition(71, 95)),
      Spikes(getRelativeTilePosition(71, 96)),
      Spikes(getRelativeTilePosition(71, 97)),

      // sala da Slimes
      Torch(getRelativeTilePosition(79, 86)),
      Torch(getRelativeTilePosition(84, 86)),
      Torch(getRelativeTilePosition(79, 71)),
      Torch(getRelativeTilePosition(84, 71)),
      Torch(getRelativeTilePosition(77, 75)),
      Torch(getRelativeTilePosition(77, 80)),
      Torch(getRelativeTilePosition(86, 75)),
      Torch(getRelativeTilePosition(86, 80)),
      CommonTable(getRelativeTilePosition(79, 76)),
      CommonTable(getRelativeTilePosition(84, 76)),
      CommonTable(getRelativeTilePosition(79, 81)),
      CommonTable(getRelativeTilePosition(84, 81)),
      Coins(getRelativeTilePosition(78, 83)),
      Coins(getRelativeTilePosition(78, 84)),
      Coins(getRelativeTilePosition(85, 78)),

      // sala do Boss
      Coins(getRelativeTilePosition(85, 53)),
      Coins(getRelativeTilePosition(86, 53)),
      Coins(getRelativeTilePosition(85, 54)),
      Coins(getRelativeTilePosition(86, 54)),

      Coins(getRelativeTilePosition(91, 48)),
      Coins(getRelativeTilePosition(92, 48)),
      Coins(getRelativeTilePosition(93, 48)),
      Prisoner(getRelativeTilePosition(95, 47)),

      RedFlag(getRelativeTilePosition(82, 50)),
      RedFlag(getRelativeTilePosition(97, 50)),
      RedFlag(getRelativeTilePosition(85, 46)),
      RedFlag(getRelativeTilePosition(89, 46)),
      RedFlag(getRelativeTilePosition(90, 56)),
      RedFlag(getRelativeTilePosition(94, 56)),

      Bookshelf(getRelativeTilePosition(96, 53)),
      Bookshelf(getRelativeTilePosition(96, 54)),
      Bookshelf(getRelativeTilePosition(96, 55)),

      Barrel(getRelativeTilePosition(89, 51)),
      Barrel(getRelativeTilePosition(90, 51)),
      Barrel(getRelativeTilePosition(91, 51)),
      Barrel(getRelativeTilePosition(89, 52)),
      Barrel(getRelativeTilePosition(90, 52)),
      Barrel(getRelativeTilePosition(91, 52)),

      Torch(getRelativeTilePosition(95, 56)),
      Torch(getRelativeTilePosition(86, 56)),
      Torch(getRelativeTilePosition(93, 46)),
      Torch(getRelativeTilePosition(84, 46)),
      Torch(getRelativeTilePosition(82, 51)),
      Torch(getRelativeTilePosition(97, 51)),

      // sala final
      Torch(getRelativeTilePosition(90, 90)),
      Torch(getRelativeTilePosition(94, 90)),
      Torch(getRelativeTilePosition(94, 95)),

      Barrel(getRelativeTilePosition(91, 94)),
      //Door(getRelativeTilePosition(95, 89)),

      // Itens e NPCs
      Npc(getRelativeTilePosition(50, 57)),
      PotionLife(getRelativeTilePosition(49, 51), 5.0),
      PotionLife(getRelativeTilePosition(78, 92), 5.0),
      PotionLife(getRelativeTilePosition(72, 92), 5.0),
      //PrincessKey(getRelativeTilePosition(95, 51)),
      BossKey(getRelativeTilePosition(83, 92)),
      Npc2(getRelativeTilePosition(85, 69)),
      //PRINCESS
      Princess(getRelativeTilePosition(94, 93)),

      // DOORS
      //BossDoor(getRelativeTilePosition(86, 46)),
      BossDoor(getRelativeTilePosition(87, 45)),
      //BossDoor(getRelativeTilePosition(88, 46)),

      //BossDoor(getRelativeTilePosition(91, 56)),
      BossDoor(getRelativeTilePosition(92, 55)),
      //BossDoor(getRelativeTilePosition(93, 56)),

      PrincessDoor(getRelativeTilePosition(92, 89)),
    ];
  }

  // TODO
  static List<Enemy> enemies() {
    return [
      Slime(initPosition: getRelativeTilePosition(71, 40)),
      //Goblin(initPosition: getRelativeTilePosition(25, 6)),
      Slime(initPosition: getRelativeTilePosition(52, 76)),
      // Primeiro slime no corredor

      Slime(initPosition: getRelativeTilePosition(50, 35)),
      Slime(initPosition: getRelativeTilePosition(79, 34)),
      TrollBoss(initPosition: getRelativeTilePosition(93, 51)),

      Slime(initPosition: getRelativeTilePosition(80, 75)),
      Slime(initPosition: getRelativeTilePosition(81, 76)),
      Knight(initPosition: getRelativeTilePosition(57, 39)),
    ];
  }

  static String randomFloor() {
    int p = Random().nextInt(6);
    String sprite = "";
    switch (p) {
      case 0:
        sprite = 'tile/floor_1.png';
        break;
      case 1:
        sprite = 'tile/floor_2.png';
        break;
      case 2:
        sprite = 'tile/floor_3.png';
        break;
      case 3:
        sprite = 'tile/floor_4.png';
        break;
      case 4:
        sprite = 'tile/floor_1.png';
        break;
      case 5:
        sprite = 'tile/floor_6.png';
        break;
    }
    return sprite;
  }

  static String randomTile() {
    int p = Random().nextInt(100);
    String res = wallMid;
    if (p >= 80 && p <= 89) {
      res = wallBottomOne;
    }
    if (p >= 90) {
      res = wallBottomTwo;
    }
    return res;
  }

  static Position getRelativeTilePosition(int x, int y) {
    return Position(
      (x * tileSize).toDouble(),
      (y * tileSize).toDouble(),
    );
  }
}
