import './chart_bar.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';
class Chart extends StatelessWidget {
  final List<Transaction> recentTranscations;
  Chart(this.recentTranscations);


  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum=0.0;
      for(var i=0;i<recentTranscations.length;i++){
        if(recentTranscations[i].date.day==weekDay.day &&
            recentTranscations[i].date.month==weekDay.month &&
            recentTranscations[i].date.year==weekDay.year){
          totalSum+=recentTranscations[i].amount;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {'day':DateFormat.E().format(weekDay).substring(0,1),'amount':totalSum};
    }).reversed.toList();
  }
  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
          groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar((data['day'] as String), (data['amount'] as double),
                  totalSpending==0.0?0.0:(data['amount'] as double)/totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
