import 'package:flutter/material.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';

class MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool selected;

  const MenuItem({Key? key, required this.label, this.onTap, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: context.primaryColor,
      child: ColoredBox(
        color: Colors.white.withOpacity(selected ? 0.8 : 0.6),
        child: Padding(
          padding: const EdgeInsets.all(kSmallPadding),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? context.primaryColor : Colors.black,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
