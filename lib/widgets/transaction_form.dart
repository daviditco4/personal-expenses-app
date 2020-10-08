import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Function onSubmit;

  TransactionForm({@required this.onSubmit});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _submitForm() {
    final titleInput = titleController.text;
    final amountInput = amountController.text;
    final amountDouble = amountInput.isEmpty ? 0.0 : double.parse(amountInput);

    if (titleInput.isNotEmpty && amountDouble > 0) {
      widget.onSubmit(
        Transaction(
          id: 't3',
          title: titleInput,
          amount: amountDouble,
          date: DateTime.now(),
        ),
      );
    }
  }

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
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            FlatButton(
              onPressed: _submitForm,
              textColor: Colors.purple,
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
