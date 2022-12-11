import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:ui' as ui;

class LampBottomNav extends StatefulWidget {
  const LampBottomNav({super.key});

  @override
  State<LampBottomNav> createState() => _LampBottomNavState();
}

class _LampBottomNavState extends State<LampBottomNav> {
  //TODO: Since it is final, can be problematic when the screen size changes.
  final double _screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  int _currentIndex = 0;
  double widthOfRay = 64;
  late double left;

  @override
  void initState() {
    left = (_screenWidth / 8) - widthOfRay / 2;
    super.initState();
  }

  void animate(BuildContext context) {
    setState(() {
      left = (_screenWidth / 8) * (_currentIndex * 2 + 1) - widthOfRay / 2;
    });
  }

  Color getColor() {
    switch (_currentIndex) {
      case 0:
        return Colors.blueAccent;
      case 1:
        return Colors.pinkAccent;
      case 2:
        return Colors.amber;
      case 3:
        return Colors.deepPurpleAccent;
      default:
        return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height,
      color: Colors.black87,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            left: left,
            top: 1,
            height: AppBar().preferredSize.height,
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Container(
                    height: 5,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: CustomPaint(
                    size: Size(widthOfRay, AppBar().preferredSize.height),
                    painter: RayPainter(color: getColor()),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bottomBarItem(
                icon: Ionicons.home_outline,
                selected: _currentIndex == 0,
                selectedColor: Colors.blueAccent.shade100,
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                    animate(context);
                  });
                },
              ),
              bottomBarItem(
                icon: Ionicons.search_outline,
                selected: _currentIndex == 1,
                selectedColor: Colors.pinkAccent.shade100,
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                    animate(context);
                  });
                },
              ),
              bottomBarItem(
                icon: Ionicons.navigate_outline,
                selected: _currentIndex == 2,
                selectedColor: Colors.amber.shade100,
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                    animate(context);
                  });
                },
              ),
              bottomBarItem(
                icon: Ionicons.person_outline,
                selected: _currentIndex == 3,
                selectedColor: Colors.deepPurpleAccent.shade100,
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                    animate(context);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomBarItem({
    required IconData icon,
    String? label,
    required bool selected,
    required Color selectedColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selected ? selectedColor : Colors.grey,
          ),
          if (label != null)
            Text(
              label,
              style: TextStyle(
                color: selected ? selectedColor : Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}

class RayPainter extends CustomPainter {
  RayPainter({required this.color});
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..shader =
          ui.Gradient.linear(const Offset(0, 0), Offset(0, size.height), [
        color.withAlpha(200),
        color.withAlpha(0),
      ]);

    final Path path = Path()
      ..moveTo(12, 0)
      ..lineTo(52, 0)
      ..lineTo(64, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
