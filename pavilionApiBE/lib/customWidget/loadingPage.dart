import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green[600],
        child: Center(
          child: Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.white),
        ),
      );
  }
}
