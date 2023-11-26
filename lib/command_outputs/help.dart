import 'package:flutter/material.dart';
import 'package:terminal_portfolio/app_colors.dart';

// This file contains the implementation of the "Help" widget, which displays a list of available commands
// and their explanations in a column layout.
class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of available commands
    List<String> commands = <String>[
      "about",
      "contact",
      "cat",
      "clear",
      "download",
      "welcome"
    ];

    // List of explanations for each command
    List<String> explaintions = <String>[
      "- learn about me",
      "- contact me",
      "- see some cute cat images",
      "- clear your screen",
      "- download my resume as pdf",
      "- see the welcome banner"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'these are all available commands :',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Command list
            Container(
              width: 100,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commands.length,
                itemBuilder: (context, index) {
                  return Text(
                    commands[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.pinkColor,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commands.length,
                itemBuilder: (context, index) {
                  return Text(explaintions[index],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
