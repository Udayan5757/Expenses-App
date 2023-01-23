import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function handler;
  TransactionList(this.transactions,this.handler);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.6,
      child: transactions.isEmpty? Column(
        children: <Widget>[
          Text('No transaction added yet!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
          Container(
            child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,),
            //color: Colors.grey,
          ),
        ],
      )
          :ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
            child: ListTile(
              leading:
              CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(child: Text('\$${transactions[index].amount}')),
                ),
              ),
              title:Text(transactions[index].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: ()=> handler(transactions[index].id),
              ),
            ),
          );
        },
      ),
    );
  }
}
