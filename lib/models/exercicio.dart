// Modelo de dados para um Exercício.
// Uma classe simples que define o "formato" de cada exercício.
class Exercicio {
  final String id;
  final String instrucao;       // "Diga a palavra..."
  final String palavraAlvo;     // A palavra que a criança deve falar
  final String dicaAnimacao;    // Texto descrevendo a animação da girafa
  final String dificuldade;     // 'fácil', 'médio', 'difícil'

  const Exercicio({
    required this.id,
    required this.instrucao,
    required this.palavraAlvo,
    required this.dicaAnimacao,
    required this.dificuldade,
  });
}

// Modelo de dados para uma Trilha (conjunto de exercícios)
class Trilha {
  final String id;
  final String titulo;
  final String subtitulo;
  final String emoji;
  final List<Exercicio> exercicios;

  const Trilha({
    required this.id,
    required this.titulo,
    required this.subtitulo,
    required this.emoji,
    required this.exercicios,
  });
}

// ==============================================================
// DADOS ESTÁTICOS DO APP
// Por enquanto os dados ficam aqui. No futuro, isso viria de um
// banco de dados (Firebase Firestore é a recomendação para Flutter).
// ==============================================================
class DadosApp {
  static final List<Trilha> trilhas = [
    Trilha(
      id: 'fonemas',
      titulo: 'Trilha dos Fonemas',
      subtitulo: 'Vamos treinar o som do "R"!',
      emoji: '🗣️',
      exercicios: [
        Exercicio(
          id: 'f1',
          instrucao: 'Diga bem devagar:',
          palavraAlvo: 'rato',
          dicaAnimacao: 'Girafa abre a boca e mostra a língua tremendo',
          dificuldade: 'fácil',
        ),
        Exercicio(
          id: 'f2',
          instrucao: 'Agora tente dizer:',
          palavraAlvo: 'rua',
          dicaAnimacao: 'Girafa aponta para a boca e sorri',
          dificuldade: 'fácil',
        ),
        Exercicio(
          id: 'f3',
          instrucao: 'Um pouco mais difícil:',
          palavraAlvo: 'carro',
          dicaAnimacao: 'Girafa faz gesto de atenção com a pata',
          dificuldade: 'médio',
        ),
        Exercicio(
          id: 'f4',
          instrucao: 'Você consegue?',
          palavraAlvo: 'terra',
          dicaAnimacao: 'Girafa vibra de animação',
          dificuldade: 'médio',
        ),
        Exercicio(
          id: 'f5',
          instrucao: 'Último desafio! Diga:',
          palavraAlvo: 'recreio',
          dicaAnimacao: 'Girafa levanta os braços de comemoração',
          dificuldade: 'difícil',
        ),
      ],
    ),
    Trilha(
      id: 'trava_linguas',
      titulo: 'Trava-Línguas',
      subtitulo: 'Desafie sua língua!',
      emoji: '🌀',
      exercicios: [
        Exercicio(
          id: 't1',
          instrucao: 'Devagar primeiro:',
          palavraAlvo: 'O rato roeu',
          dicaAnimacao: 'Girafa faz sinal de calma com a pata',
          dificuldade: 'fácil',
        ),
        Exercicio(
          id: 't2',
          instrucao: 'Agora um pouco mais:',
          palavraAlvo: 'O rato roeu a roupa',
          dicaAnimacao: 'Girafa aponta para a boca sorrindo',
          dificuldade: 'fácil',
        ),
        Exercicio(
          id: 't3',
          instrucao: 'Quase lá!',
          palavraAlvo: 'O rato roeu a roupa do rei',
          dicaAnimacao: 'Girafa faz joinha com a pata',
          dificuldade: 'médio',
        ),
        Exercicio(
          id: 't4',
          instrucao: 'Respira e tenta:',
          palavraAlvo: 'O rato roeu a roupa do rei de Roma',
          dicaAnimacao: 'Girafa torce com pompons',
          dificuldade: 'médio',
        ),
        Exercicio(
          id: 't5',
          instrucao: 'Desafio final!',
          palavraAlvo: 'O rato roeu a roupa do rei de Roma e a rainha com raiva',
          dicaAnimacao: 'Girafa pula de alegria',
          dificuldade: 'difícil',
        ),
      ],
    ),
  ];
}