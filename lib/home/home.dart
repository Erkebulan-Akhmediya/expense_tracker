import 'package:expense_tracker/home/expense.dart';
import 'package:flutter/material.dart';

import 'balance.dart';

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
              'Expense History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Column(
            children: <Widget>[
              Expense(
                imageUrl: 'https://play-lh.googleusercontent.com/TBRwjS_qfJCSj1m7zZB93FnpJM5fSpMA_wUlFDLxWAb45T9RmwBvQd5cWR5viJJOhkI',
                name: 'Netflix',
                date: 'Yesterday',
                amount: -700,
              ),
              Expense(
                imageUrl: 'https://play-lh.googleusercontent.com/bDCkDV64ZPT38q44KBEWgicFt2gDHdYPgCHbA3knlieeYpNqbliEqBI90Wr6Tu8YOw',
                name: 'PayPal',
                date: '21 Jun, 2023',
                amount: 1500,
              ),
              Expense(
                imageUrl: 'https://logosandtypes.com/wp-content/uploads/2020/11/Shopify.png',
                name: 'Shopify',
                date: '12 Jun, 2023',
                amount: 1000,
              ),
              Expense(
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