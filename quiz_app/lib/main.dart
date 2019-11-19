import 'package:flutter/material.dart';
import 'package:quiz_app/result.dart';
import './quiz.dart';
import './result.dart';

// void main(){
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What is the capital of Australia?',
      'answer': [
        {'text': 'Sydney', 'score': 0},
        {'text': 'Melbourne', 'score': 0},
        {'text': 'Perth', 'score': 0},
        {'text': 'Canberra', 'score': 1}
      ],
    },
    {
      'questionText': 'What is the price of Onion in Bnagladesh?',
      'answer': [
        {'text': '200taka', 'score': 0},
        {'text': '240taka', 'score': 1},
        {'text': '250taka', 'score': 0},
        {'text': '220taka', 'score': 0}
      ],
    },
    {
      'questionText': 'Which team is current cricket world campion?',
      'answer': [
        {'text': 'Bangladesh', 'score': 0},
        {'text': 'India', 'score': 0},
        {'text': 'Australia', 'score': 0},
        {'text': 'England', 'score': 1}
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore = _totalScore + score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print('Question $_questionIndex answerd!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App!'),
        ),
        body: (_questionIndex < _questions.length)
            ? Quiz(
                answerQuestion: _answerQuestion,
                questions: _questions,
                questionIndex: _questionIndex,
              )
            : Result(_totalScore, _restartQuiz),
      ),
    );
  }
}
