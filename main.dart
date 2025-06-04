import 'dart:async'; // For Timer
import 'package:flutter/material.dart'; // Flutter Material library

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Hide debug banner
    home: StopwatchApp(), // Set StopwatchApp as home screen
    ),
  );
}

class StopwatchApp extends StatefulWidget {
  const StopwatchApp({super.key});
  @override
  State<StopwatchApp> createState() => _StopwatchAppState(); // Link to state
}

class _StopwatchAppState extends State<StopwatchApp> {
  Stopwatch _stopwatch = Stopwatch(); // Built-in stopwatch utility
  Timer? _timer; // Timer to update UI every few milliseconds

  // Starts the stopwatch and updates the screen regularly
  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start(); // Start stopwatch
      _timer = Timer.periodic(
        Duration(milliseconds: 50), // Update UI every 50ms
        (timer) => setState(() {}), // Refresh UI
      );
    }
  }

  // Stops the stopwatch
  void _stopStopwatch() {
    _stopwatch.stop(); // Pause stopwatch
    _timer?.cancel(); // Stop UI updates
  }

  // Resets stopwatch to zero
  void _resetStopwatch() {
    _stopwatch.reset(); // Reset stopwatch
    setState(() {}); // Refresh UI
  }

  // Formats time into hh:mm:ss:ms
  String _formattedTime() {
    final ms = _stopwatch.elapsedMilliseconds;
    return "${(ms ~/ 3600000).toString().padLeft(2, '0')}:" // hours
           "${((ms ~/ 60000) % 60).toString().padLeft(2, '0')}:" // minutes
           "${((ms ~/ 1000) % 60).toString().padLeft(2, '0')}:" // seconds
           "${((ms % 1000) ~/ 10).toString().padLeft(2, '0')}"; // hundredths
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stopwatch"), centerTitle: true,), // App bar title
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            Text(
              _formattedTime(), // Show formatted stopwatch time
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30), // Spacing

            // Row of Start, Stop, Reset buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var btn in ["Start", "Stop", "Reset"]) // Loop through buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: btn == "Start"
                          ? _startStopwatch
                          : btn == "Stop"
                              ? _stopStopwatch
                              : _resetStopwatch, // Call appropriate function
                      child: Text(btn), // Button label
                      style: ElevatedButton.styleFrom(
                        backgroundColor: btn == "Start"
                            ? Colors.green
                            : btn == "Stop"
                                ? Colors.red
                                : Colors.blue, // Button color
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
