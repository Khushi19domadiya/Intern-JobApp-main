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

  Future<void> _downloadPdf() async {
    setState(() {
      _downloading = true;
    });

    try {
      // Make GET request to download PDF
      var response = await http.get(Uri.parse(widget.pdfUrl));

      if (response.statusCode == 200) {
        // Define the custom download path
        String downloadPath = '/storage/emulated/0/Download/Resume file/MyResume';

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
            String pdfUrl = snapshot.data!['pdfUrl']; // Assuming 'pdfUrl' is the field containing the URL of the PDF file
            return Center(
              child: PdfDownloader(pdfUrl: pdfUrl),
            );
          }
        },
      ),
    ),
  ));
}