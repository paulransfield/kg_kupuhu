// Packages
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _getRadialGauge() {
    return SfRadialGauge(
        title: GaugeTitle(
            text: 'My kupu counter',
            textStyle:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 15000, ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 3000,
                color: Colors.red,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 3000,
                endValue: 9000,
                color: Colors.orange,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 9000,
                endValue: 15000,
                color: Colors.green,
                startWidth: 10,
                endWidth: 10)
          ], pointers: <GaugePointer>[
            NeedlePointer(value: 1200)
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    child: const Text('1200 kupu',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
                angle: 90,
                positionFactor: 0.5)
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getRadialGauge());
  }
}
