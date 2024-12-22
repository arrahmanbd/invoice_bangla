import 'package:flutter/material.dart';
import 'utils/pdf_helper.dart';
import 'make_invoice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice PDF Generate',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:  const Text('PDF Invoice in Bnagla', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.document_scanner_outlined,
              size: 72.0,
              color: Colors.black,
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Billing Info',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.teal)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
                child: Text(
                  'Create Invoice PDF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              onPressed: () async {
                // generate pdf invoice file
                final pdfFile = await PdfInvoiceApi.generate();
                PDFHelper.openFile(pdfFile);
              },
            ),
          ],
        ),
      ),
    );
  }
}
