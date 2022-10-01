// Packages
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import 'package:appinio_swiper/appinio_swiper.dart';
import './card_candidate_model.dart';
import './card_card.dart';
import './card_buttons.dart';

class CardSwipe extends StatefulWidget {
  const CardSwipe({
    Key? key,
  }) : super(key: key);

  @override
  State<CardSwipe> createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> {
  final AppinioSwiperController controller = AppinioSwiperController();

  List<CardCard> cards = [];

  @override
  void initState() {
    _loadCards();
    super.initState();
  }

  void _loadCards() {
    for (CardCandidateModel candidate in candidates) {
      cards.add(
        CardCard(
          candidate: candidate,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: AppinioSwiper(
              unlimitedUnswipe: true,
              controller: controller,
              unswipe: _unswipe,
              cards: cards,
              onSwipe: _swipe,
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 50,
                bottom: 40,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              swipeLeftButton(controller),
              const SizedBox(
                width: 20,
              ),
              swipeRightButton(controller),
              const SizedBox(
                width: 20,
              ),
              unswipeButton(controller),
            ],
          )
        ],
      ),
    );
  }

  void _swipe(int index, AppinioSwiperDirection direction) {
    log("the card was swiped to the: " + direction.name);
  }

  void _unswipe(bool unswiped) {
    if (unswiped) {
      log("SUCCESS: card was unswiped");
    } else {
      log("FAIL: no card left to unswipe");
    }
  }
}
