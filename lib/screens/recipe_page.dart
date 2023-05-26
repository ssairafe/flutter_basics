import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  final Map<String, dynamic> responseData;

  const RecipePage({Key? key, required this.responseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = responseData['recipe']['name'];
    final description = responseData['recipe']['description'];
    final ingredients =
        List<String>.from(responseData['recipe']['ingredients']);
    final steps = List<String>.from(responseData['recipe']['steps']);

    return Scaffold(
      appBar: AppBar(title: const Text('Display Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$name', style: Theme.of(context).textTheme.titleLarge),
              Text('$description',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 16.0),
              Text('Ingredients:',
                  style: Theme.of(context).textTheme.titleMedium),
              ListView.builder(
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) => Text(
                  '- ${ingredients[index]}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16.0),
              Text('Steps:', style: Theme.of(context).textTheme.titleMedium),
              ListView.builder(
                shrinkWrap: true,
                itemCount: steps.length,
                itemBuilder: (context, index) => Text(
                  '${index + 1}. ${steps[index]}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
