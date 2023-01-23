import 'package:flutter/material.dart';
import 'transactionEntry.dart';
import 'transaction_List.dart';
import './transaction.dart';
import './chart.dart';
void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    home: myHome(),
  ));
}
class myHome extends StatefulWidget {
  @override
  State<myHome> createState() => _myHomeState();
}

class _myHomeState extends State<myHome> {
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: 'New Shoes', amount: 19.99, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Groceries', amount: 10.78, date: DateTime.now()),
    // Transaction(id: 't3', title: 'Broadband', amount: 7.34, date: DateTime.now()),
  ];
  List<Transaction> get _recentTransaction{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days:7)));
    }).toList();
  }
  void _addInformationa(String txTitle,double amnt,DateTime chosenDate){
    final newtx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: amnt,
      date: chosenDate,
    );
    setState(() {
      _userTransactions.add(newtx);
    });
  }
  void _startTranscationEntry(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        child: DataEntry(_addInformationa),
        onTap: () {},
        behavior: HitTestBehavior.opaque,
      );
    });
  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id==id;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('My Personal Expenses'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(onPressed: () {_startTranscationEntry(context);},
          icon: Icon(Icons.add),),
      ],
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 5,
                  child: Text('Your Expenses',textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
              Chart(_userTransactions),
              TransactionList(_recentTransaction,_deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _startTranscationEntry(context);
          },
          child: Icon(Icons.add),
        )
    );
  }
}

