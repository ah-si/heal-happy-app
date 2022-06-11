import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/common/utils/constants.dart';

class Pagination extends HookWidget {
  final int total;
  final int current;
  final Function(int selectedPage) onPageSelected;

  const Pagination({Key? key, required this.onPageSelected, required this.total, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return Center(
      child: Scrollbar(
        controller: controller,
        thumbVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        child: SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kNormalPadding, vertical: kSmallPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Pages:'),
                for (var i = 0; i < total; i++)
                  TextButton(
                    onPressed: current == i
                        ? null
                        : () {
                            onPageSelected(i);
                          },
                    child:
                        Text((i + 1).toString(), style: current == i ? const TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline) : null),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
