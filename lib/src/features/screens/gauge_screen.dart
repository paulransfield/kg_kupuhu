// Packages
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeScreen extends StatefulWidget {
  const GaugeScreen({Key? key}) : super(key: key);

  @override
  _GaugeScreenState createState() => _GaugeScreenState();
}

class _GaugeScreenState extends State<GaugeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              axisLineStyle: AxisLineStyle(
                  thickness: 0.25, thicknessUnit: GaugeSizeUnit.factor),
              showTicks: false,
              showLabels: true,
              pointers: <GaugePointer>[
                RangePointer(
                    value: double.parse('$_annotationValue'),
                    onValueChanged: onPointerValueChanged,
                    enableDragging: true,
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Row(
                      children: <Widget>[
                        Text(
                          '$_annotationValue',
                          style: TextStyle(
                              fontSize: 48,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF669900)),
                        ),
                        Text(
                          ' kupu',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF669900)),
                        )
                      ],
                    ),
                    positionFactor: .9,
                    angle: 0)
              ])
        ]),
      ),
    );
  }

  void onPointerValueChanged(double value) {
    setState(() {
      final int _value = value.toInt();
      _annotationValue = '$_value';
    });
  }

  String _annotationValue = '60';
}
