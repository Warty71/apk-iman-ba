import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicItem extends StatelessWidget {
  final String topic;
  final bool isSelected;
  final VoidCallback onTap;

  const TopicItem({
    super.key,
    required this.topic,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xff5449d2) : const Color(0xff190c3f),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xff5449d2) : const Color(0xff190c3f),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  topic,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
