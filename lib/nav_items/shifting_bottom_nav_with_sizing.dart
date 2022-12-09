import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ShiftingBottomNavWithSizing extends StatefulWidget {
  const ShiftingBottomNavWithSizing({Key? key}) : super(key: key);

  @override
  State<ShiftingBottomNavWithSizing> createState() =>
      _ShiftingBottomNavWithSizingState();
}

class _ShiftingBottomNavWithSizingState
    extends State<ShiftingBottomNavWithSizing> {
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
    // animate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height,
      color: Colors.white,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCirc,
            height: AppBar().preferredSize.height,
            left: left,
            right: right,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.shade400,
                    Colors.green,
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
            AnimatedTheme(
                duration: const Duration(milliseconds: 300),
                data: ThemeData(
                  iconTheme: IconThemeData(
                    color: selected ? Colors.white : Colors.black87,
                  ),
                ),
                child: Icon(
                  icon,
                )),
            AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey,
                ),
                child: Text(label)),
          ],
        ),
      ),
    );
  }
}
