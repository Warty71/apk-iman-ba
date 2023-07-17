import 'dart:async';

import 'package:apk_iman_ba/pages/askpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CustomFAB extends StatefulWidget {
  const CustomFAB({super.key});

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  late Duration _remainingTime = const Duration();
  late Timer _timer;
  late bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLastQuestionTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _getLastQuestionTime() async {
    // For example, if you are using Firebase Firestore:
    final User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference korisnikRef =
        FirebaseDatabase.instance.ref().child('Korisnici').child(user!.uid);
    final DatabaseEvent event = await korisnikRef.once();
    final dynamic userData = event.snapshot.value;
    final lastQuestionTime = DateTime.parse((userData['zadnjePitanje']));

    // Start the timer if the last question time is available
    // Calculate the remaining time until 24 hours have passed
    _calculateRemainingTime(lastQuestionTime);

    // Start a timer that updates the remaining time every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime(lastQuestionTime);
    });
  }

  void _calculateRemainingTime(DateTime lastQuestionTime) {
    final nextQuestionTime = lastQuestionTime.add(const Duration(minutes: 1));

    _remainingTime = nextQuestionTime.difference(DateTime.now());

    // If the remaining time is negative or zero, reset it to zero
    if (_remainingTime.isNegative) {
      _remainingTime = Duration.zero;
    }

    setState(() {
      _isLoading = false;
    });
  }

  String _formatTime(Duration duration) {
    final formattedDuration = duration.toString().split('.').first;
    final parts = formattedDuration.split(':');
    final hours = parts[0].padLeft(2, '0');
    final minutes = parts[1].padLeft(2, '0');
    final seconds = parts[2].padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Return a loading indicator or placeholder widget while the timer data is being fetched
      return const CircularProgressIndicator();
    } else if (_remainingTime == Duration.zero) {
      // Show the button with "Postavi pitanje" text if the timer has expired
      return FloatingActionButton.extended(
        onPressed: _navigateToAskPage,
        label: const Text("Postavi pitanje"),
        backgroundColor: const Color(0xff5449d2),
        extendedPadding: const EdgeInsets.all(55),
      );
    } else {
      // Show the button with the remaining time if the timer is active
      return FloatingActionButton.extended(
        onPressed: null,
        label: Text("Time Left: ${_formatTime(_remainingTime)}"),
        backgroundColor: Colors.grey,
        extendedPadding: const EdgeInsets.all(55),
      );
    }
  }

  void _navigateToAskPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const AskPage()));
  }
}
