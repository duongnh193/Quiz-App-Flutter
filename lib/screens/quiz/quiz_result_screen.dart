import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screens/homepage/homepage.dart';

import '../../constant.dart';
import '../../controller/authentication/shared_preference_helper.dart';
import '../../models/generate_quiz.dart';
import 'component/sumary_result.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
    required this.startTime,
    // required this.results,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;
  final DateTime startTime;
  // final List<Result> results;


  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'questions_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = getSummaryData().where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    // final startTime = DateTime.now();
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            QuestionsSummary(getSummaryData()),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(width: 2, color: k3),
                fixedSize: Size(150, 40)
              ),
              icon: const Icon(Icons.restart_alt),
              onPressed: onRestart,
              label: const Text('Restart Quiz!'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(width: 2, color: k3),
                  fixedSize: Size(150, 40)
              ),
              icon: const Icon(Icons.undo),
              onPressed: () async {
                final newResult = Result(
                    numCorrect: numCorrectQuestions,
                    numTotal: numTotalQuestions,
                    timeTaken: duration
                );
                final currentResults = await SharedPreferenceHelper.loadResults();
                currentResults.add(newResult);
                await SharedPreferenceHelper.saveResults(currentResults);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePageScreen(),
                        )
                );
              },
              label: const Text('Save Result'),
            ),
          ],
        ),
      ),
    );
  }
}
