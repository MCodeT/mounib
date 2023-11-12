import 'dart:async';

import 'package:openfoodfacts/openfoodfacts.dart';

/// request a product from the OpenFoodFacts database
Future<Product?> getProduct() async {
  var barcode = '0048151623426';

  final ProductQueryConfiguration configuration = ProductQueryConfiguration(
    barcode,
    language: OpenFoodFactsLanguage.FRENCH,
    fields: [ProductField.ALL],
    version: ProductQueryVersion.v3,
  );
  final ProductResultV3 result =
      await OpenFoodAPIClient.getProductV3(configuration);

  if (result.status == ProductResultV3.statusSuccess) {
    return result.product;
  } else {
    throw Exception('product not found, please insert data for $barcode');
  }
}
