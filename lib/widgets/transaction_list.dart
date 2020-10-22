import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTx;

  const TransactionList(this._transactions, {@required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deleteIcon = Platform.isIOS
        ? const Icon(CupertinoIcons.delete_solid, size: 24.0)
        : const Icon(Icons.delete);

    return _transactions.isNotEmpty
        ? ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (_, index) {
              return Card(
                elevation: Platform.isIOS ? 0.0 : 5.0,
                margin: const EdgeInsets.all(6.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: theme.primaryColorDark,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          '\$${_transactions[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    _transactions[index].title,
                    style: theme.textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width >= 500
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(_transactions[index].id),
                          textColor: theme.errorColor,
                          icon: deleteIcon,
                          label: const Text('DELETE'),
                        )
                      : IconButton(
                          onPressed: () => deleteTx(_transactions[index].id),
                          color: theme.errorColor,
                          icon: deleteIcon,
                        ),
                ),
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
                    style: theme.textTheme.headline6,
                  ),
                ],
              );
            },
          );
  }
}
