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
    final title = 'Personal Expenses App';
    final homePage = MyHomePage(title: 'Personal Expenses');

    return Platform.isAndroid
        ? CupertinoApp(
            title: title,
            theme: CupertinoThemeData(
              primaryColor: CupertinoColors.systemGreen,
              primaryContrastingColor: CupertinoColors.black,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  color: CupertinoColors.black,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
            home: homePage,
          )
        : MaterialApp(
            title: title,
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
            home: homePage,
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
  var _showingChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _showTransactionForm(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
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
    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;
    final titleText = Text(widget.title);
    final PreferredSizeWidget appBar = Platform.isAndroid
        ? CupertinoNavigationBar(
            middle: titleText,
            trailing: CupertinoButton(
              onPressed: () => _showTransactionForm(context),
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.add, size: 28.0),
            ),
          )
        : AppBar(
            title: titleText,
            actions: [
              IconButton(
                onPressed: () => _showTransactionForm(context),
                icon: Icon(Icons.add),
              ),
            ],
          );
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
                        style: Platform.isAndroid
                            ? CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(fontSize: 16.0)
                            : TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(width: 8.0),
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

    return Platform.isAndroid
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
                    child: Icon(Icons.add),
                  ),
          );
  }
}
