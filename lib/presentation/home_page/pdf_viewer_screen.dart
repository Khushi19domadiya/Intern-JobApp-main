import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:saumil_s_application/util/colors.dart';
import 'dart:io';

import 'pdf_downloader_screen.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl;

  PdfViewerPage({required this.pdfUrl});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late String _localPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initLocalPath();
  }

  Future<void> _initLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      _localPath = directory.path;
    });
  }

  Future<void> _downloadPDF(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));
    final File file = File('$_localPath/$fileName');
    await file.writeAsBytes(response.bodyBytes);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fileName = widget.pdfUrl.split('/').last;
    if (_localPath == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('PDF Viewer'),

        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('PDF Viewer'),
          actions: [IconButton(onPressed: (){

            Get.to(()=>PdfDownloader(pdfUrl: widget.pdfUrl,));
          }, icon: Icon(Icons.download,color: primaryBlack,))],
        ),

        body: PDFView(
          filePath: '$_localPath/$fileName',
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          pageFling: false,
        ),
      );
    }

    _downloadPDF(widget.pdfUrl, fileName);

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

