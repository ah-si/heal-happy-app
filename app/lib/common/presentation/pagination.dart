import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int total;
  final int current;
  final Function(int selectedPage) onPageSelected;

  const Pagination({Key? key, required this.onPageSelected, required this.total, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
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
    );
  }
}
