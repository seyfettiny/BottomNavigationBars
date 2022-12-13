import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:math' as math;

class BlobMenu extends StatefulWidget {
  const BlobMenu({super.key});

  @override
  State<BlobMenu> createState() => _BlobMenuState();
}

class _BlobMenuState extends State<BlobMenu> with TickerProviderStateMixin {
  final double _screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  bool isSelected = false;
  late AnimationController _animationController;
  late Animation<double> _translationAnimation;

  List<Icon> icons = [
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

  List<AnimatedPositioned> blobMenuItems = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _translationAnimation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    )..addListener(() {
        setState(() {});
      });
  }

  Widget _menuItemBuilder(int angle, int index) {
    return Positioned(
      bottom: 20,
      left: _screenWidth / 2 - 32,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final double rad = angle * (math.pi / 180.0);
          final double c = 50;
          double t = (1.0 - (1 + c)) / 2.0 * 255;
          return Transform(
            transform: Matrix4.identity()
              ..translate(
                (_translationAnimation.value) * math.cos(rad),
                -(_translationAnimation.value) * math.sin(rad),
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
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix([
                  1 + c,
                  0,
                  0,
                  0,
                  t,
                  0,
                  1 + c,
                  0,
                  0,
                  t,
                  0,
                  0,
                  1 + c,
                  0,
                  t,
                  0,
                  0,
                  0,
                  1,
                  0,
                ]),
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: icons[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBar().preferredSize.height + 108,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...icons
              .map((icon) => _menuItemBuilder(
                  195 - ((icons.indexOf(icon) + 1) * 42), icons.indexOf(icon)))
              .toList(),
          Positioned(
            bottom: 18,
            left: _screenWidth / 2 - 35,
            height: 70,
            width: 70,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                    isSelected
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.view_list,
                  size: 36,
                  color: Colors.green.shade600,
                  progress: _animationController,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: BlobMenuClipper(),
              child: Container(
                height: AppBar().preferredSize.height,
                color: Colors.white,
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
          )
        ],
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
