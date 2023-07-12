import 'package:apk_iman_ba/pages/askpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFAB extends StatefulWidget {
  const CustomFAB({Key? key});

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  DateTime?
      lastQuestionDateTime; // Stores the timestamp of the last question asked
  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    _loadLastQuestionTimestamp();
  }

// Load the last question timestamp from SharedPreferences
  Future<void> _loadLastQuestionTimestamp() async {
    prefs = await SharedPreferences.getInstance();
    final timestamp = prefs!.getInt('lastQuestionTimestamp');
    print(timestamp);
    if (timestamp != null) {
      lastQuestionDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
  }

  bool get canAskQuestion {
    if (lastQuestionDateTime == null) {
      return true; // User can ask a question if no question has been asked yet
    } else {
      final currentTime = DateTime.now();
      final nextDay = lastQuestionDateTime!.add(const Duration(days: 1));

      return currentTime.isAfter(nextDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (canAskQuestion) {
      return FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AskPage(),
            ),
          );
          setState(() {
            // Store the current timestamp as the last question timestamp
            lastQuestionDateTime = DateTime.now();
            // Save the lastQuestionDateTime to storage
            // Example: saveLastQuestionTimestamp(lastQuestionDateTime);
          });
        },
        label: const Text("Postavi pitanje"),
        backgroundColor: const Color(0xff5449d2),
        extendedPadding: const EdgeInsets.all(55),
      );
    } else {
      final timeLeft = lastQuestionDateTime!
          .add(const Duration(days: 1))
          .difference(DateTime.now());
      final hours = timeLeft.inHours;
      final minutes = timeLeft.inMinutes.remainder(60);
      final seconds = timeLeft.inSeconds.remainder(60);
      final formattedTimeLeft =
          '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

      return FloatingActionButton.extended(
        onPressed: null, // Disable the button when time is not expired
        label: Text("Time left: $formattedTimeLeft"),
        backgroundColor: Colors.grey,
        extendedPadding: const EdgeInsets.all(55),
      );
    }
  }
}
