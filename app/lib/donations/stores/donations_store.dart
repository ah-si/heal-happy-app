import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/network/api_provider.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';

final donateStoreProvider = ChangeNotifierProvider((_) => DonationsStore());

class ProductsResults {
  final List<Product> products;
  final ErrorResultException? error;

  ProductsResults(this.products, {this.error});
}

enum DonateMode {
  oneTime,
  recurrent,
}

class DonationsStore extends ChangeNotifier {
  final DonationsApi _donationsApi;
  ProductsResults? productsResults;
  List<Product> _products = [];
  DonateMode _donateMode = DonateMode.oneTime;
  late String sessionId;

  DonationsStore({DonationsApi? donationsApi})
      : _donationsApi = donationsApi ?? BackendApiProvider().api.getDonationsApi();

  DonateMode get donateMode => _donateMode;

  set donateMode(DonateMode value) {
    if (_donateMode != value) {
      _donateMode = value;
      productsResults = null;
      _filterProducts();
      notifyListeners();
    }
  }

  Future<void> loadPaymentSessionId(Product product, bool isDonation, String? email) async {
    final results = await _donationsApi.getSessionInfo(
        id: product.id,
        type: isDonation ? 'donation' : 'payment',
        email: email,
        mode: product.isRecurrent ? 'subscription' : 'payment');
    sessionId = results.data!.id;
  }

  void loadPaymentProducts(bool isDonation) async {
    try {
      _products = [];
      productsResults = null;
      notifyListeners();
      final results = await _donationsApi.getProducts(type: isDonation ? 'donation' : 'payment');
      _products = results.data!.toList(growable: false);
      _filterProducts();
    } on DioError catch (error, stackTrace) {
      if (error.response?.statusCode == 403) {
        productsResults = ProductsResults([], error: ErrorResultException(ErrorResult.notLogged));
      } else {
        productsResults = ProductsResults([], error: handleError(error, stackTrace));
      }
    }catch (error, stackTrace) {
      productsResults = ProductsResults([], error: handleError(error, stackTrace));
    }
    notifyListeners();
  }

  void _filterProducts() {
    productsResults ??= ProductsResults(
      _products
          .where((element) => _donateMode == DonateMode.oneTime ? !element.isRecurrent : element.isRecurrent)
          .toList(growable: false)
        ..sort((p1, p2) {
          return p1.price.compareTo(p2.price);
        }),
    );
  }
}
