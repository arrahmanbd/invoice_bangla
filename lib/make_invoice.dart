import 'dart:io';
import 'package:intl/intl.dart';
import 'package:new_invoice_bangla/utils/bangla_unicode_util.dart';
import 'constants/constant.dart';
import 'utils/pdf_helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as invoice;

class PdfInvoiceApi {
  static Future<File> generate() async {
    final pdf = invoice.Document();
    final DateTime now = DateTime.now();
    final String time = DateFormat('h:mm:ss').format(now);
    final String date =
        DateFormat('dd/MM/yyyy').format(now); // Corrected date format
    final iconImage = await PDFHelper.loadImage(brand);
    final banglaFont = await PDFHelper.setBanglaFont();
    final unifont = invoice.Font.ttf(banglaFont);

    // Example table data
    List<List<String>> tableData = [
      ["চা".toRepair(), '7', '\$ 5', '1 %', '\$ 35'],
      ["কফি".toRepair(), '5', '\$ 10', '2 %', '\$ 50'],
      ["বিস্কুট".toRepair(), '1', '\$ 3', '1.5 %', '\$ 3'],
      ["খেজূর".toRepair(), '6', '\$ 8', '2 %', '\$ 48'],
      ["বিরিয়ানি".toRepair(), '3', '\$ 90', '12 %', '\$ 270'],
      ["ছোলা".toRepair(), '2', '\$ 15', '0.5 %', '\$ 30'],
      ["দুধ কফি".toRepair(), '4', '\$ 7', '0.5 %', '\$ 28'],
    ];

    pdf.addPage(
      invoice.MultiPage(
        build: (context) {
          return [
            invoice.Row(
              children: [
                invoice.Image(
                  invoice.MemoryImage(iconImage),
                  height: 72,
                  width: 72,
                ),
                invoice.SizedBox(width: 1 * PdfPageFormat.mm),
                invoice.Column(
                  crossAxisAlignment: invoice.CrossAxisAlignment.start,
                  children: [
                    invoice.Text(
                      name,
                      style: invoice.TextStyle(font: unifont, fontSize: 17.0),
                    ),
                    invoice.Text(
                      cashmemo,
                      style: invoice.TextStyle(
                        font: unifont,
                        fontSize: 15.0,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                invoice.Spacer(),
                invoice.Column(
                  crossAxisAlignment: invoice.CrossAxisAlignment.end,
                  children: [
                    invoice.Row(
                      children: [
                        invoice.Text(
                          'সময়ঃ '.toRepair(),
                          style: invoice.TextStyle(font: unifont),
                        ),
                        invoice.Text(
                          time,
                          style: invoice.TextStyle(font: unifont),
                        ),
                      ],
                    ),
                    invoice.Row(
                      children: [
                        invoice.Text(
                          'তারিখঃ '.toRepair(),
                          style: invoice.TextStyle(font: unifont),
                        ),
                        invoice.Text(
                          date,
                          style: invoice.TextStyle(font: unifont),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            invoice.SizedBox(height: 10 * PdfPageFormat.mm),
            invoice.Table(
              border: null,
              children: [
                invoice.TableRow(
                  decoration:
                      const invoice.BoxDecoration(color: PdfColors.grey300),
                  children: tableHeaders.map((header) {
                    return invoice.Padding(
                      padding: const invoice.EdgeInsets.all(5),
                      child: invoice.Text(
                        header,
                        style: invoice.TextStyle(
                          fontWeight: invoice.FontWeight.bold,
                          font: unifont,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                ...tableData.map((row) {
                  return invoice.TableRow(
                    children: row.map((cell) {
                      return invoice.Padding(
                        padding: const invoice.EdgeInsets.all(5),
                        child: invoice.Text(
                          cell,
                          style: invoice.TextStyle(font: unifont),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
            invoice.Divider(),
          ];
        },
        footer: (context) {
          return invoice.Column(
            mainAxisSize: invoice.MainAxisSize.min,
            children: [
              invoice.Divider(),
              invoice.Text(
                company,
                style: invoice.TextStyle(
                  fontWeight: invoice.FontWeight.bold,
                  font: unifont,
                ),
              ),
            ],
          );
        },
      ),
    );

    return PDFHelper.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
