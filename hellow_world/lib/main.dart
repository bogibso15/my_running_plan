import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World App',
      home: const BatteryHome(),
    );
  }
}

class BatteryHome extends StatefulWidget {
  const BatteryHome({super.key});

  @override
  State<BatteryHome> createState() => _BatteryHomeState();
}

class _BatteryHomeState extends State<BatteryHome> {
  final Battery _battery = Battery();
  int? _batteryLevel;
  String? _status;

  Future<void> _showBatteryLevel() async {
    if (kIsWeb) {
      setState(() {
        _batteryLevel = null;
        _status = 'Battery API is not supported on web. Run on a device.';
      });
      return;
    }

    try {
      final level = await _battery.batteryLevel;
      setState(() {
        _batteryLevel = level;
        _status = null;
      });
    } catch (e) {
      setState(() {
        _batteryLevel = null;
        _status = 'Failed to get battery level.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello World/Testing App')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hello world',
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onBackground,
             //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _status ??
                  (_batteryLevel == null ? '' : 'Battery: $_batteryLevel%'),
                    style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _showBatteryLevel,
              child: const Text('Show Battery'),
            ),
          ],
        ),
      ),
    );
  }
}
