import 'package:aditya_taparia/components/utils.dart';
import 'package:aditya_taparia/main.dart';
import 'package:aditya_taparia/screens/mobile/mobile_main.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool smallScreen;
  const Projects({super.key, required this.data, this.smallScreen = false});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  int forIndex = 1;
  int backIndex = 0;
  int size = data['project'].length - 1;
  bool forward = true;
  bool backward = true;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(() {
      int fi = itemPositionsListener.itemPositions.value.first.index;
      double fe = itemPositionsListener.itemPositions.value.first.itemLeadingEdge;
      int li = itemPositionsListener.itemPositions.value.last.index;
      double le = itemPositionsListener.itemPositions.value.last.itemTrailingEdge;

      // Navigation buttons state
      if (fi == 0 && fe == 0.0) {
        setState(() {
          backward = false;
          forward = true;
        });
      } else if (li == size && le <= 1.005) {
        setState(() {
          forward = false;
          backward = true;
        });
      } else {
        setState(() {
          forward = true;
          backward = true;
        });
      }

      // Forward and backward state
      if (fi == 0) {
        setState(() {
          forIndex = 1;
          backIndex = 0;
        });
      } else {
        setState(() {
          forIndex = fi + 1;
          backIndex = fi - 1;
        });
      }
    });
  }

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.smallScreen ? scrollControllerProject : null,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 32.0,
              right: 32.0,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Featured Projects:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // All Projects Button
                TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse('https://github.com/aditya-taparia?tab=repositories'));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('All Projects'),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ClipRRect(
              borderRadius: !widget.smallScreen ? BorderRadius.circular(40.0) : BorderRadius.zero,
              child: LimitedBox(
                maxHeight: 330.0,
                child: ScrollablePositionedList.builder(
                  itemCount: widget.data['project'].length,
                  shrinkWrap: true,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, index) {
                    return ProjectCard(
                      data: widget.data['project'][index],
                      smallScreen: widget.smallScreen,
                    );
                  },
                  itemScrollController: itemScrollController,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),

          // Setting controller to scroll
          widget.smallScreen
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton.filled(
                      onPressed: backward
                          ? () {
                              itemScrollController.scrollTo(
                                index: backIndex,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOutCubic,
                              );
                            }
                          : null,
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                      iconSize: 16,
                      constraints: const BoxConstraints(
                        minHeight: 24,
                        minWidth: 24,
                      ),
                      tooltip: 'Backward',
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const StarBorder(
                            valleyRounding: 0.2,
                            innerRadiusRatio: 0.8,
                            pointRounding: 0.5,
                            points: 8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton.filled(
                      onPressed: forward
                          ? () {
                              itemScrollController.scrollTo(
                                index: forIndex,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOutCubic,
                              );
                            }
                          : null,
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                      iconSize: 16,
                      constraints: const BoxConstraints(
                        minHeight: 24,
                        minWidth: 24,
                      ),
                      tooltip: 'Forward',
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const StarBorder(
                            valleyRounding: 0.2,
                            innerRadiusRatio: 0.8,
                            pointRounding: 0.5,
                            points: 8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

          const Padding(
            padding: EdgeInsets.only(
              top: 24.0,
              left: 32.0,
              right: 32.0,
              bottom: 8.0,
            ),
            child: Text(
              'Publications:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Numbered List of Publications
          ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 18.0,
            ),
            itemCount: widget.data['publications'].length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return ListTile(
                leading: Text(
                  '${i + 1}.',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                title: Text(
                  widget.data['publications'][i]['name'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
                subtitle: widget.data['publications'][i]['status'].isEmpty
                    ? null
                    : Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[300],
                            ),
                            child: Text(
                              widget.data['publications'][i]['status'],
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                trailing: widget.data['publications'][i]['link'].isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          launchUrl(Uri.parse(widget.data['publications'][i]['link']));
                        },
                        icon: Icon(
                          Icons.open_in_new_rounded,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 16.0,
                ),
              );
            },
          ),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    Key? key,
    required this.data,
    required this.smallScreen,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final bool smallScreen;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        child: Card(
          elevation: 1.5,
          surfaceTintColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Theme.of(context).canvasColor,
                  image: DecorationImage(
                    image: AssetImage(widget.data['image'].isNotEmpty ? 'assets/${widget.data['image']}' : 'assets/card graphic.png'),
                    fit: BoxFit.cover,
                    alignment: widget.data['image'].isNotEmpty ? Alignment.topCenter : Alignment.center,
                    colorFilter: const ColorFilter.mode(
                      Colors.black12,
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  widget.data['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.justify,
                ),
                subtitle: Text(
                  widget.data['duration'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.justify,
                ),
                isThreeLine: true,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilledButton(
                      onPressed: () {
                        widget.smallScreen
                            ? Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0.0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return Scaffold(
                                      appBar: AppBar(
                                        title: const Text('Project Details'),
                                        elevation: 0,
                                        centerTitle: true,
                                        leading: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                                          ),
                                        ),
                                      ),
                                      body: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Project Name: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'VarelaRound',
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                              const SizedBox(height: 2.0),
                                              Text(
                                                widget.data['name'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'VarelaRound',
                                                ),
                                              ),
                                              const SizedBox(height: 12.0),
                                              Text(
                                                'Duration: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'VarelaRound',
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                              const SizedBox(height: 2.0),
                                              Text(
                                                widget.data['duration'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'VarelaRound',
                                                ),
                                              ),
                                              const SizedBox(height: 12.0),
                                              Text(
                                                'Description: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'VarelaRound',
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                              const SizedBox(height: 2.0),
                                              Text(
                                                widget.data['description'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'VarelaRound',
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                              const SizedBox(height: 12.0),
                                              Text(
                                                'Tags: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'VarelaRound',
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                              const SizedBox(height: 4.0),
                                              Wrap(
                                                spacing: 4.0,
                                                runSpacing: 4.0,
                                                children: List.generate(
                                                  widget.data['tag'].length,
                                                  (index) => Chip(
                                                    labelPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0),
                                                    label: Text(
                                                      widget.data['tag'][index],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.green[100],
                                                    side: BorderSide.none,
                                                    elevation: 0,
                                                    shadowColor: Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 50.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                      floatingActionButton: widget.data['github_link'].isEmpty
                                          ? Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 32.0,
                                                vertical: 8.0,
                                              ),
                                              // width: MediaQuery.of(context).size.width * 0.8,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4.0),
                                                color: Colors.blue[100],
                                              ),
                                              child: const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.info_outline_rounded,
                                                    size: 18,
                                                  ),
                                                  SizedBox(width: 8.0),
                                                  Text(
                                                    'This project is not yet open sourced.',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'VarelaRound',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : FloatingActionButton.extended(
                                              onPressed: () {
                                                launchUrl(Uri.parse(widget.data['github_link']));
                                              },
                                              label: const Text(
                                                'Open Project',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              icon: const Icon(Icons.open_in_new_rounded),
                                              backgroundColor: Colors.blue[100],
                                            ),
                                      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                                    );
                                  },
                                ),
                              )
                            : showGeneralDialog<String>(
                                context: context,
                                transitionBuilder: (context, a1, a2, child) {
                                  var curve = Curves.easeInOut.transform(a1.value);
                                  return Transform.scale(
                                    scale: curve,
                                    child: Opacity(
                                      opacity: curve,
                                      child: child,
                                    ),
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 300),
                                pageBuilder: (context, a1, a2) => Dialog(
                                  surfaceTintColor: Colors.grey[200],
                                  child: Container(
                                    padding: const EdgeInsets.all(24.0),
                                    width: widget.smallScreen ? MediaQuery.of(context).size.width * 0.8 : 600,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Center Title with Close Button
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Project Details',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.close_rounded,
                                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 24.0),
                                        Text(
                                          'Project Name: ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'VarelaRound',
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 2.0),
                                        Text(
                                          widget.data['name'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'VarelaRound',
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        Text(
                                          'Duration: ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'VarelaRound',
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 2.0),
                                        Text(
                                          widget.data['duration'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'VarelaRound',
                                          ),
                                        ),
                                        const SizedBox(height: 12.0),
                                        Text(
                                          'Description: ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'VarelaRound',
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 2.0),
                                        Text(
                                          widget.data['description'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'VarelaRound',
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                        const SizedBox(height: 16.0),
                                        Wrap(
                                          spacing: 4.0,
                                          runSpacing: 4.0,
                                          children: List.generate(
                                            widget.data['tag'].length,
                                            (index) => Chip(
                                              labelPadding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0),
                                              label: Text(
                                                widget.data['tag'][index],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              backgroundColor: Colors.green[100],
                                              side: BorderSide.none,
                                              elevation: 0,
                                              shadowColor: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment: widget.data['github_link'].isEmpty ? MainAxisAlignment.center : MainAxisAlignment.end,
                                          children: [
                                            widget.data['github_link'].isNotEmpty
                                                ? FilledButton(
                                                    onPressed: () {
                                                      launchUrl(Uri.parse(widget.data['github_link']));
                                                    },
                                                    child: const Text('Open Project'),
                                                  )
                                                : Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 32.0,
                                                      vertical: 8.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4.0),
                                                      color: Colors.blue[100],
                                                    ),
                                                    child: const Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.info_outline_rounded,
                                                          size: 18,
                                                        ),
                                                        SizedBox(width: 8.0),
                                                        Text(
                                                          'This project is not yet open sourced.',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: 'VarelaRound',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      },
                      child: const Text('Details'),
                    ),
                    const SizedBox(width: 8.0),
                    FilledButton.tonal(
                      onPressed: () {
                        if (widget.data['github_link'].isNotEmpty) {
                          launchUrl(Uri.parse(widget.data['github_link']));
                        } else {
                          snackbar(
                              context,
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock_rounded,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Project is not yet public!',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              isFloating: !widget.smallScreen);
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      child: const Text('Code'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
