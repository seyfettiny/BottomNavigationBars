import 'package:bottomnavigationbars/util/blob.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:math' as math;

import 'package:umbra_flutter/umbra_flutter.dart';

class BlobMenu extends StatefulWidget {
  const BlobMenu({super.key});

  @override
  State<BlobMenu> createState() => _BlobMenuState();
}

//umbra generate assets/shaders/blob.glsl --output lib/util/ -t flutter-widget
class _BlobMenuState extends State<BlobMenu> with TickerProviderStateMixin {
  final double _screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  bool isSelected = false;
  late AnimationController _animationController;
  late Animation<double> _translationAnimation;

  late final _itemSlideTime;
  late final _initialDelayTime;
  late final _staggerDuration;
  late final _animationDuration;
  final List<Interval> _itemSlideIntervals = [];

  final List<Icon> _icons = [
    const Icon(
      Ionicons.attach,
      color: Colors.blueAccent,
    ),
    const Icon(
      Ionicons.phone_portrait,
      color: Colors.pinkAccent,
    ),
    const Icon(
      Ionicons.file_tray,
      color: Colors.amber,
    ),
    const Icon(
      Ionicons.settings,
      color: Colors.deepPurpleAccent,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _initialDelayTime = const Duration(milliseconds: 500);
    _itemSlideTime = const Duration(milliseconds: 500);
    _staggerDuration = const Duration(milliseconds: 500);
    _animationDuration = _initialDelayTime + (_staggerDuration * _icons.length);

    for (int i = 0; i < _icons.length; ++i) {
      final startTime = _initialDelayTime + (_staggerDuration * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
          curve: Curves.decelerate));
    }

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _translationAnimation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut),
    )..addListener(() {
        setState(() {});
      });
  }

  Widget _menuItemBuilder(int angle, int index) {
    return Positioned(
      bottom: 25,
      left: _screenWidth / 2 - 32,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final double rad = angle * (math.pi / 180.0);
          final animationPercent = Curves.easeOutCubic.transform(
            _itemSlideIntervals.reversed
                .toList()[index]
                .transform(_animationController.value),
          );
          final slideDistance = (1.0 - animationPercent) * 100;
          return Transform(
            transform: Matrix4.identity()
              ..translate(
                (slideDistance) * math.cos(rad),
                -(slideDistance) * math.sin(rad),
              ),
            child: InkWell(
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                  isSelected
                      ? _animationController.forward()
                      : _animationController.reverse();
                });
              },
              child: Container(
                height: 64,
                width: 64,
                decoration: const BoxDecoration(
                  color: Color(0xff292E49),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: _icons[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Vector2 _getTranslationValue(int index, int angle) {
    final double rad = angle * (math.pi / 180.0);
    final animationPercent = Curves.easeOutCubic.transform(
      _itemSlideIntervals.reversed
          .toList()[index]
          .transform(_animationController.value),
    );
    final slideDistance = (1.0 - animationPercent) * 100;
    var normalizationFactor = 0.00185;

    return Vector2(
      (slideDistance) * math.sin(rad) * normalizationFactor,
      (slideDistance) * math.cos(rad) * normalizationFactor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBar().preferredSize.height + 108,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -70,
            child: Container(
              height: 500,
              width: _screenWidth,
              color: const Color(0xff292E49),
              child: Blob(
                scale: 14.0 -
                    2 *
                        (1 -
                            _itemSlideIntervals[2]
                                .transform(_animationController.value)),
                blendMode: BlendMode.plus,
                uResolution: Vector2(_screenWidth, 500),
                metaball1: Vector2(0.5, 0.7),
                metaball2: Vector2(0.5, 0.7) - _getTranslationValue(0, 65),
                metaball3: Vector2(0.5, 0.7) - _getTranslationValue(1, 22),
                metaball4: Vector2(0.5, 0.7) - _getTranslationValue(2, -22),
                metaball5: Vector2(0.5, 0.7) - _getTranslationValue(3, -64),
              ),
            ),
          ),
          ..._icons
              .map((icon) => _menuItemBuilder(
                  195 - ((_icons.indexOf(icon) + 1) * 42),
                  _icons.indexOf(icon)))
              .toList(),
          Positioned(
            bottom: 25,
            left: _screenWidth / 2 - 35,
            height: 70,
            width: 70,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff292E49),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                    isSelected
                        ? _animationController.reverse()
                        : _animationController.forward();
                  });
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  size: 36,
                  color: Colors.green.shade600,
                  progress: _animationController,
                ),
              ),
            ),
          ),
          _buildMenu()
        ],
      ),
    );
  }

  Positioned _buildMenu() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: BlobMenuClipper(),
        child: Container(
          height: AppBar().preferredSize.height,
          color: const Color(0xff292E49),
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: const Icon(
                    Ionicons.home,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(
                    Ionicons.search,
                    color: Colors.pinkAccent,
                  ),
                  onPressed: () {},
                ),
              ),
              const Expanded(
                child: SizedBox.square(
                  dimension: 36,
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(
                    Ionicons.navigate,
                    color: Colors.amber,
                  ),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(
                    Ionicons.person,
                    color: Colors.deepPurpleAccent,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlobMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(
        (size.width / 2) - 70,
        0,
      )
      ..cubicTo(
        (size.width / 2) - 50,
        0,
        (size.width / 2) - 45,
        10,
        (size.width / 2) - 40,
        20,
      )
      ..cubicTo(
        (size.width / 2) - 20,
        50,
        (size.width / 2) + 20,
        50,
        (size.width / 2) + 40,
        20,
      )
      ..cubicTo(
        (size.width / 2) + 50,
        0,
        (size.width / 2) + 75,
        0,
        (size.width / 2) + 80,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
