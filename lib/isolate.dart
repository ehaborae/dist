import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController rotationController;
  late Animation<double> animation;
  List<int> results = [];

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 1.0).animate(rotationController);
    rotationController.forward(from: 0.0);
    //loop the animation for clarity
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Isolate Demo"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: RotationTransition(
              turns: animation,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.orange,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          MaterialButton(
            color: Colors.red,
            onPressed: () {
              setState(() {
                final result = calculation(42);
                print(result);
                results.add(result);
              });
            },
            child: const Text(
              "test (42) in the same thread",
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () async {
              final result = await compute(calculation, 42);
              setState(() {
                results.add(result);
                print(result);
              });
            },
            child: const Text(
              "test (42) in parallel thread",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "Number of results: ${results.length.toString()}",
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          MaterialButton(
            color: Colors.black54,
            onPressed: () async {
              final result = await compute(calculation, 42);
              setState(() {


              });
            },
            child: const Text(
              "Stop Sliding",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

int calculation(int n) {
  if (n < 2) {
    return n;
  }
  return calculation(n - 2) + calculation(n - 1);
}
