import 'package:auto_size_text/auto_size_text.dart';
import 'package:convert_rai/features/main_page/presentation/main_app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeaderRow extends ConsumerWidget {
  const HeaderRow({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLang = ref.watch(localLangCodeProvider);

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
            Row(
              children: [
                GestureDetector(
                    onTap: (() => ref
                        .read(localLangCodeProvider.notifier)
                        .update((state) => 'th')),
                    child: Container(
                      alignment: Alignment.center,
                      width: 48,
                      height: 40,
                      child: Text(
                        'ไทย',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: currentLang == 'th'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    )),
                Container(
                  width: 2,
                  height: 24,
                  color: Colors.white,
                ),
                GestureDetector(
                    onTap: (() => ref
                        .read(localLangCodeProvider.notifier)
                        .update((state) => 'en')),
                    child: Container(
                      width: 48,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        'En',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: currentLang == 'en'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
