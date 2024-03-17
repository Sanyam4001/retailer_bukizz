import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:retailer_bukizz/controller/order_controller.dart';

class PDFViewer extends StatefulWidget {
  // final Uint8List function;
  const PDFViewer({super.key});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {

    var controller=Get.put(OrderController());

    double price = 0.0;
    double cancel = 0.0;

    try {
      price = double.parse(controller.selectedOrder.grossamount);
    } catch (e) {
      print('Error parsing price: $e');
    }

    try {
      cancel = double.parse(controller.selectedOrder.cancellationcharges);
    } catch (e) {
      print('Error parsing cancel: $e');
    }

    double total=cancel+price;

    // var order = context.read<Order>().getSelectedOrder;
    Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
      final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
      final font = await PdfGoogleFonts.nunitoMedium();
      final boldFont = await PdfGoogleFonts.nunitoBold();
      final extraBoldFont = await PdfGoogleFonts.nunitoExtraBold();


      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'BUKIZZ',
                           style: pw.TextStyle(
                             fontWeight: pw.FontWeight.bold,
                             font: extraBoldFont,
                             fontSize: 40,
                           )
                        ),
                        pw.SizedBox(
                          width: 250,
                          child: pw.Text(
                              'SHIP TO\n ${controller.selectedOrder.name} \n ${controller.selectedOrder.address}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: boldFont,
                                fontSize: 15,
                              )
                          )
                        ),
                        pw.SizedBox(height: 5),
                        pw.SizedBox(
                            width: 250,
                            child: pw.Text(
                                ('${controller.selectedOrder.city} ,${controller.selectedOrder.pincode}'),
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  font: boldFont,
                                  fontSize: 15,
                                )
                            )
                        ),
                        pw.Text(
                            controller.selectedOrder.mobile,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: boldFont,
                              fontSize: 15,
                            )
                        )
                      ]
                    ),
                    pw.Column(

                      children: [
                        pw.Text(
                            controller.selectedOrder.ordernumber,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: extraBoldFont,
                              fontSize: 20,
                            )
                        ),
                        pw.SizedBox(height: 15),
                        pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.BarcodeWidget(
                            barcode: pw.Barcode.qrCode(),
                            data: controller.selectedOrder.ordernumber,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ]
                    )
                  ]
                ),
                pw.SizedBox(height: 15),
                pw.Container(
                  height: 2,
                  width: 1000,
                  color: PdfColors.black
                ),
                pw.SizedBox(height: 15),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'ITEMS',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            font: boldFont,
                            fontSize: 15,
                          )
                        ),
                        // pw.SizedBox(height: 20),
                        pw.Text(
                            'QUANTITY',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: boldFont,
                              fontSize: 15,
                            )
                        ),
                        // pw.SizedBox(height: 20),
                        pw.Text(
                            'PRICE',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: boldFont,
                              fontSize: 15,
                            )
                        ),

                      ]
                    ),
                    pw.SizedBox(height: 30),
                    pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                                controller.selectedOrder.column1,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  font: font,
                                  fontSize: 15,
                                )
                            ),
                            pw.SizedBox(height: 2),
                            pw.Text(
                                controller.selectedOrder.column2,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  font: font,
                                  fontSize: 15,
                                )
                            ),
                            pw.SizedBox(height: 2),
                            pw.Text(
                                controller.selectedOrder.column3,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  font: font,
                                  fontSize: 15,
                                )
                            ),
                          ]
                        ),
                        // pw.SizedBox(height: 20),
                        pw.SizedBox(
                          width: 100,
                          child: pw.Text(
                              '1',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                font: font,
                                fontSize: 15,
                              ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        // pw.SizedBox(height: 20),
                        pw.Text(
                            'Rs. ${controller.selectedOrder.grossamount}',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: font,
                              fontSize: 15,
                            )
                        ),

                      ]
                    ),
                    pw.SizedBox(height: 30),
                    if(controller.selectedOrder.cancellationcharges!='')
                    pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                            'Cancellation/Return Charge',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: font,
                              fontSize: 15,
                            )
                        ),
                        // pw.SizedBox(height: 20),
                        pw.Text(
                          '',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            font: font,
                            fontSize: 15,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        // pw.SizedBox(height: 20),
                        pw.Text(
                            'Rs. ${controller.selectedOrder.cancellationcharges}',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              font: font,
                              fontSize: 15,
                            )
                        )
                      ]
                    ),

                  ]
                ),

                pw.SizedBox(height: 15),
                pw.Container(
                    height: 2,
                    width: 1000,
                    color: PdfColors.black
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                        'TOTAL',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          font: extraBoldFont,
                          fontSize: 15,
                        )
                    ),
                    pw.Text(
                        'Rs. ${total}',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          font: extraBoldFont,
                          fontSize: 15,
                        )
                    )
                  ]
                ),
                pw.SizedBox(height: 15),

                pw.Center(
                  child: pw.Text(
                      'THANK YOU FOR SHOPPING WITH BUKIZZ....',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        font: extraBoldFont,
                        fontSize: 15,
                      ),
                      textAlign: pw.TextAlign.center
                  )
                )
              ],
            );
          },
        ),
      );
      return pdf.save();
    }
    return PdfPreview(
      build: (format) => _generatePdf(format, "PDFVIEWER"),
    );
  }


}
