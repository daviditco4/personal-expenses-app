import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String title;
  final double spendingAmount;
  final double spendingFractionOfTotal;

  ChartBar({
    @required this.title,
    @required this.spendingAmount,
    @required this.spendingFractionOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    final verticalSpace = SizedBox(height: 5.0);
    final borders = Border.all();
    final circularBorder = BorderRadius.circular(10.0);

    return Column(
      children: [
        Text(title),
        verticalSpace,
        Container(
          width: 20.0,
          height: 80.0,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: borders,
                  borderRadius: circularBorder,
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingFractionOfTotal,
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
        FittedBox(
          child: Text(
            '\$${spendingAmount.toStringAsFixed(0)}',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
