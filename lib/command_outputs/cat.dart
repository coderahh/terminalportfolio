import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// This file contains the implementation of the "Cat" widget,
//which displays a grid of cat images fetched from the Cat API.

class Cat extends StatefulWidget {
  Cat({Key? key}) : super(key: key);

  @override
  State<Cat> createState() => _CatState();
}

class _CatState extends State<Cat> {
  List<dynamic> imageUrls = [];
  bool isLoading = true;

  // Fetches cat images from the Cat API using an HTTP GET request.
  Future<void> fetchAstronautCatImages() async {
    final response = await http.get(Uri.parse(
        'https://api.thecatapi.com/v1/images/search?api_key=live_HSB1frziZ6I5G7odr5JBzG7mFYqOHLWhiyDlr0Nu9itec2hivPjpeOWDVBZlgM7J&limit=20'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        imageUrls = data.map((item) => item['url']).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAstronautCatImages();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          final Completer<void> completer = Completer<void>();
          final html.ImageElement image = html.ImageElement()
            ..src = imageUrls[index]
            ..style.width = '100%'
            ..style.height = '100%'
            ..onLoad.listen((_) {
              completer.complete();
            })
            ..onError.listen((html.Event event) {
              completer.completeError(event);
            });

          // Register the image element as a platform view
          ui.platformViewRegistry
              .registerViewFactory(imageUrls[index], (int _) => image);

          return FutureBuilder<void>(
            future: completer.future,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Return the HTML element view once the image has loaded
                return HtmlElementView(
                  viewType: imageUrls[index],
                );
              } else {
                // Show a progress indicator while the image is loading
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
            },
          );
        },
      ),
    );
  }
}
