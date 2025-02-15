import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:page_flip/page_flip.dart';
import 'package:path_provider/path_provider.dart';

class PDFReaderScreen extends StatefulWidget {
  final String pdfAssetPath;

  PDFReaderScreen({required this.pdfAssetPath});

  @override
  _PDFReaderScreenState createState() => _PDFReaderScreenState();
}

class _PDFReaderScreenState extends State<PDFReaderScreen> {
  int _totalPages = 0;
  int _currentPage = 0;
  PDFViewController? _pdfViewController;
  bool _isLoading = true;
  String? _localPDFPath;
  final _pageFlipKey = GlobalKey<PageFlipWidgetState>();

  @override
  void initState() {
    super.initState();
    // Enter immersive mode.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      // Load the PDF from assets.
      final bytes = await rootBundle.load(widget.pdfAssetPath);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/temp.pdf');
      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
      setState(() {
        _localPDFPath = file.path;
      });
    } catch (e) {
      print("Error loading PDF: $e");
    }
  }

  @override
  void dispose() {
    // Restore the system UI.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show a loader until the local PDF path is available.
    if (_localPDFPath == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else
            _buildPageFlipWidget(),
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              'Page ${_currentPage + 1} of $_totalPages',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageFlipWidget() {
    return PageFlipWidget(
      key: _pageFlipKey,
      backgroundColor: Colors.white,
      lastPage: Container(
        color: Colors.white,
        child: Center(child: Text('End of PDF')),
      ),
      children: List.generate(_totalPages, (index) => _buildPDFPage(index)),
    );
  }

  Widget _buildPDFPage(int pageIndex) {
    return Container(
      color: Colors.white,
      child: PDFView(
        filePath: _localPDFPath,
        pageSnap: false,
        pageFling: false,
        onRender: (pages) {
          setState(() {
            _totalPages = pages ?? 0;
            _isLoading = false;
          });
        },
        onViewCreated: (PDFViewController controller) {
          _pdfViewController = controller;
        },
        onPageChanged: (int? page, int? total) {
          if (page != null && page != _currentPage) {
            setState(() {
              _currentPage = page;
            });
          }
        },
        defaultPage: pageIndex,
      ),
    );
  }
}
