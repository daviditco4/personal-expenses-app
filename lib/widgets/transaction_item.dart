import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({@required this.transaction, @required this.deleteTx});

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deleteIcon = Platform.isIOS
        ? const Icon(CupertinoIcons.delete_solid, size: 24.0)
        : const Icon(Icons.delete);

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
                '\$${transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: theme.textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width >= 500
            ? TextButton.icon(
                onPressed: () => deleteTx(transaction.id),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(theme.errorColor),
                ),
                icon: deleteIcon,
                label: const Text('DELETE'),
              )
            : IconButton(
                onPressed: () => deleteTx(transaction.id),
                color: theme.errorColor,
                icon: deleteIcon,
              ),
      ),
    );
  }
}
