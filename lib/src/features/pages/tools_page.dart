// Packages
import 'package:flutter/material.dart';

//Pages
import './video_page.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const ChewieDemo();
              }),
            );
          },
          child: Text(
            'he aha ...',
            style: DefaultTextStyle.of(context).style.apply(
                fontSizeFactor: 2.0,
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(1.0)),
          ),
        ),
      ],
    );
  }
}
