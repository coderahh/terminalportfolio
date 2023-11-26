import 'package:flutter/material.dart';
import 'package:terminal_portfolio/app_colors.dart';

// This file contains the implementation of the "About" widget,
// which displays information about the developer in a typewriter-like animation.

class About extends StatefulWidget {
  About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final _currentCharIndexes = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  // Array of text paragraphs to be displayed in the typewriter animation
  final _texts = [
    "Greetings! I'm Raheleh Hasani, a full-stack web and mobile developer with a passion for creating innovative applications and a background in forex trading.\nWith a diverse range of experiences in both development and trading, I bring a unique perspective to my work.",
    "As a web and mobile developer, I have designed and developed various applications that showcase my proficiency in different technologies.\nAt Tarafdari Website, I played a pivotal role in the creation of the Tarafdari Prediction Web Application.\nLeveraging my skills in Vue.js, PHP, Laravel, and MySQL, I developed a full-stack application that provides accurate predictions to users.",
    "Additionally, I contributed to the development of the Tarafdari Studio Web Application, utilizing Vue.js, Bootstrap, PHP, Laravel, MySQL, and Docker.\nThis project showcased my ability to create efficient and user-friendly web applications.",
    "In the realm of mobile development, I designed and developed the Tarafdari Prediction Mobile Application using Flutter and Dart.\nThis allowed me to leverage cross-platform development to deliver a seamless user experience on mobile devices.",
    "Furthermore, I have experience in creating various services and tools. such as developing a Comment Service, a feature-rich module that enhances user engagement on web platforms\n and crafting a content editor that streamlined content production and editing, employing Vue.js, JavaScript, PHP, Laravel, and MySQL.",
    "In addition to my development expertise, I possess a strong understanding of the financial markets.\nAs a forex trader, I have honed my skills in analyzing market trends and implementing trading strategies.\nI have even created custom indicators and two trading strategies (EAs) using the mql5 code language.",
    "Lastly, I designed and developed my own portfolio site with a command-line style(this site), using Flutter and Dart,\nshowcasing my ability to create unique and visually appealing web experiences. you can find the github repo by clicking the bottom bar.",
    "I am constantly seeking new challenges and opportunities to expand my skills and contribute to exciting projects.\nIf you are interested in collaborating or discussing potential ventures, I would love to connect and explore how we can achieve mutual success.",
    "Thank you for visiting my portfolio site, and I look forward to connecting with you soon!"
  ];

  @override
  void initState() {
    super.initState();

    _typeWrittingAnimation(0);
  }

  // Description: Performs the typewriter-like animation by incrementing the character
  //indexes of the displayed text paragraphs.
  void _typeWrittingAnimation(int index) {
    if (_currentCharIndexes[index] < _texts[index].length) {
      _currentCharIndexes[index]++;
    }
    if (_currentCharIndexes[index] == _texts[index].length) {
      index++;
    }

    setState(() {});

    if (index < _currentCharIndexes.length) {
      Future.delayed(const Duration(milliseconds: 10), () {
        _typeWrittingAnimation(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container for displaying the developer's photo
        Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  for (double i = 1; i < 5; i++)
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 4 * i,
                        blurStyle: BlurStyle.outer),
                ]),
            child: Image.asset(
              'images/photo.jpg',
              fit: BoxFit.contain,
              width: 100,
              height: 100,
            )), //),
        const SizedBox(
          width: 15,
        ),
        // Container for displaying the text paragraphs
        Expanded(
            flex: 2,
            child: Container(
              width: 300,
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.circular(5),
                border: Border(
                    left: BorderSide(color: AppColors.orangeColor, width: 3)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the first text paragraph with the current typing animation
                    Text(
                      _texts[0].substring(0, _currentCharIndexes[0]),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Container for displaying the remaining text paragraphs
                    Container(
                      height: 350,
                      child: ListView.builder(
                        itemCount: _texts.length - 1,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container for each text paragraph
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: AppColors.pinkColor,
                                            width: 5)),
                                  ),
                                  // Display the text paragraph with the current typing animation
                                  child: Text(
                                    _texts[index + 1].substring(
                                        0, _currentCharIndexes[index + 1]),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ]),
            )),
      ],
    );
  }
}
