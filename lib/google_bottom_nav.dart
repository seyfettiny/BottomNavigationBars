import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class FirstBottomNav extends StatefulWidget {
  const FirstBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstBottomNav> createState() => _FirstBottomNavState();
}

class _FirstBottomNavState extends State<FirstBottomNav>
    with SingleTickerProviderStateMixin {
  late final _animationController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: AppBar().preferredSize.height,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomBarItem(
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
            BottomBarItem(
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
            BottomBarItem(
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
            BottomBarItem(
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
      ),
    );
  }

  InkWell BottomBarItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
    required Color selectedColor,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        duration: _animationController.duration,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              selected ? selectedColor.withAlpha(100) : Colors.transparent,
              selected ? selectedColor : Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  selected ? selectedColor.withAlpha(100) : Colors.transparent,
              blurRadius: selected ? 18 : 0,
              spreadRadius: selected ? 2 : 0,
              offset: Offset(0, selected ? 6 : 0),
            ),
          ],
          borderRadius: BorderRadius.circular(24.0),
        ),
        height: 48,
        width: selected
            ? MediaQuery.of(context).size.width / 3
            : MediaQuery.of(context).size.width / 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : Colors.black87,
            ),
            Flexible(
              child: Visibility(
                visible: selected,
                child: Text(
                  label,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
