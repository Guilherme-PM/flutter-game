import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedra, Papel e Tesoura',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      home: const Jogo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  String _escolhaHumano = 'padrao';
  String _escolhaComputador = 'padrao';
  String _result = '';

  void _makeescolha(String escolha) {
    final escolhas = ['pedra', 'papel', 'tesoura'];
    final random = Random();
    final computerescolha = escolhas[random.nextInt(escolhas.length)];

    setState(() {
      _escolhaHumano = escolha;
      _escolhaComputador = computerescolha;
      _result = _determineResult(escolha, computerescolha);
    });
  }

  String _determineResult(String playerescolha, String computerescolha) {
    if (playerescolha == computerescolha) {
      return 'Empate!';
    }

    if ((playerescolha == 'pedra' && computerescolha == 'tesoura') ||
        (playerescolha == 'papel' && computerescolha == 'pedra') ||
        (playerescolha == 'tesoura' && computerescolha == 'papel')) {
      return 'Você venceu!';
    }

    return 'Você perdeu!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedra, Papel e Tesoura'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sua escolha:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Image.asset('assets/$_escolhaHumano.png', height: 100),
            const SizedBox(height: 20),
            Text(
              'Escolha do Computador:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Image.asset('assets/$_escolhaComputador.png', height: 100),
            const SizedBox(height: 20),
            Text(
              _result,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _escolhaButton('pedra'),
                const SizedBox(width: 10),
                _escolhaButton('papel'),
                const SizedBox(width: 10),
                _escolhaButton('tesoura'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _escolhaButton(String escolha) {
    return ElevatedButton(
      onPressed: () => _makeescolha(escolha),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
      child: Text(
        escolha.toUpperCase(),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
