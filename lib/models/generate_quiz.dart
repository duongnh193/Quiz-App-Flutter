import 'dart:convert';
class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    final shuffleList = List.of(answers);
    shuffleList.shuffle();
    return shuffleList;
  }
}

class Result {
  final int numCorrect;
  final int numTotal;
  final Duration timeTaken;

  Result({
    required this.numCorrect,
    required this.numTotal,
    required this.timeTaken,
  });

  Map<String, dynamic> toJson(){
    return {
      'numCorrect': numCorrect,
      'numTotal': numTotal,
      'timeTaken': timeTaken.inSeconds,
    };
  }

  // convert to result
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      numCorrect: json['numCorrect'],
      numTotal: json['numTotal'],
      timeTaken: Duration(seconds: json['timeTaken']),
    );
  }

}

