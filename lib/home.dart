import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Good afternoon,',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              'Yerkebulan',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          const Balance(),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
              bottom: 20,
              left: 3,
            ),
            child: const Text(
              'Transactions History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.blue,
        ),
        child: const Column(
          children: [
            TotalBalance(),
            IncomeExpenses(),
          ],
        ),
      ),
    );
  }

}

class TotalBalance extends StatelessWidget {
  const TotalBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Balance'),
              Text(
                '\$2500',
                style: TextStyle(
                  fontSize: 45,
                ),
              ),
            ],
          ),
        )
    );
  }

}

class IncomeExpenses extends StatelessWidget {
  const IncomeExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Income'),
                  Text(
                    '\$1800',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(right: 15),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('Expenses'),
                  Text(
                    '\$284',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

}