import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this._transactions, {@required this.deleteTx});

  final List<Transaction> _transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return _transactions.isNotEmpty
        ? ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (_, index) {
              return TransactionItem(
                transaction: _transactions[index],
                deleteTx: deleteTx,
              );
            },
          )
        : LayoutBuilder(
            builder: (_, constraints) {
              return Column(
                children: [
                  Container(
                    height: 0.5 * constraints.maxHeight,
                    padding: EdgeInsets.all(0.08 * constraints.maxHeight),
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              );
            },
          );
  }
}
