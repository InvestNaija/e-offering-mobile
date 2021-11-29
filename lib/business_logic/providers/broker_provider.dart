import 'package:flutter/foundation.dart';
import 'package:invest_naija/business_logic/data/response/broker_response_model.dart';
import 'package:invest_naija/business_logic/repository/broker_repository.dart';

class BrokerProvider extends ChangeNotifier{

  List<BrokerResponseModel> brokers = [];
  BrokerResponseModel selectedBroker;

  void getBrokers() async{
   var response =  await BrokersRepository().getBrokers();
   if(response.status == 'success'){
     brokers = response.data;
   }

   notifyListeners();
   print(brokers);
  }

  void brokerSelected(value){
    selectedBroker = brokers.firstWhere((element) => element.name == value);
    notifyListeners();
  }

  void setFirst() {
    if(selectedBroker == null){
      selectedBroker = brokers[0];
    }
    notifyListeners();
  }
}