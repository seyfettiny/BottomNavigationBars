import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class FloatingSelectionBottomNav extends StatefulWidget {
  const FloatingSelectionBottomNav({super.key});

  @override
  State<FloatingSelectionBottomNav> createState() =>
      _FloatingSelectionBottomNavState();
}

class _FloatingSelectionBottomNavState extends State<FloatingSelectionBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double _screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0.0,
      upperBound: 3.0,
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Icon getIcon() {
    switch (_currentIndex) {
      case 0:
        return const Icon(
          Ionicons.home,
          color: Colors.blueAccent,
        );
      case 1:
        return const Icon(
          Ionicons.search,
          color: Colors.pinkAccent,
        );
      case 2:
        return const Icon(
          Ionicons.navigate,
          color: Colors.amber,
        );
      case 3:
        return const Icon(
          Ionicons.person,
          color: Colors.deepPurpleAccent,
        );
      default:
        return const Icon(
          Ionicons.home,
          color: Colors.blueAccent,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBar().preferredSize.height + 18,
      child: Stack(
        children: [
          AnimatedPositioned(
            top: 0,
            left: (_screenWidth / 8) * (2 * _currentIndex + 1) - 28,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCirc,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(48),
              child: Container(
                color: Colors.white,
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: getIcon(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper:
                  FloatingSelectionBottomNavClipper(index: _animation.value),
              child: Container(
                color: Colors.white,
                height: AppBar().preferredSize.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    bottomBarItem(
                      icon: Ionicons.home_outline,
                      label: 'Home',
                      selected: _currentIndex == 0,
                      selectedColor: Colors.blueAccent,
                      onTap: () {
                        setState(() {
                          _animate(index: 0);
                        });
                      },
                    ),
                    bottomBarItem(
                      icon: Ionicons.search_outline,
                      label: 'Search',
                      selected: _currentIndex == 1,
                      selectedColor: Colors.pinkAccent,
                      onTap: () {
                        setState(() {
                          _animate(index: 1);
                        });
                      },
                    ),
                    bottomBarItem(
                      icon: Ionicons.navigate_outline,
                      label: 'Map',
                      selected: _currentIndex == 2,
                      selectedColor: Colors.amber,
                      onTap: () {
                        setState(() {
                          _animate(index: 2);
                        });
                      },
                    ),
                    bottomBarItem(
                      icon: Ionicons.person_outline,
                      label: 'Profile',
                      selected: _currentIndex == 3,
                      selectedColor: Colors.deepPurpleAccent,
                      onTap: () {
                        setState(() {
                          _animate(index: 3);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _animate({int index = 0}) {
    _currentIndex = index;
    _controller.animateTo(
      index.toDouble(),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCirc,
    );
  }

  Widget bottomBarItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
    required Color selectedColor,
  }) {
    return Expanded(
      child: AnimatedOpacity(
        opacity: !selected ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 400),
        child: AbsorbPointer(
          absorbing: selected,
          child: InkWell(
            onTap: onTap,
            child: Icon(
              icon,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class FloatingSelectionBottomNavClipper extends CustomClipper<Path> {
  double index;
  FloatingSelectionBottomNavClipper({this.index = 0});

  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(
        (size.width / 8) * (2 * index + 1) - 60,
        0,
      )
      ..cubicTo(
        (size.width / 8) * (2 * index + 1) - 40,
        0,
        (size.width / 8) * (2 * index + 1) - 30,
        10,
        (size.width / 8) * (2 * index + 1) - 30,
        20,
      )
      ..cubicTo(
        (size.width / 8) * (2 * index + 1) - 20,
        50,
        (size.width / 8) * (2 * index + 1) + 20,
        50,
        (size.width / 8) * (2 * index + 1) + 30,
        20,
      )
      ..cubicTo(
        (size.width / 8) * (2 * index + 1) + 30,
        0,
        (size.width / 8) * (2 * index + 1) + 60,
        0,
        (size.width / 8) * (2 * index + 1) + 60,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
