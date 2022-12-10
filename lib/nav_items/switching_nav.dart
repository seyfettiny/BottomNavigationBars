import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SwitchingNav extends StatefulWidget {
  const SwitchingNav({super.key});

  @override
  State<SwitchingNav> createState() => _SwitchingNavState();
}

class _SwitchingNavState extends State<SwitchingNav> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          bottomBarItem(
            icon: Ionicons.home_outline,
            label: 'Home',
            selected: _currentIndex == 0,
            selectedColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                _currentIndex = 0;
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
              });
            },
          ),
        ],
      ),
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
      flex: 1,
      child: InkWell(
        onTap: onTap,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: selected
              ? Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: selectedColor.withAlpha(190),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Icon(
                  icon,
                  color: selected ? selectedColor : Colors.grey,
                ),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(
        //       icon,
        //       color: selected ? selectedColor : Colors.grey,
        //     ),
        //     Text(
        //       label,
        //       style: TextStyle(
        //         color: selected ? selectedColor : Colors.grey,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
