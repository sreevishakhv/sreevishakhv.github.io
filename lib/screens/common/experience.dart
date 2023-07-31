import 'dart:math';
import 'package:aditya_taparia/screens/mobile/mobile_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Experience extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool smallScreen;
  final bool largeScreen;
  const Experience({super.key, required this.data, this.smallScreen = false, this.largeScreen = false});

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  @override
  Widget build(BuildContext context) {
    return !widget.smallScreen && widget.largeScreen
        ? ListView.builder(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 50.0),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: max(0, widget.data["experience"].length * 2 - 1),
            itemBuilder: (context, i) {
              final List experience = widget.data["experience"];
              if (i.isOdd) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 700,
                    child: TimelineDivider(
                      color: Theme.of(context).primaryColor,
                      thickness: 1.5,
                      begin: 0.15,
                      end: 0.85,
                    ),
                  ),
                );
              }
              final int index = i ~/ 2;
              final bool isLeft = index.isEven;
              final isFirst = index == 0;
              final isLast = index == experience.length - 1;

              return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 700,
                  child: TimelineTile(
                    alignment: TimelineAlign.manual,
                    endChild: isLeft
                        ? ExpCard(
                            name: experience[index]["name"],
                            duration: experience[index]["duration"],
                            role: experience[index]["role"],
                            description: experience[index]["description"],
                            img: experience[index]["image"],
                          )
                        : null,
                    startChild: isLeft
                        ? null
                        : ExpCard(
                            name: experience[index]["name"],
                            duration: experience[index]["duration"],
                            role: experience[index]["role"],
                            description: experience[index]["description"],
                            img: experience[index]["image"],
                          ),
                    lineXY: isLeft ? 0.15 : 0.85,
                    isFirst: isFirst,
                    isLast: isLast,
                    beforeLineStyle: LineStyle(
                      color: Theme.of(context).primaryColor,
                      thickness: 1.5,
                    ),
                    indicatorStyle: const IndicatorStyle(
                      width: 40,
                      height: 40,
                      indicator: Indicator(),
                    ),
                  ),
                ),
              );
            },
          )
        : ListView.builder(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 50.0),
            shrinkWrap: true,
            controller: widget.smallScreen ? scrollControllerExperience : null,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.data["experience"].length,
            itemBuilder: (context, i) {
              final List experience = widget.data["experience"];
              final isFirst = i == 0;
              final isLast = i == experience.length - 1;

              return TimelineTile(
                alignment: TimelineAlign.manual,
                endChild: ExpCard(
                  name: experience[i]["name"],
                  duration: experience[i]["duration"],
                  role: experience[i]["role"],
                  description: experience[i]["small_desc"],
                  img: experience[i]["image"],
                ),
                lineXY: 0.1,
                isFirst: isFirst,
                isLast: isLast,
                beforeLineStyle: LineStyle(
                  color: Theme.of(context).primaryColor,
                  thickness: 1.5,
                ),
                indicatorStyle: const IndicatorStyle(
                  width: 40,
                  height: 40,
                  indicator: Indicator(),
                ),
              );
            },
          );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.green[100],
      child: const Center(
        child: Icon(
          Icons.work_history_rounded,
          color: Colors.black,
          size: 25,
        ),
      ),
    );
  }
}

class ExpCard extends StatefulWidget {
  final String name;
  final String duration;
  final String role;
  final String description;
  final String img;
  const ExpCard({
    super.key,
    required this.name,
    required this.duration,
    required this.role,
    required this.description,
    required this.img,
  });

  @override
  State<ExpCard> createState() => _ExpCardState();
}

class _ExpCardState extends State<ExpCard> {
  Color _color = Colors.blueGrey.shade50.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 10.0,
      ),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _color = Colors.lightBlue.shade50;
          });
        },
        onExit: (_) {
          setState(() {
            _color = Colors.blueGrey.shade50.withOpacity(0.5);
          });
        },
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: _color,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/${widget.img}',
                          ),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'VarelaRound',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            widget.duration,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'VarelaRound',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Position: ',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'VarelaRound',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.role,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'VarelaRound',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                HtmlWidget(
                  widget.description,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'VarelaRound',
                  ),
                  customStylesBuilder: (element) {
                    if (element.localName == 'a') {
                      return {
                        'color': '#4688f1',
                        'text-decoration': 'none',
                      };
                    }
                    if (element.localName == 'p') {
                      return {
                        'text-align': 'justify',
                      };
                    }
                    if (element.localName == 'li') {
                      return {
                        'text-align': 'justify',
                      };
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
