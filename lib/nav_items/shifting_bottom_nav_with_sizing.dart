import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ShiftingBottomNavWithSizing extends StatefulWidget {
  const ShiftingBottomNavWithSizing({Key? key}) : super(key: key);

  @override
  State<ShiftingBottomNavWithSizing> createState() =>
      _ShiftingBottomNavWithSizingState();
}

class _ShiftingBottomNavWithSizingState
    extends State<ShiftingBottomNavWithSizing>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _toIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height,
      color: Colors.white,
      child: Stack(
        children: [
          ShiftingContainer(
            currentIndex: _currentIndex,
            toIndex: _toIndex,
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

class ShiftingContainer extends StatefulWidget {
  const ShiftingContainer({
    Key? key,
    required this.currentIndex,
    required this.toIndex,
  });
  final int currentIndex;
  final int toIndex;
  @override
  State<ShiftingContainer> createState() => _ShiftingContainerState();
}

class _ShiftingContainerState extends State<ShiftingContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _shiftStartAnimation;
  late final Animation<double> _shiftFollowUpAnimation;

  @override
  void initState() {
    super.initState();

    setupAnimation(widget.currentIndex, widget.toIndex);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ShiftingContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex ||
        oldWidget.toIndex != widget.toIndex) {
      setupAnimation(widget.currentIndex, widget.toIndex);
    }
  }

  void setupAnimation(int currentIndex, int toIndex) {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });

    _shiftStartAnimation = Tween<double>(
      begin: widget.currentIndex.toDouble(),
      end: widget.toIndex.toDouble(),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCirc,
      ),
    )..addStatusListener((status) {
        // ignore: missing_return
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 800), () {
            _animationController.forward();
          });
        }
      });

    _shiftFollowUpAnimation = Tween<double>(
      begin: widget.currentIndex.toDouble(),
      end: widget.toIndex.toDouble(),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: _animationController.duration!,
      curve: Curves.easeInOutCirc,
      height: AppBar().preferredSize.height,
      left: (MediaQuery.of(context).size.width / 8) *
              (_animationController.value * 2 + 1) -
          46,
      right: (MediaQuery.of(context).size.width - 46) -
          (MediaQuery.of(context).size.width / 8) *
              (_animationController.value * 2 + 1),
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
              Colors.teal.shade400,
              Colors.green,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: 50,
      ),
    );
  }
}
