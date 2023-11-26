import 'dart:html';
import 'package:flutter/material.dart';

// This file contains the implementation of the "Download" widget,
// which downloads a resume file when initialized

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  bool _isDownloading = false;
  bool _downloadCompleted = true;

  @override
  void initState() {
    super.initState();
    _downloadFile(); // Call the download file method when the widget is initialized
    setState(() {
      _isDownloading = true;
      _downloadCompleted = false;
    });
  }

// Downloads the resume file.
  _downloadFile() {
    AnchorElement anchorElement =
        AnchorElement(href: 'assets/files/resume.pdf');
    anchorElement.download = "Raheleh Hasani's resume";
    anchorElement.click();

    setState(() {
      _isDownloading = false;
      _downloadCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isDownloading
        ? const Text(
            'Downloading...') // Display "Downloading..." text if the file is being downloaded
        : _downloadCompleted
            ? const Text(
                'Download Completed!') // Display "Download Completed!" text if the download is completed
            : Container(); // Display an empty container if the download is not completed
  }
}
