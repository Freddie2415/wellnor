import 'dart:convert';

import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellnor/models/product.dart';

class PrintService {
  static PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  static const _printerKey = 'selectedPrinter';

  static Future<void> setPrinter(PrinterBluetooth printerBluetooth) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _printerKey,
      json.encode(
        {
          'name': printerBluetooth.name,
          'address': printerBluetooth.address,
          'type': printerBluetooth.type,
        },
      ),
    );
  }

  static Future<PrinterBluetooth> getPrinter() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonBluetoothDevice = json.decode(prefs.getString(_printerKey));
    return PrinterBluetooth(BluetoothDevice.fromJson(jsonBluetoothDevice));
  }

  static Future<String> printReceipt(
      List<Product> products, double discount) async {
    _printerManager.selectPrinter(await getPrinter());
    const PaperSize paper = PaperSize.mm80;

    final PosPrintResult res = await _printerManager.printTicket(
        await _customerOrderReceipt(
            paper: paper, products: products, discount: discount));

    return res.msg;
  }

  static Future<Ticket> _customerOrderReceipt(
      {PaperSize paper, List<Product> products, double discount}) async {
    final Ticket ticket = Ticket(paper);

    // Print image
    /*
    final ByteData data =
    await rootBundle.load('assets/images/rabbit_black.jpg');
    final Uint8List bytes = data.buffer.asUint8List();
    final Image image = decodeImage(bytes);
    ticket.imageRaster(image);
    */

    ticket.text('WELLNORE',
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    ticket.text('889  Watson Lane', styles: PosStyles(align: PosAlign.center));
    ticket.text('New Braunfels, TX', styles: PosStyles(align: PosAlign.center));
    ticket.text('Tel: 830-221-1234', styles: PosStyles(align: PosAlign.center));
    ticket.text('Web: www.example.com',
        styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    ticket.hr();
    ticket.row([
      PosColumn(text: 'Tovar', width: 7),
      PosColumn(text: 'Kol-vo', width: 1),
      PosColumn(
          text: 'Cena', width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: 'Summa', width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    double total = 0;
    for (Product item in products) {
      total += item.price * item.count;
      ticket.row([
        PosColumn(text: '${item.name}', width: 7),
        PosColumn(text: '${item.count}', width: 1),
        PosColumn(
            text: '${item.price}',
            width: 2,
            styles: PosStyles(align: PosAlign.right)),
        PosColumn(
            text: '${item.price * item.count}',
            width: 2,
            styles: PosStyles(align: PosAlign.right)),
      ]);
    }
    ticket.hr();
    double discountValue = 0.0;
    if (discount != 0.0) {
      discountValue = total / 100.0 * discount;
      ticket.row([
        PosColumn(
            text: 'Summa',
            width: 7,
            styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
        PosColumn(
            text: '$total',
            width: 5,
            styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      ]);
      ticket.row([
        PosColumn(
            text: 'Skidka:  %$discount',
            width: 7,
            styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
        PosColumn(
            text: '${(discountValue)}',
            width: 5,
            styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      ]);
    }

    ticket.row([
      PosColumn(
          text: 'Itogo:',
          width: 6,
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text: '${total - discountValue}',
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    ticket.hr(ch: '=', linesAfter: 1);

    ticket.feed(2);
    ticket.text('Spasibo za pokupku!',
        styles: PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    ticket.text(timestamp,
        styles: PosStyles(align: PosAlign.center), linesAfter: 2);

    // Print QR Code from image
    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 200;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());

    //   ticket.image(img);
    // } catch (e) {
    //   print(e);
    // }

    // Print QR Code using native function
    // ticket.qrcode('example.com');

    ticket.feed(2);
    ticket.cut();
    return ticket;
  }
}
