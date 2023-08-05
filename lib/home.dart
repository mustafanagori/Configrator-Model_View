import 'package:configrator/car.dart';
import 'package:configrator/cupApp.dart';
import 'package:flutter/material.dart';

import 'cupWeb.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          centerTitle: true,
          title: const Text("Darul Solution"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const DS()));
                  },
                  child: const Center(
                      child: Text(
                    'Cup AppView',
                    style: TextStyle(fontSize: 20),
                  ))),
            ),
            Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cup()));
                  },
                  child: const Center(
                      child: Text(
                    'Cup Web View ',
                    style: TextStyle(fontSize: 20),
                  ))),
            ),
            Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Car()));
                  },
                  child: const Center(
                      child: Text(
                    'Car Model Viewer ',
                    style: TextStyle(fontSize: 20),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
