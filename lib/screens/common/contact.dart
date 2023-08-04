import 'package:aditya_taparia/components/utils.dart';
import 'package:aditya_taparia/screens/mobile/mobile_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Contact extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool smallScreen;
  const Contact({super.key, required this.data, this.smallScreen = false});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        controller: widget.smallScreen ? scrollControllerContact : null,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 48.0),
                child: Text(
                  'I\'d Love To Connect With You!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  'Let Me Get To Know You Better.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue.shade400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8.0,
                ),
                child: Container(
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      ListTile(
                        leading: Icon(
                          Icons.share_location_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                        title: Text(
                          widget.data['contact']['address'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                        title: Text(
                          widget.data['contact']['email'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: widget.data['contact']['email']),
                            );
                            snackbar(
                              context,
                              const Text(
                                'Copied to Clipboard',
                                style: TextStyle(color: Colors.black),
                              ),
                              isFloating: !widget.smallScreen,
                            );
                          },
                          icon: const Icon(
                            Icons.copy,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone_in_talk_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                        title: Text(
                          widget.data['contact']['phone'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: widget.data['contact']['phone']),
                            );
                            snackbar(
                              context,
                              const Text(
                                'Copied to Clipboard',
                                style: TextStyle(color: Colors.black),
                              ),
                              isFloating: !widget.smallScreen,
                            );
                          },
                          icon: const Icon(
                            Icons.copy,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
