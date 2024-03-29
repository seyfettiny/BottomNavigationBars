import 'dart:io';

import 'package:bottomnavigationbars/nav_items/blob_menu.nav.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

import 'nav_items/floating_selection_bottom_nav.dart';
import 'nav_items/google_bottom_nav.dart';
import 'nav_items/lamp_bottom_nav.dart';
import 'nav_items/shifting_bottom_nav.dart';
import 'nav_items/streching_bottom_nav.dart';
import 'nav_items/switching_bottom_nav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setMaxWindowSize(const Size(540, 800));
    await DesktopWindow.setMinWindowSize(const Size(540, 800));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.867),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          BlobMenu(),
          FloatingSelectionBottomNav(),
          GoogleBottonNav(),
          ShiftingBottomNav(),
          StrechingBottomNav(),
          SwitchingBottomNav(),
          LampBottomNav(),
        ],
      ),
    );
  }
}
