import 'package:flutter/material.dart';
import 'native_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Info App',
      theme: ThemeData.dark(),
      home: const DeviceInfoScreen(),
    );
  }
}

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  String currentTime = '--:--:--';
  int batteryLevel = 0;
  int totalSpace = 0;
  int freeSpace = 0;

  @override
  void initState() {
    super.initState();

    // Clock stream
    NativeServices.clockStream().listen((time) {
      setState(() => currentTime = time);
    });

    // Battery and Storage
    loadDeviceData();
  }

  Future<void> loadDeviceData() async {
    final battery = await NativeServices.getBatteryLevel();
    final storage = await NativeServices.getStorageInfo();

    setState(() {
      batteryLevel = battery;
      totalSpace = storage["total"] ~/ (1024 * 1024 * 1024);
      freeSpace = storage["free"] ~/ (1024 * 1024 * 1024);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Native Info')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🕒 Time: $currentTime', style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            Text(
              '🔋 Battery: $batteryLevel%',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              '💾 Free: $freeSpace GB',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              '💽 Total: $totalSpace GB',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
