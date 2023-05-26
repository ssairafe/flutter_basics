import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recipe_page.dart';
import 'package:dio/dio.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dishController = TextEditingController();
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _restrictionsController = TextEditingController();

  final dio = Dio();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {

      final Map<String, dynamic> requestBodyData = {
        'dish': _dishController.text,
        'country': _styleController.text,
        'foodRestrictions': _restrictionsController.text,
      };

      final Map<String, dynamic> requestBody = {
        "input": requestBodyData
      };

      print(jsonEncode(requestBody));
      // Perform the POST request
      final response = await dio.post(
        'https://2a17-2600-8802-2711-3500-8cde-bef9-8b7f-b174.ngrok-free.app/recipes',
        data: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print(response.data);
        // Successful response
        final responseData = response.data;
        _navigateToRecipePage(responseData);
      } else {
        // Error handling
        _showErrorDialog();
      }
    }
  }

  void _navigateToRecipePage(responseData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipePage(responseData: responseData),
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Failed to submit form.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _dishController.dispose();
    _styleController.dispose();
    _restrictionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Palette AI'), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _dishController,
                decoration: const InputDecoration(labelText: 'Dish'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _styleController,
                decoration: const InputDecoration(labelText: 'Style or Country of Origin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _restrictionsController,
                decoration: const InputDecoration(labelText: 'Food Restrictions (comma separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ingredients.';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
