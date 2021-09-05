import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/data/response/payment_url_response.dart';
import 'package:invest_naija/business_logic/repository/payment_repository.dart';

class PaymentProvider extends ChangeNotifier{
  bool isFetchingPaymentLink = false;

  Future<PaymentUrlResponse> getPaymentUrl({String reservationId, String gateway}) async{
    isFetchingPaymentLink = true;
    notifyListeners();

    PaymentUrlResponse paymentUrlResponse = await PaymentRepository().getPaymentUrl(reservationId: reservationId, gateway: gateway);

    isFetchingPaymentLink = false;
    notifyListeners();

    return paymentUrlResponse;
  }
}