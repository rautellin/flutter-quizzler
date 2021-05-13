import 'package:flutter/material.dart';
import 'questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Questions questionObject = Questions();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        )),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  void pressedButton() {
    setState(() {
      bool correctAnswer = questionObject.getAnswer();
      if (correctAnswer) {
        scoreKeeper.add(
          Icon(Icons.check, color: Colors.green),
        );
      } else {
        scoreKeeper.add(
          Icon(Icons.close, color: Colors.red),
        );
      }

      bool quizIsFinished = questionObject.isFinished();
      print(quizIsFinished);
      if (quizIsFinished) {
        scoreKeeper.clear();
        questionObject.resetQuestion();
        Alert(
                context: context,
                title: 'Finished!',
                desc: 'You\'ve reached the end of the quiz.')
            .show();
      }

      questionObject.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionObject.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                pressedButton();
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'True',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                pressedButton();
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text(
                'False',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
