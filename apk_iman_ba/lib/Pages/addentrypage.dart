// ignore: unused_import
import 'package:apk_iman_ba/Services/database_service.dart';
import 'package:apk_iman_ba/State%20Management/user_state.dart';
import 'package:apk_iman_ba/models/question_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({Key? key}) : super(key: key);

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final TextEditingController askedByController = TextEditingController();
  final TextEditingController answeredByController = TextEditingController();

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    answeredByController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: 'Question',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(
                labelText: 'Answer',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: answeredByController,
              decoration: const InputDecoration(
                labelText: 'Answered by',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final userState =
                    Provider.of<UserState>(context, listen: false);
                final question = Question(
                  id: dbRef.push().key!,
                  question: questionController.text.trim(),
                  answer: answerController.text.trim(),
                  askedBy: userState.user!.email.toString().trim(),
                  answeredBy: answeredByController.text.trim(),
                  date: DateTime.now().toIso8601String().trim(),
                  topics: '',
                  views: 0,
                );
                try {
                  dbRef
                      .child("Pitanja i Odgovori")
                      .child(question.id)
                      .set(question.toJson());

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Entry added successfully')),
                  );
                  questionController.clear();
                  answerController.clear();
                  answeredByController.clear();
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to add entry')),
                  );
                  // ignore: avoid_print
                  print('Database write error: $error');
                }
              },
              child: const Text('Add Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
