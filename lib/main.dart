import 'package:flutter/material.dart';
import 'package:my_transaction_demo/database_helper.dart';
import 'package:my_transaction_demo/transaction_model.dart';

import 'my_custom_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageStage();
  }
}

class MyHomePageStage extends State<MyHomePage> {
  late TransactionModel? transactionModel;
  int totalIncome = 0;
  int totalExpense = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction Demos',
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 110.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(120, 66, 188, 37),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Center(
              child: Text(
                '\u{20B9} ${totalIncome.toString()}',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 110.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(120, 242, 53, 70),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Center(
              child: Text(
                '\u{20B9} ${totalExpense.toString()}',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "All Transactions",
              style: TextStyle(fontSize: 20),
            ),
          ),
          FutureBuilder<List<TransactionModel>?>(
            future: DatabaseHelper.getAllTransactions(),
            builder:
                (context, AsyncSnapshot<List<TransactionModel>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  for (var item in snapshot.data!) {
                    if (item.type == "INCOME") {
                      totalIncome = totalIncome + item.amount;
                    } else {
                      totalExpense = totalExpense + item.amount;
                    }
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(120, 188, 188, 37),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].title,
                              style: TextStyle(fontSize: 22),
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snapshot.data![index].title),
                                Text(
                                  '\u{20B9} ${snapshot.data![index].amount.toString()}',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    itemCount: snapshot.data!.length,
                  );
                }
              }
              return const Center(
                child: Text('No Transactions found'),
              );
            },
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => MyCustomDialog(),
        ).then((_) => setState(() {})),
        child: Icon(Icons.add),
      ),
    );
  }
}
