import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class TransactionsChart extends StatelessWidget {
  const TransactionsChart(this._recentTransactions);

  final List<Transaction> _recentTransactions;

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

  double get maxSpending {
    var max = 0.0;
    for (var tx in _recentTransactions) {
      max = tx.amount > max ? tx.amount : max;
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15.0),
      elevation: Platform.isIOS ? 0.0 : 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsData.map((data) {
            return Expanded(
              child: ChartBar(
                title: data['day'],
                spendingAmount: data['amount'],
                spendingFractionOfMax: maxSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
