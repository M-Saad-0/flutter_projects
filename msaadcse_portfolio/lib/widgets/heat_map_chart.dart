import 'package:flutter/material.dart';

class HeatMapChart extends StatelessWidget {
  final List<Map<String, dynamic>> year;
  const HeatMapChart({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).width/60;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(),
        Column(),
        Wrap(
          children:
              year.map((e) {
                if ((e['date'] as String).substring(8) == "01") {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Tooltip(
                      message: "${e['count']} Contributions of ${e['date']}",
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          color: Theme.of(context).primaryColor.withValues(
                            alpha: ((e['level'] + 1) / 6) as double,
                          ),

                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  );
                }
                return Tooltip(
                  message: "${e['count']} Contributions of ${e['date']}",
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      color: Theme.of(context).primaryColor.withValues(
                        alpha: ((e['level'] + 1) / 6) as double,
                      ),

                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
