import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, '/second'); // Navigate to second page
              },
              child: Image.asset(
                'images/quizz.jpg', // Replace with your image path
                width: 100, // Adjust width as needed
                height: 100, // Adjust height as needed
              ),
            ),
            const SizedBox(height: 20), // Spacing between image and text
            Text(
              'Quiz Application',
              style: TextStyle(
                fontSize: 28,
                color: Color.fromARGB(255, 255, 30, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // Added Drawer
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(), // Pushes the text to the top
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.pushNamed(
                      context, '/second'); // Navigate to second page
                },
                child: const Text('Go to Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
