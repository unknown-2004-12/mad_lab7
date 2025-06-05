import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: stopWatchApp(),
    debugShowCheckedModeBanner: false,
  ));
}
class stopWatchApp extends StatefulWidget {
  const stopWatchApp({super.key});
  @override
  State<stopWatchApp> createState() => _stopWatchAppState();
}
class _stopWatchAppState extends State<stopWatchApp> {
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  void startStopwatch() {
    if(!stopwatch.isRunning ) {
      stopwatch.start();
      timer = Timer.periodic(
        Duration(milliseconds: 50),
        (timer) {
          setState(() {});
        },
      );
    }
  }
  void stopStopwatch() {
    stopwatch.stop();
    timer?.cancel();
  }
  void resetStopwatch() {
    stopwatch.reset();
    setState(() {});
  }
  String formattedTiming(){
    final ms = stopwatch.elapsedMilliseconds;
    return "${(ms ~/ 3600000).toString().padLeft(2,'0')}:"
            "${((ms ~/ 60000) % 60).toString().padLeft(2,'0')}:" 
            "${((ms ~/ 1000) % 60).toString().padLeft(2,'0')}:"
            "${((ms % 1000) ~/ 10).toString().padLeft(2,'0')}";
  }

  @override  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedTiming(),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startStopwatch,
                  child: Text("Start", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green)
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: stopStopwatch,
                  child: Text("Stop",style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: resetStopwatch,
                  child: Text("Reset",style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,)
                ),
              ],
            )
          ],
        )
      ),
    );  
  }
}
