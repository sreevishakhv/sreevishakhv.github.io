import 'package:aditya_taparia/components/utils.dart';
import 'package:aditya_taparia/main.dart';
import 'package:aditya_taparia/screens/common/about.dart';
import 'package:aditya_taparia/screens/common/contact.dart';
import 'package:aditya_taparia/screens/common/education.dart';
import 'package:aditya_taparia/screens/common/experience.dart';
import 'package:aditya_taparia/screens/common/projects.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// Scroll controller for small screens
ScrollController scrollControllerAbout = ScrollController();
ScrollController scrollControllerEducation = ScrollController();
ScrollController scrollControllerExperience = ScrollController();
ScrollController scrollControllerProject = ScrollController();
ScrollController scrollControllerContact = ScrollController();
bool isExtended = true;

class MobileMain extends StatefulWidget {
  const MobileMain({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<MobileMain> createState() => _MobileMainState();
}

class _MobileMainState extends State<MobileMain> {
  int _index = 0;

  // Screens
  final List<Widget> screens = <Widget>[
    About(data: data, smallScreen: true),
    Education(data: data, smallScreen: true),
    Projects(data: data, smallScreen: true),
    Experience(data: data, smallScreen: true),
    Contact(data: data, smallScreen: true),
  ];

  @override
  void initState() {
    super.initState();
    _loadIndex();
    scrollControllerAbout.addListener(() {
      if (scrollControllerAbout.position.userScrollDirection == ScrollDirection.reverse && scrollControllerAbout.offset > 5 && mounted) {
        setState(() {
          isExtended = false;
        });
      }
      if (scrollControllerAbout.position.userScrollDirection == ScrollDirection.forward && scrollControllerAbout.offset > 5 && mounted) {
        setState(() {
          isExtended = true;
        });
      }
    });
    scrollControllerEducation.addListener(() {
      if (scrollControllerEducation.position.userScrollDirection == ScrollDirection.reverse && scrollControllerEducation.offset > 5 && mounted) {
        setState(() {
          isExtended = false;
        });
      }
      if (scrollControllerEducation.position.userScrollDirection == ScrollDirection.forward && scrollControllerEducation.offset > 5 && mounted) {
        setState(() {
          isExtended = true;
        });
      }
    });
    scrollControllerProject.addListener(() {
      if (scrollControllerProject.position.userScrollDirection == ScrollDirection.reverse && scrollControllerProject.offset > 5 && mounted) {
        setState(() {
          isExtended = false;
        });
      }
      if (scrollControllerProject.position.userScrollDirection == ScrollDirection.forward && scrollControllerProject.offset > 5 && mounted) {
        setState(() {
          isExtended = true;
        });
      }
    });
    scrollControllerExperience.addListener(() {
      if (scrollControllerExperience.position.userScrollDirection == ScrollDirection.reverse && scrollControllerExperience.offset > 5 && mounted) {
        setState(() {
          isExtended = false;
        });
      }
      if (scrollControllerExperience.position.userScrollDirection == ScrollDirection.forward && scrollControllerExperience.offset > 5 && mounted) {
        setState(() {
          isExtended = true;
        });
      }
    });
    scrollControllerContact.addListener(() {
      if (scrollControllerContact.position.userScrollDirection == ScrollDirection.reverse && scrollControllerContact.offset > 5 && mounted) {
        setState(() {
          isExtended = false;
        });
      }
      if (scrollControllerContact.position.userScrollDirection == ScrollDirection.forward && scrollControllerContact.offset > 5 && mounted) {
        setState(() {
          isExtended = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _saveIndex(_index);
    scrollControllerAbout.removeListener(() {});
    scrollControllerEducation.removeListener(() {});
    scrollControllerProject.removeListener(() {});
    scrollControllerExperience.removeListener(() {});
    scrollControllerContact.removeListener(() {});
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
    return Scaffold(
      backgroundColor: const Color(0xfff0f5fa),
      appBar: AppBar(
        title: const Text(
          'Aditya Taparia',
        ),
        backgroundColor: const Color(0xfff0f5fa),
        actionsIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimaryContainer),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: 20,
          fontFamily: 'VarelaRound',
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          IconButton.filledTonal(
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
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue[100],
              shape: const StarBorder(
                valleyRounding: 0.2,
                innerRadiusRatio: 0.8,
                pointRounding: 0.5,
                points: 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filledTonal(
            icon: Icon(
              Bootstrap.github,
              size: 18,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            tooltip: 'Github',
            onPressed: () {
              launchUrl(Uri.parse('https://github.com/aditya-taparia'));
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue[100],
              shape: const StarBorder(
                valleyRounding: 0.2,
                innerRadiusRatio: 0.8,
                pointRounding: 0.5,
                points: 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filledTonal(
            icon: Icon(
              EvaIcons.linkedin,
              size: 18,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            tooltip: 'LinkedIn',
            onPressed: () {
              launchUrl(Uri.parse('https://www.linkedin.com/in/aditya-taparia/'));
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue[100],
              shape: const StarBorder(
                valleyRounding: 0.2,
                innerRadiusRatio: 0.8,
                pointRounding: 0.5,
                points: 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
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

      // Resume download button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          snackbar(
            context,
            const Text(
              'Downloading Resume...',
              style: TextStyle(color: Colors.black),
            ),
          );
          downloadFile('https://aditya-taparia.github.io/assets/assets/Resume.pdf');
        },
        tooltip: 'Resume',
        extendedPadding: const EdgeInsets.only(left: 16, right: 16),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.download_rounded),
            isExtended ? const SizedBox(width: 10) : const SizedBox(width: 0),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  child: child,
                ),
              ),
              child: isExtended ? const Text('Resume', style: TextStyle(fontFamily: 'VarelaRound')) : null,
            ),
          ],
        ),
        extendedTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16,
          fontFamily: 'VarelaRound',
        ),
        backgroundColor: Colors.blue[100],
      ),

      // Adding Bottom Navigation Bar
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() {
            _index = value;
            isExtended = true;
          });
          _saveIndex(value);
        },
        indicatorColor: Theme.of(context).colorScheme.primary,
        animationDuration: const Duration(seconds: 1),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            label: 'About',
            selectedIcon: Icon(
              Icons.person_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 20,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.school_outlined),
            label: 'Education',
            selectedIcon: Icon(
              Icons.school_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.code_outlined),
            label: 'Projects',
            selectedIcon: Icon(
              Icons.code_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.work_outline_rounded),
            label: 'Experience',
            selectedIcon: Icon(
              Icons.work_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          NavigationDestination(
            icon: const Icon(Icons.alternate_email_outlined),
            label: 'Contact',
            selectedIcon: Icon(
              Icons.alternate_email_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
