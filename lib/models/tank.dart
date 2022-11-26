import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DirectionTower { up, right, left, down }

enum DirectionBody { up, right, left, down }

enum Drive {
  ahead,
  aback,
}

enum Direction {
  right,
  left,
}

class Bullet with ChangeNotifier {
  int positionShotInGridView;
  String urlShot;
  DirectionTower directionBullet;
  Bullet(
    this.positionShotInGridView,
    this.urlShot,
    this.directionBullet,
  ) {
    fly();
  }
  // ТОЧКА НЕВОЗВРАТА
  void fly() {
    switch (directionBullet) {
      case DirectionTower.up:
        positionShotInGridView =
            positionShotInGridView - GameSession.countColRow;
        break;
      case DirectionTower.down:
        positionShotInGridView =
            positionShotInGridView + GameSession.countColRow;
        break;
      case DirectionTower.right:
        int x = positionShotInGridView % GameSession.countColRow;
        if (x < GameSession.countColRow - 1) {
          positionShotInGridView = positionShotInGridView + 1;
        } else {
          positionShotInGridView = 1000;
        }
        break;
      case DirectionTower.left:
        int x = positionShotInGridView % GameSession.countColRow;
        if (x > 0) {
          positionShotInGridView = positionShotInGridView - 1;
        } else {
          positionShotInGridView = 1000;
        }
        break;
    }
    Timer(Duration(milliseconds: 300), () {
      fly();
    });
  }
}

class Tank with ChangeNotifier {
  int x;
  int y;
  int positionInGridView = 0;
  DirectionBody currentDirectionBody = DirectionBody.up;
  DirectionTower currentDirectionTower = DirectionTower.up;
  List<Bullet> listBullet = [];
  int speed;
  String urlBody;
  String urlTower;
  String urlShot;

  Tank({
    required this.x,
    required this.y,
    required this.urlBody,
    required this.urlTower,
    required this.urlShot,
    required this.speed,
  });

  void drive(Drive direction) {
    switch (currentDirectionBody) {
      case DirectionBody.up:
        if (direction == Drive.ahead) {
          y = y > 1 ? y - 1 : y;
          positionInGridView = x - 1 + ((y - 1) * GameSession.countColRow);
        } else {
          y = y < GameSession.countColRow ? y + 1 : y;
          positionInGridView = x - 1 + ((y - 1) * GameSession.countColRow);
        }
        break;
      case DirectionBody.down:
        if (direction == Drive.ahead) {
          y = y < GameSession.countColRow ? y + 1 : y;
          positionInGridView = x - 1 + ((y - 1) * GameSession.countColRow);
        } else {
          y = y > 1 ? y - 1 : y;
          positionInGridView = x - 1 + ((y - 1) * GameSession.countColRow);
        }
        break;
      case DirectionBody.right:
        if (direction == Drive.ahead) {
          x = x < GameSession.countColRow ? x + 1 : x;
          positionInGridView = y - 1 + ((x - 1) * GameSession.countColRow);
        } else {
          x = x > 1 ? x - 1 : x;
          positionInGridView = y - 1 + ((x - 1) * GameSession.countColRow);
        }
        break;
      case DirectionBody.left:
        if (direction == Drive.ahead) {
          x = x > 1 ? x - 1 : x;
          positionInGridView = y - 1 + ((x - 1) * GameSession.countColRow);
        } else {
          x = x < GameSession.countColRow ? x + 1 : x;
          positionInGridView = y - 1 + ((x - 1) * GameSession.countColRow);
        }
        break;
    }
  }

  void turnBody(Direction direction) {
    switch (direction) {
      case Direction.right:
        if (currentDirectionBody == DirectionBody.up) {
          currentDirectionBody = DirectionBody.right;
          urlBody = "assets/images/first_tank/Hull_01_right.png";
        } else if (currentDirectionBody == DirectionBody.right) {
          currentDirectionBody = DirectionBody.down;
          urlBody = "assets/images/first_tank/Hull_01_down.png";
        } else if (currentDirectionBody == DirectionBody.down) {
          currentDirectionBody = DirectionBody.left;
          urlBody = "assets/images/first_tank/Hull_01_left.png";
        } else {
          currentDirectionBody = DirectionBody.up;
          urlBody = "assets/images/first_tank/Hull_01_up.png";
        }
        turnTower(Direction.right);
        break;
      case Direction.left:
        if (currentDirectionBody == DirectionBody.up) {
          currentDirectionBody = DirectionBody.left;
          urlBody = "assets/images/first_tank/Hull_01_left.png";
        } else if (currentDirectionBody == DirectionBody.right) {
          currentDirectionBody = DirectionBody.up;
          urlBody = "assets/images/first_tank/Hull_01_up.png";
        } else if (currentDirectionBody == DirectionBody.down) {
          currentDirectionBody = DirectionBody.right;
          urlBody = "assets/images/first_tank/Hull_01_right.png";
        } else {
          currentDirectionBody = DirectionBody.down;
          urlBody = "assets/images/first_tank/Hull_01_down.png";
        }
        turnTower(Direction.left);
        break;
    }
  }

  void turnTower(Direction direction) {
    switch (direction) {
      case Direction.right:
        if (currentDirectionTower == DirectionTower.up) {
          currentDirectionTower = DirectionTower.right;
          urlTower = "assets/images/first_tank/Gun_01_right.png";
          urlShot = "assets/images/shot/Heavy_Shell_right.png";
        } else if (currentDirectionTower == DirectionTower.right) {
          currentDirectionTower = DirectionTower.down;
          urlTower = "assets/images/first_tank/Gun_01_down.png";
          urlShot = "assets/images/shot/Heavy_Shell_down.png";
        } else if (currentDirectionTower == DirectionTower.down) {
          currentDirectionTower = DirectionTower.left;
          urlTower = "assets/images/first_tank/Gun_01_left.png";
          urlShot = "assets/images/shot/Heavy_Shell_left.png";
        } else {
          currentDirectionTower = DirectionTower.up;
          urlTower = "assets/images/first_tank/Gun_01_up.png";
          urlShot = "assets/images/shot/Heavy_Shell_up.png";
        }
        break;
      case Direction.left:
        if (currentDirectionTower == DirectionTower.up) {
          currentDirectionTower = DirectionTower.left;
          urlTower = "assets/images/first_tank/Gun_01_left.png";
          urlShot = "assets/images/shot/Heavy_Shell_left.png";
        } else if (currentDirectionTower == DirectionTower.right) {
          currentDirectionTower = DirectionTower.up;
          urlTower = "assets/images/first_tank/Gun_01_up.png";
          urlShot = "assets/images/shot/Heavy_Shell_up.png";
        } else if (currentDirectionTower == DirectionTower.down) {
          currentDirectionTower = DirectionTower.right;
          urlTower = "assets/images/first_tank/Gun_01_right.png";
          urlShot = "assets/images/shot/Heavy_Shell_right.png";
        } else {
          currentDirectionTower = DirectionTower.down;
          urlTower = "assets/images/first_tank/Gun_01_down.png";
          urlShot = "assets/images/shot/Heavy_Shell_down.png";
        }
        break;
    }
  }

  void shooting() {
    int positionShotInGridView = 0;
    switch (currentDirectionTower) {
      case DirectionTower.up:
        positionShotInGridView = positionInGridView - GameSession.countColRow;
        break;
      case DirectionTower.down:
        positionShotInGridView = positionInGridView + GameSession.countColRow;
        break;
      case DirectionTower.right:
        if (x != GameSession.countColRow) {
          positionShotInGridView = positionInGridView + 1;
        }
        break;
      case DirectionTower.left:
        if (x != 1) {
          positionShotInGridView = positionInGridView - 1;
        }
        break;
    }
    if (positionShotInGridView > 0 &&
        positionShotInGridView <
            GameSession.countColRow * GameSession.countColRow) {
      listBullet
          .add(Bullet(positionShotInGridView, urlShot, currentDirectionTower));
    }
  }

  void clearBullet() {
    for (int i = 0; i < listBullet.length; i++) {
      int position = listBullet[i].positionShotInGridView;

      if (position < 0 &&
          position > GameSession.countColRow * GameSession.countColRow) {
        listBullet.removeAt(i);
      }
    }
  }

  void aiTank() {
    Random rnd = Random();
    int rndNumFirst = rnd.nextInt(4);
    int rndNumSecond = rnd.nextInt(2);
    Direction direction;
    Drive dirDrive;
    switch (rndNumFirst) {
      case 0:
        (rndNumSecond == 0) ? dirDrive = Drive.aback : dirDrive = Drive.ahead;
        drive(dirDrive);
        break;
      case 1:
        (rndNumSecond == 0)
            ? direction = Direction.left
            : direction = Direction.right;
        turnBody(direction);
        break;
      case 2:
        (rndNumSecond == 0)
            ? direction = Direction.left
            : direction = Direction.right;
        turnTower(direction);
        break;
      case 3:
        shooting();
        break;
    }
    Timer(Duration(milliseconds: speed), () {
      aiTank();
    });
  }
}

List<int> clearList = [];

class GameSession with ChangeNotifier {
  late List<int> gameField;
  late List<Tank> players;
  List<int> winTanks = [0, 0, 0, 0];
  static int countColRow = 5;
  GameSession() {
    players = [
      Tank(
          x: 1,
          y: 5,
          urlBody: "assets/images/first_tank/Hull_01_up.png",
          urlTower: 'assets/images/first_tank/Gun_01_up.png',
          urlShot: "assets/images/shot/Heavy_Shell_up.png",
          speed: 1500),
      Tank(
          x: 5,
          y: 5,
          urlBody: "assets/images/first_tank/Hull_01_up.png",
          urlTower: 'assets/images/first_tank/Gun_01_up.png',
          urlShot: "assets/images/shot/Heavy_Shell_up.png",
          speed: 1000),
      Tank(
          x: 5,
          y: 1,
          urlBody: "assets/images/first_tank/Hull_01_up.png",
          urlTower: 'assets/images/first_tank/Gun_01_up.png',
          urlShot: "assets/images/shot/Heavy_Shell_up.png",
          speed: 2000),
      Tank(
        x: 1,
        y: 1,
        urlBody: "assets/images/first_tank/Hull_01_up.png",
        urlTower: 'assets/images/first_tank/Gun_01_up.png',
        urlShot: "assets/images/shot/Heavy_Shell_up.png",
        speed: 500,
      ),
    ];
    gameField = List.generate(countColRow * countColRow, (int index) {
      return -1;
    }, growable: false);
    for (var element in players) {
      element.positionInGridView =
          element.x - 1 + ((element.y - 1) * GameSession.countColRow);
      gameField[element.positionInGridView] = element.positionInGridView;
    }
  }

  void startSession() {
    players = [
      Tank(
          x: 1,
          y: 5,
          urlBody: "assets/images/first_tank/Hull_01_up.png",
          urlTower: 'assets/images/first_tank/Gun_01_up.png',
          urlShot: "assets/images/shot/Heavy_Shell_up.png",
          speed: 1500),
      Tank(
          x: 5,
          y: 5,
          urlBody: "assets/images/first_tank/Hull_01_up.png",
          urlTower: 'assets/images/first_tank/Gun_01_up.png',
          urlShot: "assets/images/shot/Heavy_Shell_up.png",
          speed: 1000),
      Tank(
          x: 5,
          y: 1,
          urlBody: "assets/images/first_tank/Hull_01_up.png",
          urlTower: 'assets/images/first_tank/Gun_01_up.png',
          urlShot: "assets/images/shot/Heavy_Shell_up.png",
          speed: 2000),
      Tank(
        x: 1,
        y: 1,
        urlBody: "assets/images/first_tank/Hull_01_up.png",
        urlTower: 'assets/images/first_tank/Gun_01_up.png',
        urlShot: "assets/images/shot/Heavy_Shell_up.png",
        speed: 700,
      ),
    ];
    gameField = List.generate(countColRow * countColRow, (int index) {
      return -1;
    }, growable: false);
    for (var element in players) {
      element.positionInGridView =
          element.x - 1 + ((element.y - 1) * GameSession.countColRow);
      gameField[element.positionInGridView] = element.positionInGridView;
    }
    updateSession();

    for (var element in players) {
      element.aiTank();
    }
  }

  void updateSession() {
    if (clearList.isNotEmpty) {
      for (var i = 0; i < clearList.length; i++) {
        players.removeAt(clearList[i]);
      }
      clearList = [];
    }
    // //Вызов AI танка
    // players.forEach((element) {
    //   element.aiTank();
    // });
    //Заполняем игровое поле -1
    gameField = List.generate(gameField.length, (int index) {
      return -1;
    }, growable: false);
    //Просматриваем позицию каждого игрока
    for (int i = 0; i < players.length; i++) {
      players[i].positionInGridView =
          players[i].x - 1 + ((players[i].y - 1) * GameSession.countColRow);
      gameField[players[i].positionInGridView] = players[i].positionInGridView;
      for (int k = 0; k < players.length; k++) {
        if (players[i].positionInGridView == players[k].positionInGridView &&
            players[i] != players[k]) {
          // clearList.add(i);
          // clearList.add(k);
          startSession();
        }
      }
      for (var bullet in players[i].listBullet) {
        for (int j = 0; j < players.length; j++) {
          players[j].clearBullet();
          if (bullet.positionShotInGridView == players[j].positionInGridView) {
            // clearList.add(j);
            winTanks[i] += 1;
            startSession();
          }
        }
        if (bullet.positionShotInGridView > 0 &&
            bullet.positionShotInGridView <
                GameSession.countColRow * GameSession.countColRow) {
          gameField[bullet.positionShotInGridView] = -2;
        }
      }
    }
    Timer(const Duration(microseconds: 100), () {
      notifyListeners();
      updateSession();
    });
  }
}
