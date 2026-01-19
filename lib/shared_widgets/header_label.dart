import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    // TODO: Will migrate language state to Bloc in Phase 5
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            SizedBox(width: 8),
            Image.asset(
              'assets/images/rai_logo.png',
              height: 28,
            ),
            SizedBox(width: 8),
            Expanded(
              child: AutoSizeText(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
                minFontSize: 16,
                maxLines: 1,
              ),
            ),
            // TODO: Language switching will be reimplemented in Phase 5 with Bloc
          ],
        ),
      ),
    );
  }
}
