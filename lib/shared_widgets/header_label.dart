import 'package:convert_rai/features/main_page/presentation/main_app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeaderRow extends ConsumerWidget {
  const HeaderRow({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: (() => ref
                      .read(localLangCodeProvider.notifier)
                      .update((state) => 'th')),
                  child: const Text(
                    'ไทย',
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                width: 2,
                height: 24,
                color: Colors.white,
              ),
              TextButton(
                  onPressed: (() => ref
                      .read(localLangCodeProvider.notifier)
                      .update((state) => 'en')),
                  child: const Text(
                    'En',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
