import 'dart:async';

import 'package:apk_iman_ba/pages/askpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomFAB extends StatefulWidget {
  final bool shouldRebuild;
  final VoidCallback? onQuestionAsked;

  const CustomFAB({
    super.key,
    required this.shouldRebuild,
    this.onQuestionAsked,
  });

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
    final User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference korisnikRef =
        FirebaseDatabase.instance.ref().child('Korisnici').child(user!.uid);
    final DatabaseEvent event = await korisnikRef.once();
    final dynamic userData = event.snapshot.value;
    final lastQuestionTime = DateTime.parse(userData['zadnjePitanje']);

    _calculateRemainingTime(lastQuestionTime);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime(lastQuestionTime);
    });
  }

  void _calculateRemainingTime(DateTime lastQuestionTime) {
    final nextQuestionTime = lastQuestionTime.add(const Duration(days: 1));

    _remainingTime = nextQuestionTime.difference(DateTime.now());

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
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(25),
        ),
        width: 265,
        height: 48,
        child: const SpinKitWave(
          color: Colors.white,
          size: 32,
        ),
      );
    } else if (_remainingTime == Duration.zero) {
      return FloatingActionButton.extended(
        onPressed: () => _navigateToAskPage(context),
        label: const Text("Postavi pitanje"),
        backgroundColor: const Color(0xff5449d2),
        extendedPadding: const EdgeInsets.all(55),
      );
    } else {
      return FloatingActionButton.extended(
        onPressed: null,
        label: Text("Preostalo: ${_formatTime(_remainingTime)}"),
        backgroundColor: Colors.grey,
        extendedPadding: const EdgeInsets.all(55),
      );
    }
  }

  Future<void> _navigateToAskPage(BuildContext context) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const AskPage()),
    );

    if (result == true) {
      widget.onQuestionAsked?.call();
    }
  }
}
