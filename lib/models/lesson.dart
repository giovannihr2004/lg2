// lib/models/lesson.dart

// ----------------------------------------
// Parte 1: Modelo Lesson y sus preguntas
// ----------------------------------------

/// Modelo que representa una lección completa
class Lesson {
  final String id; // Identificador único
  final String title; // Título de la lección
  final String description; // Descripción breve
  final String content; // Texto completo de la lección
  final List<Question> questions; // Lista de preguntas asociadas

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.questions,
  });

  // ----------------------------------------
  // Parte 2: Métodos de serialización JSON
  // ----------------------------------------

  /// Crea una instancia de Lesson a partir de un Map (JSON)
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      questions:
          (json['questions'] as List<dynamic>)
              .map((q) => Question.fromJson(q as Map<String, dynamic>))
              .toList(),
    );
  }

  /// Convierte esta instancia en un Map (para generar JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}

// ----------------------------------------
// Parte 3: Modelo de pregunta (Question)
// ----------------------------------------

/// Modelo que representa una pregunta de opción múltiple
class Question {
  final String question; // Texto de la pregunta
  final List<String> options; // Opciones posibles
  final int answerIndex; // Índice de la opción correcta

  Question({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List<dynamic>),
      answerIndex: json['answerIndex'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'answerIndex': answerIndex,
    };
  }
}
