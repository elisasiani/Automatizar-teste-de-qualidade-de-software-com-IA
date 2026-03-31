import 'package:flutter/foundation.dart';

// ChangeNotifier: permite que esse objeto "avise" as telas
// quando os dados mudam, sem precisar chamar setState() em todo lugar.
class UserProgress extends ChangeNotifier {
  int _streakDays = 3;
  int _totalStars = 15;

  // Map que guarda quantos exercícios de cada trilha foram completados
  // Chave: id da trilha | Valor: índice do último exercício completado
  final Map<String, int> _trilhaProgress = {
    'fonemas': 0,
    'trava_linguas': 0,
  };

  // Getters: forma segura de ler os dados de fora da classe
  int get streakDays => _streakDays;
  int get totalStars => _totalStars;

  // Retorna o progresso (0 a 5) de uma trilha específica
  int getProgressoTrilha(String trilhaId) {
    return _trilhaProgress[trilhaId] ?? 0;
  }

  // Chamado quando o usuário completa um exercício
  void completarExercicio(String trilhaId) {
    final progressoAtual = _trilhaProgress[trilhaId] ?? 0;
    if (progressoAtual < 5) {
      _trilhaProgress[trilhaId] = progressoAtual + 1;
    }
    _totalStars += 10; // Ganha 10 estrelas por exercício
    notifyListeners(); // Avisa as telas para atualizar a UI
  }

  // Chamado quando o usuário entra no app no dia (lógica simplificada)
  void registrarEntradaDiaria() {
    _streakDays++;
    notifyListeners();
  }
}