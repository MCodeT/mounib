import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:barcode/apiQueries/openFoodsQueries.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _scanBarcode = '';
  String _productName = '';
  String _imageFrontUrl = '';

  List<Ingredient> _ingredients = [];
  String _ingredientsText = '';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    Product? _produit;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      _produit = await getProduct(barcodeScanRes);
      if (mounted) {
        setState(() {
          _scanBarcode = (barcodeScanRes != null) ? barcodeScanRes : '';
          _productName = _produit!.productName ?? '';
          _imageFrontUrl = _produit.imageFrontUrl ?? '';
          _ingredients = _produit!.ingredients ?? [];
          _ingredientsText = _produit!.ingredientsText ?? '';
          _produit.allergens;
        });
      }
      ;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: scanBarcodeNormal,
        child: const Icon(Icons.barcode_reader),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (_imageFrontUrl != '')
                        ? Image.network(_imageFrontUrl)
                        : const Icon(Icons.access_time)
                  ],
                ),
                const SizedBox(height: 5),
                Text(_scanBarcode),
                const SizedBox(height: 5),
                Text(_productName),
                const SizedBox(height: 5),
                Text(_ingredientsText),
              ])),
    );
  }
}
