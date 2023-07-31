import 'package:aditya_taparia/components/utils.dart';
import 'package:aditya_taparia/main.dart';
import 'package:aditya_taparia/screens/mobile/mobile_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class About extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool largeScreen;
  final bool smallScreen;
  const About({super.key, required this.data, this.largeScreen = false, required this.smallScreen});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  double _imgBorderRadius = 30;

  @override
  Widget build(BuildContext context) {
    if (!widget.largeScreen) {
      return SingleChildScrollView(
        controller: widget.smallScreen ? scrollControllerAbout : null,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MouseRegion(
                onEnter: (event) {
                  setState(() {
                    _imgBorderRadius = 50;
                  });
                },
                onExit: (event) {
                  setState(() {
                    _imgBorderRadius = 30;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_imgBorderRadius),
                    image: const DecorationImage(
                      image: AssetImage('assets/myself.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 200,
                  height: 200,
                ),
              ),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HtmlWidget(
                widget.data["about"],
                customStylesBuilder: (element) {
                  // Add CSS
                  if (element.localName == 'a:hover') {
                    return {
                      'color': '#fff',
                      'background-color': '#005fb3',
                      'text-decoration': 'underline',
                    };
                  }
                  if (element.localName == 'a') {
                    return {
                      'color': '#4688f1',
                      'transition': '50ms',
                      'text-decoration': 'none',
                    };
                  }
                  // Add the hover effect to the link

                  if (element.localName == 'p') {
                    return {
                      'font-size': '1.2rem',
                      'text-align': 'justify',
                    };
                  }
                  return null;
                },
              ),
            ),

            // Note
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Note: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'VarelaRound',
                            ),
                          ),
                          TextSpan(
                            text: data["note"],
                            style: const TextStyle(
                              fontFamily: 'VarelaRound',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 65),
          ],
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 16.0,
                ),
                child: MouseRegion(
                  onEnter: (event) {
                    setState(() {
                      _imgBorderRadius = 50;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      _imgBorderRadius = 30;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_imgBorderRadius),
                      image: const DecorationImage(
                        image: AssetImage('assets/myself.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 220,
                    height: 220,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              FilledButton(
                onPressed: () {
                  snackbar(
                      context,
                      const Text(
                        'Downloading Resume...',
                        style: TextStyle(color: Colors.black),
                      ),
                      isFloating: true);
                  downloadFile('https://github.com/aditya-taparia/aditya-taparia.github.io/blob/main/assets/Resume.pdf');
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                child: const Text(
                  'Download Resume',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: HtmlWidget(
                      widget.data["about"],
                      customStylesBuilder: (element) {
                        // Add CSS
                        if (element.localName == 'a:hover') {
                          return {
                            'color': '#fff',
                            'background-color': '#005fb3',
                            'text-decoration': 'underline',
                          };
                        }
                        if (element.localName == 'a') {
                          return {
                            'color': '#4688f1',
                            'transition': '50ms',
                            'text-decoration': 'none',
                          };
                        }
                        // Add the hover effect to the link

                        if (element.localName == 'p') {
                          return {
                            'font-size': '1.2rem',
                            'text-align': 'justify',
                          };
                        }
                        return null;
                      },
                    ),
                  ),

                  // Note
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[100],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Note: ',
                                  style: TextStyle(
                                    fontFamily: 'VarelaRound',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: data["note"],
                                  style: const TextStyle(
                                    fontFamily: 'VarelaRound',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      );
    }
  }
}
