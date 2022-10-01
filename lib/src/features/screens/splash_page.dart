import 'dart:convert';
import 'dart:math';

//Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:kupupu/pages/simple_animations_package.dart';

//Services
import '../services/http_service.dart';

//Model
import '../models/app_config.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    Key? key,
    required this.onInitializationComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7)).then(
      (_) => _setup(context).then(
        (_) => widget.onInitializationComplete(),
      ),
    );
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;

    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(
      AppConfig(
        BASE_API_URL: configData['BASE_API_URL'],
        BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
        API_KEY: configData['API_KEY'],
      ),
    );

    getIt.registerSingleton<HTTPService>(
      HTTPService(),
    );

    // getIt.registerSingleton<MovieService>(
    //   MovieService(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'panga++',
      home: Scaffold(
        body: ParticleBackgroundPage(),
      ),
    );
  }
}

class ParticleBackgroundPage extends StatelessWidget {
  const ParticleBackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Positioned.fill(child: AnimatedBackground()),
        Positioned.fill(child: Particles(30)),
        Positioned.fill(child: CenteredText()),
      ],
    );
  }
}

class Particles extends StatefulWidget {
  final int numberOfParticles;

  const Particles(this.numberOfParticles, {super.key});

  @override
  State<Particles> createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles.add(ParticleModel(random));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: const Duration(seconds: 30),
      onTick: _simulateParticles,
      builder: (context, time) {
        return CustomPaint(
          painter: ParticlePainter(particles, time),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    for (var particle in particles) {
      particle.maintainRestart(time);
    }
  }
}

class ParticleModel {
  late Animatable tween;
  late double size;
  late AnimationProgress animationProgress;
  Random random;

  ParticleModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final duration = Duration(milliseconds: 3000 + random.nextInt(6000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.2 + random.nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;

  ParticlePainter(this.particles, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withAlpha(50);

    for (var particle in particles) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);
      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(
          const Duration(seconds: 3),
          ColorTween(
              begin: const Color(0xff8a113a), end: Colors.lightBlue.shade900)),
      Track("color2").add(const Duration(seconds: 3),
          ColorTween(begin: const Color(0xff440216), end: Colors.blue.shade600))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, dynamic animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}

class CenteredText extends StatelessWidget {
  const CenteredText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SizedBox(
        height: 120,
      ),
      const Text(
        "Nau mai, haramai",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        textScaleFactor: 2,
      ),
      const Text(
        "ki ngā ī-kupuhū humi",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        textScaleFactor: 2,
      ),
      const Text(
        "mō tō whānau reo",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        textScaleFactor: 2,
      ),
      Image.asset("assets/images/logo.png"),
      SizedBox(
        height: 40,
      ),
    ]);
  }
}
