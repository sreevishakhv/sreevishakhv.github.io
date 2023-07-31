import 'package:aditya_taparia/screens/mobile/mobile_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Education extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool smallScreen;
  const Education({super.key, required this.data, required this.smallScreen});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.smallScreen ? scrollControllerEducation : null,
      padding: const EdgeInsets.only(bottom: 50.0),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.data["education"].length,
      itemBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 600,
            child: EduCard(
              name: widget.data["education"][index]["name"],
              duration: widget.data["education"][index]["duration"],
              course: widget.data["education"][index]["course"],
              comment: widget.data["education"][index]["comment"],
              logo: widget.data["education"][index]["logo"],
            ),
          ),
        );
      },
    );
  }
}

class EduCard extends StatefulWidget {
  final String name;
  final String duration;
  final String course;
  final String comment;
  final String logo;
  const EduCard({
    super.key,
    required this.name,
    required this.duration,
    required this.course,
    required this.comment,
    required this.logo,
  });

  @override
  State<EduCard> createState() => _EduCardState();
}

class _EduCardState extends State<EduCard> {
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/${widget.logo}',
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
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    text: 'Course: ',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'VarelaRound',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.course,
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
                  widget.comment,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'VarelaRound',
                  ),
                  customStylesBuilder: (element) {
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
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
