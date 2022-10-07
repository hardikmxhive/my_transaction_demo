import 'package:flutter/material.dart';
import 'package:my_transaction_demo/database_helper.dart';
import 'package:my_transaction_demo/transaction_model.dart';

class MyCustomDialog extends StatefulWidget {
  MyCustomDialog({Key? key}) : super(key: key);

  @override
  _MyCustomDialogState createState() =>
      _MyCustomDialogState(transactionModel: null);
}

class _MyCustomDialogState extends State<MyCustomDialog> {
  String radioButtonItem = 'INCOME';
  int id = 1;
  late TransactionModel? transactionModel;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  //final typeController = TextEditingController();

  _MyCustomDialogState({required this.transactionModel});

  @override
  Widget build(BuildContext context) {
    if (transactionModel != null) {
      titleController.text = transactionModel!.title;
      descriptionController.text = transactionModel!.description;
      amountController.text = transactionModel!.amount as String;
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter Transaction',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter Title',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter Description',
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Amount',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'INCOME';
                        id = 1;
                      });
                    },
                  ),
                  const Text(
                    'INCOME',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  Radio(
                    value: 2,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'EXPENSE';
                        id = 2;
                      });
                    },
                  ),
                  const Text(
                    'EXPENSE',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  final TransactionModel model = TransactionModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      amount: int.parse(amountController.text),
                      type: radioButtonItem);

                  DatabaseHelper.addTransaction(model);
                  Navigator.pop(context);
                },
                child: Text(radioButtonItem),
              )
            ],
          ),
        ),
      ),
    );
  }
}
