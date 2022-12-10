import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height,
      color: Colors.black87,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
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
                  child: Container(
                      color: Colors.white,
                      width: widthOfRay,
                      height: AppBar().preferredSize.height),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              bottomBarItem(
                icon: Ionicons.home_outline,
                label: 'Home',
                selected: _currentIndex == 0,
                selectedColor: Colors.blueAccent,
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                    animate(context);
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
                    _currentIndex = 1;
                    animate(context);
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
                    _currentIndex = 2;
                    animate(context);
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
    required String label,
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
