import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Record Player',
      amount: 249.9,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Vinyl Record',
      amount: 9.99,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(
          onSubmit: (tx) => setState(() {
            _transactions.add(tx);
          }),
        ),
        TransactionList(_transactions),
      ],
    );
  }
}
