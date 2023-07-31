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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      home: Responsive(
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
        isLoading = false;
        data = json.decode(value);
      });
    }).then((value) {
      for (int i = 0; i < data["education"].length; i++) {
        precacheImage(AssetImage(data["education"][i]["logo"]), context);
      }
      for (int i = 0; i < data['project'].length; i++) {
        precacheImage(
            AssetImage(data['project'][i]['image'].isNotEmpty ? 'assets/${data['project'][i]['image']}' : 'assets/card graphic.png'), context);
      }
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
        return const Center(child: CircularProgressIndicator());
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
