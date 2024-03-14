import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PdfDownloader extends StatefulWidget {
  final String pdfUrl;

  PdfDownloader({required this.pdfUrl});

  @override
  _PdfDownloaderState createState() => _PdfDownloaderState();
}

class _PdfDownloaderState extends State<PdfDownloader> {
  bool _downloading = false;

  Future<void> _downloadPdf(String downloadPath) async {
    setState(() {
      _downloading = true;
    });

    try {
      // Make GET request to download PDF
      var response = await http.get(Uri.parse(widget.pdfUrl));

      if (response.statusCode == 200) {
        // Create custom directory if not exists
        Directory(downloadPath).createSync(recursive: true);

        // Write response body to file
        File pdfFile = File('$downloadPath/${DateTime.now().microsecondsSinceEpoch}.pdf');
        await pdfFile.writeAsBytes(response.bodyBytes);

        setState(() {
          _downloading = false;
        });

        print('PDF downloaded successfully');
        print('PDF downloaded to: $downloadPath');
      } else {
        print('Failed to download PDF: ${response.statusCode}');
        setState(() {
          _downloading = false;
        });
      }
    } catch (e) {
      print('Error downloading PDF: $e');
      setState(() {
        _downloading = false;
      });
    }
  }

  Future<void> _showDownloadLocationDialog() async {
    String? downloadPath = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Download Location'),
          content: Text('Choose where you want to save the PDF file.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('/storage/emulated/0/Download/Resume file/MyResume');
              },
              child: Text('Resume Directory'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('/storage/emulated/0/Download');
              },
              child: Text('Download Directory'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null); // Cancel button
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (downloadPath != null) {
      _downloadPdf(downloadPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Download'),
      ),
      body: Center(
        child: _downloading
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: _showDownloadLocationDialog,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Download',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('your_collection').doc('your_document_id').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String pdfUrl = snapshot.data!['pdfUrl'];
            return Center(
              child: PdfDownloader(pdfUrl: pdfUrl),
            );
          }
        },
      ),
    ),
  ));
}
