import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String title;
  final double spendingAmount;
  final double spendingFractionOfMax;

  ChartBar({
    @required this.title,
    @required this.spendingAmount,
    @required this.spendingFractionOfMax,
  });

  @override
  Widget build(BuildContext context) {
    final barWidth = 12.0;
    final borders = Border.all();
    final circularBorder = BorderRadius.circular(barWidth / 2);

    return LayoutBuilder(
      builder: (_, constraints) {
        final verticalSpace = SizedBox(height: 0.04 * constraints.maxHeight);

        return Column(
          children: [
            Container(
              height: 0.15 * constraints.maxHeight,
              child: FittedBox(child: Text(title)),
            ),
            verticalSpace,
            Container(
              width: barWidth,
              height: 0.62 * constraints.maxHeight,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: borders,
                      borderRadius: circularBorder,
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingFractionOfMax,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: borders,
                        borderRadius: circularBorder,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace,
            Container(
              height: 0.15 * constraints.maxHeight,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
