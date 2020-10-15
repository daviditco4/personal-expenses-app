import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340.0,
      child: _transactions.isNotEmpty
          ? ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (_, index) => Card(
                elevation: 5.0,
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Theme.of(context).primaryColorDark,
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          '\$${_transactions[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    _transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_transactions[index].date),
                  ),
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  height: 200.0,
                  padding: EdgeInsets.all(30.0),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
    );
  }
}
