import 'package:ai_tanks/models/tank.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_tanks/widgets/field.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

GameSession gameSession = GameSession();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameSession>(
          create: (context) => gameSession,
        ),
      ],
      child: MaterialApp(
        title: 'World of Tanks',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameSession = Provider.of<GameSession>(context);
    final countRowCol = gameSession.gameField.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('World of Tanks'),
        actions: <Widget>[
          ...gameSession.winTanks.map((value) {
            return Center(
              child: Text(
                '| $value ',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            );
          }).toList(),
          ElevatedButton(
            onPressed: () {
              gameSession.startSession();
            },
            child: Text('Начать'),
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: 750,
          width: 750,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: sqrt(countRowCol).toInt(),
            ),
            itemBuilder: (context, index) {
              return Field(
                index: index,
              );
            },
            itemCount: countRowCol,
          ),
        ),
      ),
    );
  }
}
