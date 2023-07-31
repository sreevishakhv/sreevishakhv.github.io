import 'package:aditya_taparia/components/utils.dart';
import 'package:aditya_taparia/main.dart';
import 'package:aditya_taparia/screens/common/about.dart';
import 'package:aditya_taparia/screens/common/contact.dart';
import 'package:aditya_taparia/screens/common/education.dart';
import 'package:aditya_taparia/screens/common/experience.dart';
import 'package:aditya_taparia/screens/common/projects.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopTabletMain extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool isLargeScreen;
  const DesktopTabletMain({super.key, required this.data, required this.isLargeScreen});

  @override
  State<DesktopTabletMain> createState() => _DesktopTabletMainState();
}

class _DesktopTabletMainState extends State<DesktopTabletMain> {
  int _index = 0;
  bool extended = true;

  @override
  void initState() {
    super.initState();
    _loadIndex();
  }

  @override
  void dispose() {
    _saveIndex(_index);
    super.dispose();
  }

  // Load index from shared preferences
  Future<void> _loadIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _index = prefs.getInt('index') ?? 0;
    });
  }

  // Save index to shared preferences
  Future<void> _saveIndex(int i) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('index', i);
  }

  @override
  Widget build(BuildContext context) {
    // Screens
    final List<Widget> screens = <Widget>[
      About(data: data, largeScreen: widget.isLargeScreen, smallScreen: false),
      Education(data: data, smallScreen: false),
      Projects(data: data),
      Experience(data: data, largeScreen: widget.isLargeScreen),
      Contact(data: data),
    ];

    final List<NavigationRailDestination> destinations = <NavigationRailDestination>[
      // navigation destinations
      const NavigationRailDestination(
        icon: Icon(Icons.person_outline_rounded),
        label: Text('About'),
        selectedIcon: Icon(Icons.person_rounded),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.school_outlined),
        label: Text('Education'),
        selectedIcon: Icon(Icons.school_rounded),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.code_outlined),
        label: Text('Projects'),
        selectedIcon: Icon(Icons.code_rounded),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.work_outline_rounded),
        label: Text('Experience'),
        selectedIcon: Icon(Icons.work_rounded),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.alternate_email_outlined),
        label: Text('Contact Me'),
        selectedIcon: Icon(Icons.alternate_email_rounded),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff0f5fa),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            setState(() {
              extended = !extended;
            });
          },
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(),
        title: const Text('Aditya Taparia'),
        backgroundColor: const Color(0xfff0f5fa),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: 20,
          fontFamily: 'VarelaRound',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              launchUrl(Uri.parse('https://github.com/aditya-taparia'));
            },
            child: const Text(
              'Github',
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.tonal(
            onPressed: () {
              launchUrl(Uri.parse('https://www.linkedin.com/in/aditya-taparia/'));
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue[100],
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
            child: const Text('LinkedIn'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: _index,
                  extended: extended,
                  onDestinationSelected: (int i) {
                    setState(() {
                      _index = i;
                    });
                    _saveIndex(i);
                  },
                  backgroundColor: const Color(0xfff0f5fa),
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  indicatorShape: const StarBorder(
                    valleyRounding: 0.2,
                    innerRadiusRatio: 0.8,
                    pointRounding: 0.5,
                    points: 10,
                  ),
                  minWidth: 60,
                  minExtendedWidth: widget.isLargeScreen
                      ? (MediaQuery.of(context).size.width + 1200) / 10 > 250
                          ? 250
                          : (MediaQuery.of(context).size.width + 1200) / 10
                      : 220,
                  labelType: !extended ? NavigationRailLabelType.none : null,
                  selectedLabelTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 14,
                    fontFamily: 'VarelaRound',
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 14,
                    fontFamily: 'VarelaRound',
                  ),
                  selectedIconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 18,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    size: 18,
                  ),
                  destinations: destinations,
                  trailing: widget.isLargeScreen
                      ? _index == 0
                          ? null
                          : ResumeDownload(extended: extended)
                      : ResumeDownload(extended: extended),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                      // child: screens[_index],
                      child: PageTransitionSwitcher(
                        duration: const Duration(seconds: 1),
                        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: primaryAnimation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child,
                          );
                        },
                        child: screens[_index],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: IconButton.filled(
              icon: const Center(
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                ),
              ),
              tooltip: 'Information',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      elevation: 0,
                      backgroundColor: Colors.grey.shade100,
                      title: ListTile(
                        // Website Logo
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/logo.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: const Text(
                          'Aditya Taparia',
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: const Text(
                          'Copyright © 2023 Aditya Taparia',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      content: const SizedBox(
                        width: 400,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'This website is maintained, designed and developed by Aditya Taparia. This website is built using Flutter Web and hosted on Github Pages.',
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showLicensePage(
                              context: context,
                              applicationName: 'Aditya Taparia',
                              applicationVersion: '1.0.0',
                              applicationIcon: Image.asset(
                                'assets/logo.png',
                                width: 50,
                                height: 50,
                              ),
                              applicationLegalese: 'Copyright © 2023 Aditya Taparia',
                            );
                          },
                          child: const Text('View Licenses'),
                        ),
                      ],
                    );
                  },
                );
              },
              constraints: const BoxConstraints(
                minWidth: 10,
                minHeight: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResumeDownload extends StatelessWidget {
  final bool extended;
  const ResumeDownload({super.key, required this.extended});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 32.0,
            right: 8.0,
            left: 8.0,
          ),
          child: FloatingActionButton.extended(
            elevation: 0,
            tooltip: 'Resume',
            onPressed: () {
              snackbar(
                  context,
                  const Text(
                    'Downloading Resume...',
                    style: TextStyle(color: Colors.black),
                  ),
                  isFloating: true);
              downloadFile('../assets/Resume.pdf');
            },
            label: const Text(
              'Download Resume',
              style: TextStyle(
                fontFamily: 'VarelaRound',
              ),
            ),
            extendedTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
            ),
            backgroundColor: Colors.blue[100],
            icon: const Icon(
              Icons.download_rounded,
              size: 22,
            ),
            isExtended: extended,
          ),
        ),
      ),
    );
  }
}
