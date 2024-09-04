import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search for help',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Popular questions
              const Text(
                'Popular questions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              buildQuestionItem('How do I use the app?'),
              buildQuestionItem('When is the bus arriving?'),
              buildQuestionItem('What is the bus schedule?'),
              const SizedBox(height: 32),

              // Contact us
              const Text(
                'Contact us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              buildContactItem('Email us'),
              buildContactItem('Chat with us'),
              const SizedBox(height: 32),

              // Tutorials
              const Text(
                'Tutorials',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTutorialItem(
                      'How to use the app', 'assets/images/support.jpeg'),
                  buildTutorialItem(
                      'How to track your bus', 'assets/images/support2.jpeg'),
                ],
              ),
              const SizedBox(height: 32),

              // Give feedback button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Give feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestionItem(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        question,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildContactItem(String contactOption) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        contactOption,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget buildTutorialItem(String title, String imagePath) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
