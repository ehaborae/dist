
import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key,}) : super(key: key);


  @override
  State<MyHomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  int counter = 0;
  String _createMatrix = '';
  String _delay = '';

  Future<dynamic> future() async {
    Completer completer = Completer();
    print('start delay');
    Future.delayed(Duration(seconds: 10), () {
      completer.complete('delayed call $counter');
    });
    return completer.future;
  }

  Future<dynamic> lopList() async {
    Completer completer = Completer();
    print('start create matrix');
    Future.delayed(Duration(seconds: 1), () {
      List<List<int>> matrix = <List<int>>[];
      for (var i = 0; i < 10000; i++) {
        List<int> list = <int>[];

        for (var j = 0; j < 10000; j++) {
          list.add(j);
        }
        matrix.add(list);
      }
      completer.complete('matrix done $counter');
    });

    return completer.future;
  }

  void _incrementCounter() {
    future().then((value) {
      _delay = value;
      setState(() {});
      print(value);
    });

    lopList().then((value) {
      _createMatrix = value;
      setState(() {});
      print(value);
    });

    counter++;
    print(counter);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Click the button to start testing.',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'create matrix : $_createMatrix',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'delay : $_delay',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.not_started),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}