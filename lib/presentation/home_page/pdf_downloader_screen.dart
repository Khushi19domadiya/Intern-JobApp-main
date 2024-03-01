import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfDownloader extends StatefulWidget {
  final String pdfUrl;

  PdfDownloader({required this.pdfUrl});

  @override
  _PdfDownloaderState createState() => _PdfDownloaderState();
}

class _PdfDownloaderState extends State<PdfDownloader> {
  bool _downloading = false;

  Future<void> _downloadPdf() async {
    setState(() {
      _downloading = true;
    });

    try {
      // Make GET request to download PDF
      var response = await http.get(Uri.parse(widget.pdfUrl));

      // Get temporary directory path
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Write response body to file
      File pdfFile = File('$tempPath/example.pdf');
      await pdfFile.writeAsBytes(response.bodyBytes);

      setState(() {
        _downloading = false;
      });

      print('PDF downloaded successfully');
    } catch (e) {
      print('Error downloading PDF: $e');
      setState(() {
        _downloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Downloader'),
      ),
      body: Center(
        child: _downloading
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: _downloadPdf,
          child: Text('Download PDF'),
        ),
      ),
    );
  }
}

