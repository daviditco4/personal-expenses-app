import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'adaptive_flat_button.dart';
import 'adaptive_raised_button.dart';
import 'adaptive_text_field.dart';

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

  void _setDate(DateTime date) {
    if (date != null) {
      setState(() {
        _pickedDate = date;
      });
    }
  }

  void _pickDate() {
    final today = DateTime.now();
    final initialDate = _pickedDate == null ? today : _pickedDate;
    final newYear = DateTime(2020);
    var currentDate = initialDate;

    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return CupertinoPopupSurface(
            child: SizedBox(
              height: 190.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: newYear,
                maximumDate: today,
                onDateTimeChanged: (date) {
                  currentDate = date;
                },
              ),
            ),
          );
        },
      ).then((_) => _setDate(currentDate));
    } else {
      showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: newYear,
        lastDate: today,
      ).then(_setDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AdaptiveTextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                label: 'Title',
              ),
              AdaptiveTextField(
                controller: _amountController,
                onSubmitted: (_) => _submitForm(),
                label: 'Amount',
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
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    AdaptiveFlatButton(onPressed: _pickDate, text: 'Select'),
                  ],
                ),
              ),
              AdaptiveRaisedButton(
                onPressed: _submitForm,
                text: 'Add Transaction',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
