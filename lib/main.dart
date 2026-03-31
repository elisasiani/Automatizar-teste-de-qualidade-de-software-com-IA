import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Agora começa pelo login!
import 'models/user_progress.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // ChangeNotifierProvider: É o "gerenciador de estado" do app.
    // Pense nele como uma caixa compartilhada onde qualquer tela pode
    // ler ou modificar o progresso do usuário sem precisar ficar
    // passando dados de tela em tela manualmente.
    // Pacote necessário: adicionar 'provider: ^6.1.2' no pubspec.yaml
    ChangeNotifierProvider(
      create: (context) => UserProgress(),
      child: const FonoApp(),
    ),
  );
}

class FonoApp extends StatelessWidget {
  const FonoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: usa os componentes mais modernos do Flutter
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B2FBE), // Roxo principal
          primary: const Color(0xFF7B2FBE),
          secondary: const Color(0xFFCE93D8), // Lilás
          surface: const Color(0xFFF8F0FF), // Fundo lilás claríssimo
        ),
        fontFamily: 'Nunito', // Fonte arredondada e amigável para crianças
        // Para usar Nunito, adicione no pubspec.yaml:
        // flutter:
        //   fonts:
        //     - family: Nunito
        //       fonts:
        //         - asset: assets/fonts/Nunito-Regular.ttf
        //         - asset: assets/fonts/Nunito-Bold.ttf
        //           weight: 700
      ),
      home: const LoginScreen(), // Ponto de entrada: tela de login
    );
  }
}