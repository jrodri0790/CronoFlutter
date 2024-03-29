import 'dart:async';
import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  var timer = new TimerWidget();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new Scaffold(
      body: new Center(child: timer),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          timer.timerState.startChrono();
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.play_arrow),
      ),
    ));
  }
}

class TimerWidget extends StatefulWidget {
  final timerState = new TimerWidgetState();

  @override
  TimerWidgetState createState() {
    return timerState;
  }
}

class TimerWidgetState extends State<TimerWidget> {
  int _startTime = new DateTime.now().millisecondsSinceEpoch;
  int _numMilliseconds = 0;
  int _numSeconds = 0;
  int _numMinutes = 0;
  int _savedTime = 0;
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return new Text(
      sprintf("%02d:%02d:%2d", [_numMinutes, _numSeconds, _numMilliseconds]),
    );
  }

  @override
  void initState() {
    super.initState();
//    startChrono();
  }

  void startChrono() {
    _isEnable = !_isEnable;
    Timer.periodic(new Duration(milliseconds: 10), (Timer timer) {
      if (_isEnable) {
        _startTime = _savedTime == 0 ? new DateTime.now().millisecondsSinceEpoch : _savedTime;
        int timeDifference = new DateTime.now().millisecondsSinceEpoch - _startTime;
        double seconds = timeDifference / 1000;
        double minutes = seconds / 60;
        double leftoverSeconds = seconds % 60;
        double leftoverMillis = timeDifference % 1000 / 10;
        setState(() {
          _numMilliseconds = leftoverMillis.floor();
          _numSeconds = leftoverSeconds.floor();
          _numMinutes = minutes.floor();
          _savedTime = _startTime;
        });
      }
    });
  }
}
