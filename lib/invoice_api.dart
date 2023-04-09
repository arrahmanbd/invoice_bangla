import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'constant.dart';
import 'file_handler.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as invoice;
import 'parse_unicode.dart';

class PdfInvoiceApi {
  static Future<File> generate() async {
    final pdf = invoice.Document();
    final DateTime now = DateTime.now();
    final String time = DateFormat('h:mm:ss').format(now);
    final String date = DateFormat('dd/mm/yyyy').format(now);
    final iconImage =(await rootBundle.load(InVoiceConst.brand)).buffer.asUint8List();
    final font = await rootBundle.load(InVoiceConst.font);
    final unifont = invoice.Font.ttf(font);

    final tableData = [
      [
        uniCode("চা "),
        '7',
        '\$ 5',
        '1 %',
        '\$ 35',
      ],
      [
        uniCode("কফি "),
        '5',
        '\$ 10',
        '2 %',
        '\$ 50',
      ],
      [
        uniCode("বিস্কুট "),
        '1',
        '\$ 3',
        '1.5 %',
        '\$ 3',
      ],
      [
        uniCode("খেজূর"), 
        '6',
        '\$ 8',
        '2 %',
        '\$ 48',
      ],
      [
        uniCode("বিরিয়ানি "),
        '3',
        '\$ 90',
        '12 %',
        '\$ 270',
      ],
      [
        uniCode("ছোলা"),
        '2',
        '\$ 15',
        '0.5 %',
        '\$ 30',
      ],
      [
        uniCode("দুধ কফি "),
        '4',
        '\$ 7',
        '0.5 %',
        '\$ 28',
      ],
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
                  mainAxisSize: invoice.MainAxisSize.min,
                  crossAxisAlignment: invoice.CrossAxisAlignment.start,
                  children: [
                    invoice.Text(
                      InVoiceConst.greetings,
                      style: invoice.TextStyle(
                        font: unifont,
                        fontSize: 17.0,
                        fontWeight: invoice.FontWeight.bold,
                      ),
                    ),
                    invoice.Text(
                      InVoiceConst.cashmemo,
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
                  mainAxisSize: invoice.MainAxisSize.min,
                  crossAxisAlignment: invoice.CrossAxisAlignment.end,
                  children: [
                    invoice.Row(children: [
                      invoice.Text(uniCode('সময়ঃ '),
                          style: invoice.TextStyle(
                            font: unifont,
                          )),
                      invoice.Text(time,
                          style: invoice.TextStyle(
                            font: unifont,
                          )),
                    ]),
                    invoice.Row(children: [
                      invoice.Text(uniCode('তারিখঃ  '),
                          style: invoice.TextStyle(
                            font: unifont,
                          )),
                      invoice.Text(date,
                          style: invoice.TextStyle(
                            font: unifont,
                          )),
                    ])
                  ],
                ),
              ],
            ),
            invoice.SizedBox(height: 10 * PdfPageFormat.mm),
            ///
            /// PDF Table Create
            ///
            invoice.Table.fromTextArray(
              headers: InVoiceConst.tableHeaders,
              data: tableData,
              border: null,
              headerStyle: invoice.TextStyle(
                fontWeight: invoice.FontWeight.bold,
                font: unifont,
              ),
              headerDecoration:
                  const invoice.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30.0,
              cellStyle: invoice.TextStyle(
                font: unifont,
              ),
              // oddCellStyle: invoice.TextStyle(font: unifont,),
              cellAlignments: {
                0: invoice.Alignment.centerLeft,
                1: invoice.Alignment.centerRight,
                2: invoice.Alignment.centerRight,
                3: invoice.Alignment.centerRight,
                4: invoice.Alignment.centerRight,
              },
            ),
            invoice.Divider(),
            invoice.Container(
              alignment: invoice.Alignment.centerRight,
              child: invoice.Row(
                children: [
                  invoice.Spacer(flex: 6),
                  invoice.Expanded(
                    flex: 4,
                    child: invoice.Column(
                      crossAxisAlignment: invoice.CrossAxisAlignment.start,
                      children: [
                        invoice.Row(
                          children: [
                            invoice.Expanded(
                              child: invoice.Text(
                                InVoiceConst.totalTitle,
                                style: invoice.TextStyle(
                                  font: unifont,
                                  fontWeight: invoice.FontWeight.bold,
                                ),
                              ),
                            ),
                            invoice.Text(
                              '\$ 464',
                              style: invoice.TextStyle(
                                font: unifont,
                                fontWeight: invoice.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        invoice.Row(
                          children: [
                            invoice.Expanded(
                              child: invoice.Text(
                                '${InVoiceConst.vat} + 19.5 %',
                                style: invoice.TextStyle(
                                  font: unifont,
                                  fontWeight: invoice.FontWeight.bold,
                                ),
                              ),
                            ),
                            invoice.Text(
                              '\$ 90.48',
                              style: invoice.TextStyle(
                                font: unifont,
                                fontWeight: invoice.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        invoice.Divider(),
                        invoice.Row(
                          children: [
                            invoice.Expanded(
                              child: invoice.Text(
                                InVoiceConst.totalDueTitle,
                                style: invoice.TextStyle(
                                  font: unifont,
                                  fontSize: 14.0,
                                  fontWeight: invoice.FontWeight.bold,
                                ),
                              ),
                            ),
                            invoice.Text(
                              '\$ 554.48',
                              style: invoice.TextStyle(
                                font: unifont,
                                fontWeight: invoice.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        invoice.SizedBox(height: 2 * PdfPageFormat.mm),
                        invoice.Container(height: 1, color: PdfColors.grey400),
                        invoice.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        invoice.Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        footer: (context) {
          return invoice.Column(
            mainAxisSize: invoice.MainAxisSize.min,
            children: [
              invoice.Divider(),
              invoice.SizedBox(height: 2 * PdfPageFormat.mm),
              //Company Name
              invoice.Text(
                InVoiceConst.company,
                style: invoice.TextStyle(
                  fontWeight: invoice.FontWeight.bold,
                  font: unifont,
                ),
              ),
              invoice.SizedBox(height: 1 * PdfPageFormat.mm),
              invoice.Row(
                mainAxisAlignment: invoice.MainAxisAlignment.center,
                children: [
                  //Address
                  invoice.Text(
                    InVoiceConst.addresssTitle,
                    style: invoice.TextStyle(
                      fontWeight: invoice.FontWeight.bold,
                      font: unifont,
                    ),
                  ),
                  invoice.Text(InVoiceConst.address,
                      style: invoice.TextStyle(
                        font: unifont,
                      )),
                ],
              ),
              invoice.SizedBox(height: 1 * PdfPageFormat.mm),
              invoice.Row(
                mainAxisAlignment: invoice.MainAxisAlignment.center,
                children: [
                  invoice.Text(
                    InVoiceConst.telTitle,
                    style: invoice.TextStyle(
                      fontWeight: invoice.FontWeight.bold,
                      font: unifont,
                    ),
                  ),
                  invoice.Text(
                    InVoiceConst.mobile,
                    style: invoice.TextStyle(
                      font: unifont,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
