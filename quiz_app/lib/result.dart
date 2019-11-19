import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetQuiz;

  Result(this.resultScore, this.resetQuiz);

  String get resultPhrase{
    String resultText = 'Well done, Quiz over!!';
    if(resultScore == 3){
      resultText = 'Well done!!! Onion is injurious, so avoidOnion!!!';
    }else if(resultScore == 2){
      resultText = 'Did well, Likeable!!';
    }else if(resultScore == 1){
      resultText = 'Know more about current world!!';
    }else{
      resultText = 'Have a real life!!!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(child: Text('Restart Quiz'),onPressed: resetQuiz,)
        ],
      ),
    );
  }
}
