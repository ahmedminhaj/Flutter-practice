import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

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
  var questionIndex = 0;

  void answerQuestion() {
    setState(() {
      questionIndex = questionIndex + 1;
    });
    print('Question $questionIndex answerd!');
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      {
        'questionText': 'What is your favorate color?',
        'answer': ['Red', 'Black', 'Green', 'Yellow'],
      },
      {
        'questionText': 'What is your favorate animal?',
        'answer': ['Tiger', 'Lion', 'Rabbit', 'Hourse'],
      },
      {
        'questionText': 'What is Your favorate food?',
        'answer': ['Burger', 'Franch Fry', 'Chicken Fry', 'Kabab'],
      },
      
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App!'),
        ),
        body: Column(
          children: [
            Question(
              questions[questionIndex]['questionText'],
            ),
            ...(questions[questionIndex]['answer'] as List<String>).map((answer){
              return Answer(answerQuestion ,answer);
            }).toList()
          ],
        ),
      ),
    );
  }
}
