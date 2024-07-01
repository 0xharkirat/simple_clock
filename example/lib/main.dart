import 'package:flutter/material.dart';
import 'package:flutter_clock/flutter_clock.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clock Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FlutterClock Example'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterClock _flutterClock;
  late DateTime _currentTime;

  // initialize the clock & stream
  @override
  void initState() {
    super.initState();
    _flutterClock = FlutterClock();
    _currentTime = _flutterClock.getCurrentTime();
    _flutterClock.timeStream.listen((event) {
      setState(() {
        _currentTime = event;
      });
    });
  }


  @override
  void dispose() {
    _flutterClock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentTime = DateFormat('HH:mm:ss').format(_currentTime);
    final String today = DateFormat("yMMMMEEEEd").format(_currentTime);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentTime,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              today,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}