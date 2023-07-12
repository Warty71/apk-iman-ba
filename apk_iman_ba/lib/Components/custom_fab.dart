import 'package:apk_iman_ba/pages/askpage.dart';
import 'package:flutter/material.dart';

class CustomFAB extends StatefulWidget {
  const CustomFAB({super.key});

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AskPage(),
          ),
        );
      },
      label: const Text("Postavi pitanje"),
      backgroundColor: const Color(0xff5449d2),
      extendedPadding: const EdgeInsets.all(55),
    );
  }
}
