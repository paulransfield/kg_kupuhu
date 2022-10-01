import 'package:flutter/cupertino.dart';

class CardCandidateModel {
  String? name;
  String? job;
  String? city;
  String? image;
  LinearGradient? color;

  CardCandidateModel({
    required this.name,
    required this.job,
    required this.city,
    required this.image,
    required this.color,
  });
}

List<CardCandidateModel> candidates = [
  CardCandidateModel(
    name: 'tiaka',
    job: 'jug',
    city: 'essential 1,440',
    image: 'https://whanau.tv/eventMedia/w01826_01.gif',
    color: gradientPink,
  ),
  CardCandidateModel(
    name: 'rākau',
    job: 'tree',
    city: 'essential 1,440',
    image: 'https://whanau.tv/eventMedia/w00080_01.gif',
    color: gradientBlue,
  ),
  CardCandidateModel(
    name: 'whare',
    job: 'house',
    city: 'essential 1,440',
    image: 'https://whanau.tv/eventMedia/w00044_01.gif',
    color: gradientPurple,
  ),
  CardCandidateModel(
    name: 'moana',
    job: 'ocean',
    city: 'essential 1,440',
    image: 'https://whanau.tv/eventMedia/w00113_01.gif',
    color: gradientRed,
  ),
  CardCandidateModel(
    name: 'mōhio',
    job: 'to know',
    city: 'essential 1,440',
    image: 'https://whanau.tv/eventMedia/w02309_01.gif',
    color: gradientPink,
  ),
  CardCandidateModel(
    name: 'wheke',
    job: 'octopus',
    city: 'essential 1,440',
    image: 'https://whanau.tv/eventMedia/w01422_01.gif',
    color: gradientBlue,
  ),
  CardCandidateModel(
    name: 'marae',
    job: 'courtyard',
    city: 'essential 1,440',
    image: 'https://whanau.tv/eventMedia/w00289_01.gif',
    color: gradientPurple,
  ),
  CardCandidateModel(
    name: 'hīkoi',
    job: 'to walk',
    city: 'essential 1,440',
    image: 'https://whanau.tv/eventMedia/w02306_01.gif',
    color: gradientRed,
  ),
];

const LinearGradient gradientRed = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFFF3868),
    Color(0xFFFFB49A),
  ],
);

const LinearGradient gradientPurple = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF736EFE),
    Color(0xFF62E4EC),
  ],
);

const LinearGradient gradientBlue = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF0BA4E0),
    Color(0xFFA9E4BD),
  ],
);

const LinearGradient gradientPink = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFFF6864),
    Color(0xFFFFB92F),
  ],
);

const LinearGradient kNewFeedCardColorsIdentityGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF7960F1),
    Color(0xFFE1A5C9),
  ],
);
