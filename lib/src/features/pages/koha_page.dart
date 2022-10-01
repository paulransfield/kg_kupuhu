// Packages
import 'package:flutter/material.dart';
import './tile_swipeable.dart';

class KohaScreen extends StatelessWidget {
  const KohaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('./assets/images/maunga.gif'),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const Learn2Screen();
              }),
            );
          },
          child: Text(
            'e hia ...',
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
