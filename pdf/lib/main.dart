import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Reader',
      home: PdfListScreen(),
    );
  }
}

class PdfListScreen extends StatelessWidget {
  final List<String> pdfFiles = [
    'sample1.pdf',
    'sample2.pdf',
    'sample3.pdf',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF List'),
      ),
      body: ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pdfFiles[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewScreen(pdfName: pdfFiles[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PdfViewScreen extends StatelessWidget {
  final String pdfName;

  PdfViewScreen({required this.pdfName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.asset('assets/$pdfName'),
    );
  }
}
