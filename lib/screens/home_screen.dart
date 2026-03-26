import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/exercicio.dart';
import '../models/user_progress.dart';
import '../widgets/mascote_widget.dart';
import 'trilha_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer: "escuta" o UserProgress e redesenha só este widget quando mudar
    return Consumer<UserProgress>(
      builder: (context, progresso, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F0FF),
          appBar: _buildAppBar(progresso),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Saudação personalizada
                  const Text(
                    'Olá, Amiguinho! 👋',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'O que vamos treinar hoje?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9C27B0),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Mascote com mensagem de boas-vindas
                  const MascoteWidget(
                    mensagem: 'Pronta para treinar juntos! Escolha uma trilha! 🌟',
                    animacao: 'falando',
                  ),
                  const SizedBox(height: 32),

                  // Card de progresso geral
                  _buildCardProgresso(progresso),
                  const SizedBox(height: 24),

                  const Text(
                    'Suas Trilhas',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Lista de trilhas gerada dinamicamente a partir dos dados
                  ...DadosApp.trilhas.map(
                    (trilha) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildCartaoTrilha(context, trilha, progresso),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // AppBar com os badges de gamificação
  PreferredSizeWidget _buildAppBar(UserProgress progresso) {
    return AppBar(
      backgroundColor: const Color(0xFF7B2FBE),
      elevation: 0,
      title: const Text(
        'FonoAmigo 🦒',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      actions: [
        _buildBadge(Icons.local_fire_department, '${progresso.streakDays}', Colors.orange),
        _buildBadge(Icons.star_rounded, '${progresso.totalStars}', Colors.yellow),
        const SizedBox(width: 8),
      ],
    );
  }

  // Badge reutilizável para streak e estrelas
  Widget _buildBadge(IconData icon, String valor, Color cor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: cor, size: 26),
          const SizedBox(width: 3),
          Text(
            valor,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Card que mostra o progresso geral do usuário
  Widget _buildCardProgresso(UserProgress progresso) {
    // Calcula progresso total: soma de todas as trilhas / total de exercícios
    final totalFeitos = DadosApp.trilhas
        .map((t) => progresso.getProgressoTrilha(t.id))
        .fold(0, (soma, v) => soma + v);
    final totalPossivel = DadosApp.trilhas.length * 5;
    final percentual = totalFeitos / totalPossivel;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B2FBE), Color(0xFFAB47BC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B2FBE).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Seu Progresso Total',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$totalFeitos de $totalPossivel exercícios',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(percentual * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Barra de progresso (XP bar)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentual,
              minHeight: 12,
              backgroundColor: Colors.white30,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.yellow),
            ),
          ),
        ],
      ),
    );
  }

  // Card de cada trilha na tela inicial
  Widget _buildCartaoTrilha(
      BuildContext context, Trilha trilha, UserProgress progresso) {
    final progressoTrilha = progresso.getProgressoTrilha(trilha.id);
    final concluida = progressoTrilha >= 5;

    return GestureDetector(
      onTap: () {
        // Navigator.push: empilha uma nova tela, mantendo a tela atual
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TrilhaScreen(trilha: trilha),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: concluida ? Colors.green : const Color(0xFFCE93D8),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Ícone/emoji da trilha
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(trilha.emoji, style: const TextStyle(fontSize: 30)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trilha.titulo,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trilha.subtitulo,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  // Mini barra de progresso da trilha
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: progressoTrilha / 5,
                            minHeight: 8,
                            backgroundColor: const Color(0xFFE1BEE7),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              concluida ? Colors.green : const Color(0xFF7B2FBE),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$progressoTrilha/5',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: concluida ? Colors.green : const Color(0xFF7B2FBE),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              concluida ? Icons.check_circle_rounded : Icons.chevron_right_rounded,
              color: concluida ? Colors.green : const Color(0xFF9C27B0),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}