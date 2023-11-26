import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:terminal_portfolio/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

// This file contains the implementation of the "Contact" widget,
// which provides a form for users to send an email
// or reach out via LinkedIn.

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool buttonIsPressed = false;
  bool bodyInputIsHovered = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  // Sends an email using the provided subject and body.
  void _sendEmail() {
    if (_formKey.currentState!.validate()) {
      final String subject = _subjectController.text.trim();
      final String body = _bodyController.text.trim();

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'hraColors.pink.shade300helehr@gmail.com',
        queryParameters: {
          'subject': subject,
          'body': body,
        },
      );

      html.window.open(emailUri.toString(), '_self');
    }
  }

// Launches the URL in the browser.
  void _launchURL(url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'you can message to me in ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Linkdin.',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            for (double i = 1; i < 3; i++)
                              Shadow(
                                  color: AppColors.blueColor, blurRadius: 2 * i)
                          ]),
                      mouseCursor: SystemMouseCursors.click,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchURL(
                            'https://www.linkedin.com/in/raheleh-hasani-750152164?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'or you can send email to me through this form :',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _subjectController,
            autocorrect: true,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Please enter the subject.',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.pinkColor.withOpacity(0.5), width: 3),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 162, 17, 6).withOpacity(0.3),
                  width: 3,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 203, 14, 0),
                  width: 3,
                ),
              ),
              errorStyle: const TextStyle(
                color: Color.fromARGB(255, 143, 10, 0),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter the subject';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _bodyController,
            autocorrect: true,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Please enter the body.',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              /* border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 5),
                      ),*/
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.pinkColor.withOpacity(0.5), width: 3),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 162, 17, 6).withOpacity(0.3),
                  width: 3,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 203, 14, 0),
                  width: 3,
                ),
              ),
              errorStyle: const TextStyle(
                color: Color.fromARGB(255, 143, 10, 0),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            maxLines: 5,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter the body';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  for (double i = 1; i < 5; i++)
                    BoxShadow(
                        color: AppColors.pinkColor,
                        blurRadius: (buttonIsPressed ? 4 : 0) * i,
                        //spreadRadius: -2,
                        blurStyle: BlurStyle.outer),
                ]),
            child: TextButton(
              onHover: (hovered) => setState(() {
                buttonIsPressed = hovered;
              }),
              onPressed: _sendEmail,
              child: Text(
                'Send Email',
                style: TextStyle(color: Colors.white, shadows: [
                  for (double i = 1; i < 4; i++)
                    Shadow(
                        color: AppColors.pinkColor,
                        blurRadius: (buttonIsPressed ? 3 : 2) * i)
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
