import 'dart:io';

import 'package:flutter/cupertino.dart';
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
        textTheme: const TextTheme(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        appBarTheme: const AppBarTheme(
          textTheme: const TextTheme(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  var _showingChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _showTransactionForm(BuildContext context) {
    final transactionForm = TransactionForm(
      onSubmit: (tx) {
        setState(() => _transactions.add(tx));
        Navigator.of(context).pop();
      },
    );

    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoPopupSurface(child: transactionForm),
      );
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => transactionForm,
      );
    }
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  Widget _buildAdaptiveAppBar() {
    final titleText = Text(widget.title);

    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: titleText,
            trailing: CupertinoButton(
              onPressed: () => _showTransactionForm(context),
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.add, size: 32.0),
            ),
          )
        : AppBar(
            title: titleText,
            actions: [
              IconButton(
                onPressed: () => _showTransactionForm(context),
                icon: const Icon(Icons.add),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAdaptiveAppBar();
    final bodyHeight =
        media.size.height - (media.padding.top + appBar.preferredSize.height);
    final transactionsChart = TransactionsChart(_recentTransactions);
    final transactionList = TransactionList(
      _transactions,
      deleteTx: _deleteTransaction,
    );
    final body = SafeArea(
      child: Column(
        children: [
          Container(
            height: 0.3 * bodyHeight,
            child: isLandscape
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show chart',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(width: 8.0),
                      Switch.adaptive(
                        value: _showingChart,
                        onChanged: (value) {
                          setState(() => _showingChart = value);
                        },
                      ),
                    ],
                  )
                : transactionsChart,
          ),
          Container(
            height: 0.7 * bodyHeight,
            child: isLandscape
                ? _showingChart
                    ? transactionsChart
                    : transactionList
                : transactionList,
          ),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(navigationBar: appBar, child: body)
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: isLandscape
                ? null
                : FloatingActionButton(
                    onPressed: () => _showTransactionForm(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
