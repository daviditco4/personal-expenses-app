import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Function onSubmit;

  TransactionForm({@required this.onSubmit});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;

  void _submitForm() {
    final titleInput = _titleController.text;
    final amountInput = _amountController.text;
    final amountDouble = amountInput.isEmpty ? 0.0 : double.parse(amountInput);

    if (titleInput.isNotEmpty && amountDouble > 0.0 && _pickedDate != null) {
      widget.onSubmit(
        Transaction(
          id: DateTime.now().toString(),
          title: titleInput,
          amount: amountDouble,
          date: _pickedDate,
        ),
      );
    }
  }

  void _pickDate() {
    DateTime today = DateTime.now();

    showDatePicker(
      context: context,
      initialDate: _pickedDate == null ? today : _pickedDate,
      firstDate: DateTime(2020),
      lastDate: today,
    ).then((date) {
      if (date != null) {
        setState(() {
          _pickedDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _pickedDate == null
                          ? 'Choose a date'
                          : 'Date: ${DateFormat.yMd().format(_pickedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _pickDate,
                    child: Text(
                      'Select',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitForm,
              color: Theme.of(context).primaryColor,
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
