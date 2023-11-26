import 'package:flutter/material.dart';
import 'package:terminal_portfolio/app_colors.dart';
import 'package:terminal_portfolio/command_outputs/cat.dart';
import 'package:terminal_portfolio/command_outputs/welcome.dart';
import 'package:terminal_portfolio/command_outputs/help.dart';
import 'package:terminal_portfolio/command_outputs/download.dart';
import 'package:terminal_portfolio/command_outputs/contact.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'command_outputs/about.dart';

// This file contains the implementation of a command-line interface for a Flutter application.
// The interface allows users to enter commands and displays corresponding outputs based on the entered commands.
// It also includes various command outputs such as welcome message, help information, downloads, contact details, and more.

class CommandLine extends StatefulWidget {
  const CommandLine({super.key});

  @override
  _CommandLineState createState() => _CommandLineState();
}

class _CommandLineState extends State<CommandLine> {
  final List<TextEditingController> _textEdittingControllers = [];
  final List<Widget> _terminalOutputs = <Widget>[];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textEdittingControllers.add(TextEditingController());
    _textEdittingControllers[0].text = 'welcome';
    _addCommand('welcome');
  }

  @override
  void dispose() {
    for (var controller in _textEdittingControllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

// Adds a new command to the terminal outputs based on the entered command.
  void _addCommand(String command) {
    switch (command.toLowerCase()) {
      case "welcome":
        setState(() {
          _terminalOutputs.add(Welcome());
        });
        break;

      case "help":
        setState(() {
          _terminalOutputs.add(const Help());
        });
        break;

      case "download":
        setState(() {
          _terminalOutputs.add(const Download());
        });
        break;

      case "contact":
        setState(() {
          _terminalOutputs.add(Contact());
        });
        break;

      case "about":
        setState(() {
          _terminalOutputs.add(About());
        });
        break;

      case "clear":
        setState(() {
          _terminalOutputs.clear();
          _textEdittingControllers.clear();
        });
        break;

      case "cat":
        setState(() {
          _terminalOutputs.add(Cat());
        });
        break;

      default:
        setState(() {
          _terminalOutputs.add(const Help());
        });
        break;
    }
  }

// Builds and returns the terminal widget for a specific index.
  Widget _terminal(int index) {
    TextEditingController controller = TextEditingController();
    _textEdittingControllers.add(controller);
    return Row(children: [
      const Text(
        "raheleh's",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: AppColors.orangeColor,
        ),
      ),
      const Text("guest",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.orangeColor,
          )),
      const Text("@terminal.site",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.pinkColor,
          )),
      const Text(" : ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.white,
          )),
      const Text("~\$ ",
          style: TextStyle(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
            color: AppColors.pinkColor,
          )),
      Expanded(
          child: TextField(
        autofocus: true,
        readOnly: _terminalOutputs.length == index + 1 ? true : false,
        style: const TextStyle(color: Colors.white),
        controller: _textEdittingControllers[index],
        onSubmitted: _addCommand,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        {_scrollController.jumpTo(_scrollController.position.maxScrollExtent)});
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/stars_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcOver,
            ),
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 100),
          controller: _scrollController,
          itemCount: _terminalOutputs.length + 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _terminal(index),
                index < _terminalOutputs.length
                    ? _terminalOutputs[index]
                    : Container(),
              ],
            );
          },
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0),
          ),
          image: DecorationImage(
            image: const AssetImage('images/stars_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0),
                ),
                image: DecorationImage(
                  image: const AssetImage('images/stars_background.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.srcOver,
                  ),
                ),
              ),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Made With ',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      mouseCursor: SystemMouseCursors.click,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchURL(
                            'https://github.com/coderahh/terminalportfolio'),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '\u2764',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [
                            for (double i = 1; i < 4; i++)
                              Shadow(
                                  color: const Color.fromARGB(255, 255, 19, 2),
                                  blurRadius: 3 * i)
                          ]),
                      mouseCursor: SystemMouseCursors.click,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchURL(
                            'https://github.com/coderahh/terminalportfolio'),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: ' By Raheleh Hasani',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      mouseCursor: SystemMouseCursors.click,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchURL(
                            'https://github.com/coderahh/terminalportfolio'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
