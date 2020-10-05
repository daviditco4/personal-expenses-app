import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionForm extends StatelessWidget {
  final Function onSubmit;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  TransactionForm({@required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            FlatButton(
              onPressed: () => onSubmit(
                Transaction(
                  id: 't3',
                  title: titleController.text,
                  amount: double.parse(amountController.text),
                  date: DateTime.now(),
                ),
              ),
              textColor: Colors.purple,
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
