import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DataEntry extends StatefulWidget {
  final Function handler;

  DataEntry(this.handler);

  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _onSubmitData(){
    if(amountInput.text.isEmpty) return;
    final enteredTitle = titleInput.text;
    final enteredAmount = double.parse(amountInput.text);
    if(enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate==null) return;
    widget.handler(enteredTitle,enteredAmount,_selectedDate);
    Navigator.of(context).pop();
  }
  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate==null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(decoration: InputDecoration(labelText: 'Title'),
                controller: titleInput,
                onSubmitted: (_) => _onSubmitData,
              ),
              TextField(decoration: InputDecoration(labelText: 'Amount'),
                controller: amountInput,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _onSubmitData,
              ),
              SizedBox(height: 15,),
              Row(
                children: <Widget>[
                  Text((_selectedDate==null)?'No date choosen':DateFormat.yMd().format(_selectedDate)),
                  SizedBox(width: 20,),
                  TextButton(onPressed:
                  _presentDatePicker,
                      child: Text('Chose Date',style: TextStyle(fontWeight: FontWeight.bold),)),
                ],
              ),
              ElevatedButton(onPressed: _onSubmitData,
                child: Text('Add Transaction',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
            ],
          ),
        ),
      ),
    );
  }
}
