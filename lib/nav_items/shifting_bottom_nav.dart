import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ShiftingBottomNav extends StatefulWidget {
  const ShiftingBottomNav({Key? key}) : super(key: key);

  @override
  State<ShiftingBottomNav> createState() => _ShiftingBottomNavState();
}

class _ShiftingBottomNavState extends State<ShiftingBottomNav> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height,
      color: Colors.white,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCirc,
            width: 90,
            height: AppBar().preferredSize.height,
            left: (MediaQuery.of(context).size.width / 8) *
                    (_currentIndex * 2 + 1) -
                46,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.amber,
                    Colors.amber.shade700,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
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
