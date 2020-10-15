import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/transaction_form.dart';
import 'widgets/transaction_list.dart';
import 'widgets/transactions_chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColorBrightness: Brightness.light,
        accentColor: Colors.deepPurple.shade200,
        fontFamily: 'Quicksand',
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _showTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: (tx) {
            setState(() => _transactions.add(tx));
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          onPressed: () => _showTransactionForm(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    final media = MediaQuery.of(context);
    final bodyHeight =
        media.size.height - (media.padding.top + appBar.preferredSize.height);

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Container(
            height: 0.3 * bodyHeight,
            child: TransactionsChart(_recentTransactions),
          ),
          Container(
            height: 0.7 * bodyHeight,
            child: TransactionList(
              _transactions,
              deleteTx: _deleteTransaction,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
