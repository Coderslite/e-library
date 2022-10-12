import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class ViewBook extends StatefulWidget {
  final String bookUrl;
  const ViewBook({Key? key, required this.bookUrl}) : super(key: key);

  @override
  State<ViewBook> createState() => _ViewBookState();
}

class _ViewBookState extends State<ViewBook> {
  @override
  void initState() {
    loadPdf();
    super.initState();
  }

  final sampleUrl = 'https://activeglobalfx.com/e-library/books/';
  String? pdfFlePath;

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample1.pdf');
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(widget.bookUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  void loadPdf() async {
    pdfFlePath = await downloadAndSavePdf();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 31, 44),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              // ElevatedButton(
              //   child: Text("Load pdf"),
              //   onPressed: loadPdf,
              // ),
              if (pdfFlePath != null)
                Expanded(
                  child: Container(
                    child: PdfView(path: pdfFlePath!),
                  ),
                )
              else
                Text("Pdf is not Loaded"),
            ],
          ),
        ),
      ),
    );
  }
}
