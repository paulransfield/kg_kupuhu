import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:iconly/iconly.dart';

class CardButton extends StatelessWidget {
  final Function onTap;
  final Widget child;

  const CardButton({
    required this.onTap,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: child,
    );
  }
}

//swipe card to the right side
Widget swipeLeftButton(AppinioSwiperController controller) {
  return CardButton(
    onTap: () => controller.swipeLeft(),
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF990000),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.8),
            spreadRadius: -10,
            blurRadius: 10,
            offset: const Offset(10, 10), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.remove,
        color: CupertinoColors.white,
        size: 40,
      ),
    ),
  );
}

//unswipe card
Widget unswipeButton(AppinioSwiperController controller) {
  return CardButton(
    onTap: () => controller.unswipe(),
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFCC6600),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.8),
            spreadRadius: -10,
            blurRadius: 10,
            offset: const Offset(10, 10), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.undo,
        color: CupertinoColors.white,
        size: 40,
      ),
    ),
  );
}

//swipe card to the left side
Widget swipeRightButton(AppinioSwiperController controller) {
  return CardButton(
    onTap: () => controller.swipeRight(),
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF669900),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.8),
            spreadRadius: -10,
            blurRadius: 10,
            offset: const Offset(10, 10), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.add,
        color: CupertinoColors.white,
        size: 40,
      ),
    ),
  );
}
