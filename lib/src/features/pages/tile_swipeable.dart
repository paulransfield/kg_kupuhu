// Packages
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:vibration/vibration.dart';

class Learn2Screen extends StatefulWidget {
  const Learn2Screen({Key? key}) : super(key: key);

  @override
  _Learn2ScreenState createState() => _Learn2ScreenState();
}

class _Learn2ScreenState extends State<Learn2Screen> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const ClampingScrollPhysics(),
      children: const <Widget>[
//        NormalScreen(),
        CardScreen(),
        ChatReplyScreen(),
      ],
    );
  }
}

class NormalScreen extends StatefulWidget {
  const NormalScreen({Key? key}) : super(key: key);

  @override
  _NormalScreenState createState() => _NormalScreenState();
}

class _NormalScreenState extends State<NormalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Swipeable list'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: persons
            .map(
              (Person person) => SwipeableTile(
                color: Colors.white,
                swipeThreshold: 0.2,
                direction: SwipeDirection.horizontal,
                isElevated: false,
                borderRadius: 0,
                onSwiped: (_) {
                  // final index = persons.indexOf(person);

                  // setState(() {
                  //   persons.removeAt(index);
                  // });
                },
                backgroundBuilder: (
                  _,
                  SwipeDirection direction,
                  AnimationController progress,
                ) {
                  if (direction == SwipeDirection.endToStart) {
                    return Container(color: Colors.red);
                  } else if (direction == SwipeDirection.startToEnd) {
                    return Container(color: Colors.blue);
                  }
                  return Container();
                },
                key: UniqueKey(),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: Image.network(person.imageURL),
                  ),
                  title: Text(
                    person.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text('${person.state} ${person.streetAddress}'),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class CardScreen extends StatefulWidget {
  const CardScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Card Tile'),
      ),
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        ...persons.map(
          (Person person) => SwipeableTile.card(
            color: const Color(0xFFFFFFFFF),
            shadow: BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
            horizontalPadding: 16,
            verticalPadding: 8,
            direction: SwipeDirection.horizontal,
            onSwiped: (_) {
              // final index = persons.indexOf(person);

              // setState(() {
              //   persons.removeAt(index);
              // });
            },
            backgroundBuilder:
                (_, SwipeDirection direction, AnimationController progress) {
              return AnimatedBuilder(
                animation: progress,
                builder: (_, __) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    color: progress.value > 0.4
                        ? const Color(0xFFed7474)
                        : const Color(0xFFeded98),
                  );
                },
              );
            },
            key: UniqueKey(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: Image.network(person.imageURL)),
                title: Text(
                  person.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
                subtitle: Text(
                  '${person.state} ${person.city}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class ChatReplyScreen extends StatefulWidget {
  const ChatReplyScreen({Key? key}) : super(key: key);

  @override
  _ChatReplyScreenState createState() => _ChatReplyScreenState();
}

class _ChatReplyScreenState extends State<ChatReplyScreen> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  Person? _selectedPerson;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Swipe To Reply',
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(children: <Widget>[
              ...persons.map(
                (Person person) => SwipeableTile.swipeToTrigger(
                  behavior: HitTestBehavior.translucent,
                  isElevated: false,
                  color: Colors.white,
                  swipeThreshold: 0.2,
                  direction: SwipeDirection.endToStart,
                  onSwiped: (_) {
                    _focusNode.requestFocus();
                    setState(() {
                      _selectedPerson = person;
                    });
                  },
                  backgroundBuilder: (
                    _,
                    SwipeDirection direction,
                    AnimationController progress,
                  ) {
                    bool vibrated = false;
                    return AnimatedBuilder(
                      animation: progress,
                      builder: (_, __) {
                        if (progress.value > 0.9999 && !vibrated) {
                          Vibration.vibrate(duration: 40);
                          vibrated = true;
                        } else if (progress.value < 0.9999) {
                          vibrated = false;
                        }
                        return Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Transform.scale(
                              scale: Tween<double>(
                                begin: 0.0,
                                end: 1.2,
                              )
                                  .animate(
                                    CurvedAnimation(
                                      parent: progress,
                                      curve: const Interval(0.5, 1.0,
                                          curve: Curves.linear),
                                    ),
                                  )
                                  .value,
                              child: Icon(
                                Icons.reply,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  key: UniqueKey(),
                  child: MessageBubble(
                    url: person.imageURL,
                    message: person.message,
                    name: person.name,
                  ),
                ),
              ),
            ]),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                color: Colors.grey.shade200.withOpacity(0.5),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: <Widget>[
                      _selectedPerson != null
                          ? Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.reply_rounded,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _selectedPerson!.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          _selectedPerson!.message,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedPerson = null;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onSubmitted: (_) {
                          _focusNode.canRequestFocus;
                        },
                        decoration: InputDecoration(
                          // filled: true,
                          // fillColor: Color(0xFFe8e6d5)
                          contentPadding: const EdgeInsets.all(16),
                          hintText: 'Type your message',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {},
                          ),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide.none),
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide.none),

                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String name;
  final String message;
  final String url;
  const MessageBubble({
    Key? key,
    required this.message,
    required this.name,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(48),
            child: Image.network(
              url,
              width: 48,
              height: 48,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xFFa1ffb7),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0xFF457d52)),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(message),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

List<Person> persons = <Person>[
  Person(
      name: 'hunga - group of people ',
      city: '',
      state: 'essential 14,440',
      streetAddress: '',
      imageURL: 'https://whanau.tv/eventMedia/w00123_01.gif',
      message: 'hunga - group of people'),
  Person(
      name: 'moana - ocean',
      city: '',
      state: 'essential 14,440',
      streetAddress: '',
      imageURL: 'https://whanau.tv/eventMedia/w00113_01.gif',
      message:
          'I wan\'t to sleep more don\'t wake me up. I will stay awake all night I promise.'),
  Person(
      name: 'anuhi - catepillar',
      city: '',
      state: 'essential 14,440',
      streetAddress: '',
      imageURL: 'https://whanau.tv/eventMedia/w02637_01.gif',
      message:
          'What happened? Everyone is alright? I was under the blanket. It was so dark I can\'t believe.'),
  Person(
      name: 'whara - to be injured',
      city: '',
      state: 'essential 14,440',
      streetAddress: '',
      imageURL: 'https://whanau.tv/eventMedia/w02329_01.gif',
      message: 'I can\'t believe how much I am happy to see you.'),
  Person(
      name: 'whetū - star',
      city: '',
      state: 'essential 14,440',
      streetAddress: '',
      imageURL: 'https://whanau.tv/eventMedia/w00577_01.gif',
      message: 'Who wants to play with me? I am ready now.'),
];

class Person {
  final String name;
  final String city;
  final String streetAddress;
  final String state;
  final String imageURL;
  final String message;

  Person({
    required this.name,
    required this.city,
    required this.state,
    required this.streetAddress,
    required this.imageURL,
    required this.message,
  });
}
