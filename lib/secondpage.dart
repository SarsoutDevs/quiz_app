import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({
    super.key,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int currentQuestionIndex = 0;
  List<String> userAnswers = []; // To store user-selected answers
  int score = 0;

  // List of questions, possible answers, and correct answers
  final List<Map<String, Object>> quizQuestions = [
    {
      'question': 'What is Flutter Flow?',
      'answers': ['A framework', 'A plugin', 'A design tool'],
      'correctAnswer': 'A design tool',
    },
    {
      'question': 'Why do we use Flutter Flow?',
      'answers': ['For web apps', 'For mobile apps', 'For both'],
      'correctAnswer': 'For both',
    },
    {
      'question': 'What are the characteristics of FlutterFlow 3?',
      'answers': ['Easy to use', 'Limited features', 'Slow performance'],
      'correctAnswer': 'Easy to use',
    },
  ];

  // Method to handle answer selection and go to the next question
  void _answerQuestion(String selectedAnswer) {
    userAnswers.add(selectedAnswer); // Store the selected answer

    // Check if the selected answer is correct
    if (selectedAnswer ==
        quizQuestions[currentQuestionIndex]['correctAnswer']) {
      score++; // Increment score if correct
    }

    setState(() {
      if (currentQuestionIndex < quizQuestions.length - 1) {
        currentQuestionIndex++; // Move to the next question
      } else {
        // Navigate to the result page when quiz ends
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              userAnswers: userAnswers,
              score: score,
              totalQuestions: quizQuestions.length,
              quizQuestions: quizQuestions,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[currentQuestionIndex]['question'] as String;
    final answers =
        quizQuestions[currentQuestionIndex]['answers'] as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question, // Display the question
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display the possible answers
            ...answers.map((answer) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      _answerQuestion(answer), // Handle answer selection
                  child: Text(answer),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final List<String> userAnswers;
  final int score;
  final int totalQuestions;
  final List<Map<String, Object>> quizQuestions;

  const ResultPage({
    super.key,
    required this.userAnswers,
    required this.score,
    required this.totalQuestions,
    required this.quizQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score/$totalQuestions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display the user's answers and the correct answers
            Expanded(
              child: ListView.builder(
                itemCount: quizQuestions.length,
                itemBuilder: (context, index) {
                  final question = quizQuestions[index]['question'] as String;
                  final correctAnswer =
                      quizQuestions[index]['correctAnswer'] as String;
                  final userAnswer = userAnswers[index];

                  return ListTile(
                    title: Text(question),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Answer: $userAnswer'),
                        Text('Correct Answer: $correctAnswer'),
                      ],
                    ),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home'); // Go back to home
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
