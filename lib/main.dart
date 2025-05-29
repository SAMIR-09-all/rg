import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'who is the founder of wireshark?',
      'options': ['Gerald Combs','Pavel Durov','Jon von Tetzchner','Jan Koum'],
      'answer': 'Gerald Combs',
    },
    {
      'question': 'Which language is used for Flutter?',
      'options': ['Kotlin', 'Swift', 'Dart', 'JavaScript'],
      'answer': 'Dart',
    },
    {
      'question': 'Who developed Flutter?',
      'options': ['Apple', 'Microsoft', 'Facebook', 'Google'],
      'answer': 'Google',
    },
  ];

  int _currentIndex = 0;
  int _score = 0;

  void _checkAnswer(String selected) {
    String correct = _questions[_currentIndex]['answer'] as String;

    if (selected == correct) {
      _score++;
    }

    setState(() {
      _currentIndex++;
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool quizFinished = _currentIndex >= _questions.length;

    return Scaffold(
      appBar: AppBar(title: Text('Flutter Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: quizFinished
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Completed!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Your Score: $_score  / ${_questions.length}',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _restartQuiz,
                child: Text('Restart Quiz'),
              ),
            ],
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentIndex + 1} of ${_questions.length}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Text(
              _questions[_currentIndex]['question'] as String,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            ...(_questions[_currentIndex]['options'] as List<String>).map(
                  (option) => Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.all(16)),
                  onPressed: () => _checkAnswer(option),
                  child: Text(option),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}