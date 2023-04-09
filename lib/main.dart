import 'package:flutter/material.dart';
import 'file_handler.dart';
import 'invoice_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
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
                backgroundColor: MaterialStateProperty.all(Colors.indigo)
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
                child: Text(
                  'Create Invoice',
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
                FileHandleApi.openFile(pdfFile);
              },
            ),
          ],
        ),
      ),
    );
  }
}
