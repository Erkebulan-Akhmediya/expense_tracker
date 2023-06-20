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
          const Column(
            children: <Widget>[
              Transaction(
                imageUrl: 'https://play-lh.googleusercontent.com/TBRwjS_qfJCSj1m7zZB93FnpJM5fSpMA_wUlFDLxWAb45T9RmwBvQd5cWR5viJJOhkI',
                name: 'Netflix',
                date: 'Yesterday',
                amount: -700,
              ),
              Transaction(
                imageUrl: 'https://play-lh.googleusercontent.com/bDCkDV64ZPT38q44KBEWgicFt2gDHdYPgCHbA3knlieeYpNqbliEqBI90Wr6Tu8YOw',
                name: 'PayPal',
                date: '21 Jun, 2023',
                amount: 1500,
              ),
              Transaction(
                imageUrl: 'https://logosandtypes.com/wp-content/uploads/2020/11/Shopify.png',
                name: 'Shopify',
                date: '12 Jun, 2023',
                amount: 1000,
              ),
              Transaction(
                imageUrl: 'https://play-lh.googleusercontent.com/UrY7BAZ-XfXGpfkeWg0zCCeo-7ras4DCoRalC_WXXWTK9q5b0Iw7B0YQMsVxZaNB7DM',
                name: 'Shopify',
                date: '01 Jun, 2023',
                amount: -1200,
              ),
            ],
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

class Transaction extends StatefulWidget {
  const Transaction({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.date,
    required this.amount,
  });

  final String imageUrl;
  final String name;
  final String date;
  final int amount;

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image(
                    width: 60,
                    height: 60,
                    image: NetworkImage(widget.imageUrl),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.date),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TransactionAmount(
                  amount: widget.amount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionAmount extends StatefulWidget {
  const TransactionAmount({
    super.key,
    required this.amount,
  });

  final int amount;

  @override
  State<StatefulWidget> createState() => _TransactionAmountState();
}

class _TransactionAmountState extends State<TransactionAmount> {
  String sign(int num) {
    if (num > 0) {
      return '+';
    } else {
      return '';
    }
  }

  Color colors(int num) {
    if (num > 0) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      sign(widget.amount) + widget.amount.toString(),
      style: TextStyle(
        color: colors(widget.amount),
        fontSize: 20,
      ),
    );
  }

}