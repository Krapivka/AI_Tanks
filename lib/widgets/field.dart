import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_tanks/models/tank.dart';

class Field extends StatelessWidget {
  final int index;
  Field({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    final gameSession = Provider.of<GameSession>(context);
    Tank player = gameSession.players[0];
    Bullet bullet =
        Bullet(1, "assets/images/shot/Heavy_Shell_up.png", DirectionTower.up);

    if (index != -1) {
      for (Tank element in gameSession.players) {
        if (element.positionInGridView == index) {
          player = element;
        }
        for (Bullet bul in element.listBullet) {
          if (bul.positionShotInGridView == index) {
            bullet = bul;
          }
        }
      }
    }
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromARGB(181, 108, 150, 30),
      ),
      child: (gameSession.gameField[index] == -1)
          ? Container()
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (gameSession.gameField[index] == -2)
                      ? AssetImage(bullet.urlShot)
                      : AssetImage(player.urlBody),
                ),
              ),
              child: (gameSession.gameField[index] == -2)
                  ? Image.asset(bullet.urlShot)
                  : Image.asset(player.urlTower),
            ),
    );
  }
}
