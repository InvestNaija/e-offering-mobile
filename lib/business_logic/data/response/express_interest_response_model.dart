import 'package:invest_naija/business_logic/data/response/reservation_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/data/response/shares_response_model.dart';

class ExpressInterestResponseModel extends ResponseModel{

  ExpressInterestData data;

  ExpressInterestResponseModel();

  ExpressInterestResponseModel.fromJson(Map<String, dynamic> json) :
        data = ExpressInterestData.fromJson(json['data']),
        super.fromJson(json);
}

class ExpressInterestData{

  SharesResponseModel asset;
  ReservationResponseModel reservation;

  ExpressInterestData.fromJson(Map<String, dynamic> json) :
      asset = json["asset"] == null ?  null : SharesResponseModel.fromJson(json["asset"]),
      reservation = json["reservation"] == null ? null : ReservationResponseModel.fromJson(json["reservation"]);
}