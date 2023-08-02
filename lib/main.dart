import 'dart:async';
import 'package:aditya_taparia/components/loading.dart';
import 'package:aditya_taparia/screens/mobile/mobile_main.dart';
import 'package:aditya_taparia/screens/desktop_tablet/desktop_tablet_main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// Custom scroll behaviour for list
class DragScroll extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

// Global JSON data
Map<String, dynamic> data = {};

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width >= 1000;

    return MaterialApp(
      scrollBehavior: DragScroll(),
      title: 'Aditya Taparia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff004b8d),
        ),
        useMaterial3: true,
        fontFamily: 'VarelaRound',
      ),
      debugShowCheckedModeBanner: false,
      home: isLoading
          ? const Loading(
              text: 'Hello! I\'m Aditya...',
            )
          : Responsive(
              desktop: DesktopTabletMain(data: data, isLargeScreen: isLargeScreen),
              mobile: MobileMain(data: data),
            ),
    );
  }
}

class Responsive extends StatefulWidget {
  final Widget mobile;
  final Widget desktop;
  const Responsive({super.key, required this.mobile, required this.desktop});

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  bool isLoading = true;
  // Load JSON data
  load() {
    setState(() {
      isLoading = true;
    });
    rootBundle.loadString('assets/data.json').then((value) {
      setState(() {
        data = json.decode(value);
      });
    }).then((value) {
      // Preloading my image
      precacheImage(const AssetImage('assets/myself.jpg'), context);

      // Preload images of education
      for (int i = 0; i < data["education"].length; i++) {
        precacheImage(AssetImage('assets/${data["education"][i]["logo"]}'), context);
      }

      // Preload images of projects
      for (int i = 0; i < data['project'].length; i++) {
        precacheImage(
            AssetImage(data['project'][i]['image'].isNotEmpty ? 'assets/${data['project'][i]['image']}' : 'assets/card graphic.png'), context);
      }

      // Preload images of experience
      for (int i = 0; i < data['experience'].length; i++) {
        precacheImage(AssetImage('assets/${data['experience'][i]['image']}'), context);
      }
    }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Load JSON data
    load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (isLoading) {
        return const Loading(text: 'Hello! I\'m Aditya...', isAnimate: false);
      } else {
        if (constraints.maxWidth >= 650) {
          return widget.desktop;
        } else {
          return widget.mobile;
        }
      }
    });
  }
}
