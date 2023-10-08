import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Battery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BatteryState();
  }
}

class _BatteryState extends State<Battery> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  String _batteryLevel = 'Unknown battery level.';
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {
      _batteryLevel = batteryLevel;
      Timer.periodic(Duration(seconds: 10), (timer) {
        _getBatteryLevel();
        timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_batteryLevel);
  }
}
