import 'package:openfoodfacts/openfoodfacts.dart';

Future<Product?> getProduct(String? barcode) async {
  // var barcode = '0048151623426';
  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'Food Inquery',
  );

  final ProductQueryConfiguration configuration = ProductQueryConfiguration(
    barcode!,
    language: OpenFoodFactsLanguage.FRENCH,
    fields: [ProductField.ALL],
    version: ProductQueryVersion.v3,
  );
  // User myUser = const User(userId: 'mtouati', password: 'Mounib2003!');
  final ProductResultV3 result =
      await OpenFoodAPIClient.getProductV3(configuration
          // , user: myUser
          );

  if (result.status == ProductResultV3.statusSuccess) {
    return result.product;
  } else {
    throw Exception('product not found, please insert data for $barcode');
  }
}
