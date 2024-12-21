import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: dayController,
              decoration: const InputDecoration(
                labelText: 'Day',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: monthController,
              decoration: const InputDecoration(
                labelText: 'Month',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: 'Year',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final day = dayController.text;
                final month = monthController.text;
                final year = yearController.text;
                _saveData(name, day, month, year);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveData(
    String name,
    String day,
    String month,
    String year,
  ) async {
    final data = {
      'name': name,
      'day': day,
      'month': month,
      'year': year,
    };
    await FirebaseFirestore.instance.collection('Number').doc().set(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Saved')));
  }
}
