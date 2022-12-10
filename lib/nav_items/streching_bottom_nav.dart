import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class StrechingBottomNavWithSizing extends StatefulWidget {
  const StrechingBottomNavWithSizing({Key? key}) : super(key: key);

  @override
  State<StrechingBottomNavWithSizing> createState() =>
      _StrechingBottomNavWithSizingState();
}

class _StrechingBottomNavWithSizingState
    extends State<StrechingBottomNavWithSizing> {
  //TODO: Since it is final, can be problematic when the screen size changes.
  final double _screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  int _currentIndex = 0;
  int _toIndex = 0;

  late double left;
  late double right;

  @override
  void initState() {
    left = (_screenWidth / 8) - 46;
    right = (_screenWidth - 46) - (_screenWidth / 8);
    super.initState();
  }

  void animate(BuildContext context) {
    if (_toIndex > _currentIndex) {
      setState(() {
        right = (_screenWidth - 46) - (_screenWidth / 8) * (_toIndex * 2 + 1);
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            left = (_screenWidth / 8) * (_toIndex * 2 + 1) - 46;
          });
        });
      });
    }
    if (_toIndex < _currentIndex) {
      setState(() {
        left = (_screenWidth / 8) * (_toIndex * 2 + 1) - 46;
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            right =
                (_screenWidth - 46) - (_screenWidth / 8) * (_toIndex * 2 + 1);
          });
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height,
      color: const Color(0xff654ea3),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCirc,
            height: AppBar().preferredSize.height - 8,
            top: 4,
            left: left,
            right: right,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF91EAE4),
                    Color(0xFF86A8E7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              width: 50,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bottomBarItem(
                icon: Ionicons.home_outline,
                label: 'Home',
                selected: _currentIndex == 0,
                onTap: () {
                  setState(() {
                    _toIndex = 0;
                    animate(context);
                    _currentIndex = 0;
                  });
                },
              ),
              bottomBarItem(
                icon: Ionicons.search_outline,
                label: 'Search',
                selected: _currentIndex == 1,
                onTap: () {
                  setState(() {
                    _toIndex = 1;
                    animate(context);
                    _currentIndex = 1;
                  });
                },
              ),
              bottomBarItem(
                icon: Ionicons.navigate_outline,
                label: 'Map',
                selected: _currentIndex == 2,
                onTap: () {
                  setState(() {
                    _toIndex = 2;
                    animate(context);
                    _currentIndex = 2;
                  });
                },
              ),
              bottomBarItem(
                icon: Ionicons.person_outline,
                label: 'Profile',
                selected: _currentIndex == 3,
                onTap: () {
                  setState(() {
                    _toIndex = 3;
                    animate(context);
                    _currentIndex = 3;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomBarItem(
      {required IconData icon,
      required String label,
      required bool selected,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
