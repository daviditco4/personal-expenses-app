import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class TransactionsChart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  TransactionsChart(this._recentTransactions);

  List<Map<String, Object>> get groupedTransactionsData {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: 6 - index));
      var totalAmount = 0.0;

      for (var tx in _recentTransactions) {
        if (weekday.day == tx.date.day &&
            weekday.month == tx.date.month &&
            weekday.year == tx.date.year) {
          totalAmount += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalAmount,
      };
    });
  }

  double get totalSpending {
    return _recentTransactions.fold(0.0, (sum, tx) => sum + tx.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.0),
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsData.map((data) {
            return Expanded(
              child: ChartBar(
                title: data['day'],
                spendingAmount: data['amount'],
                spendingFractionOfTotal: totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
