import 'package:flutter/cupertino.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:provider/provider.dart';

class ApplicationMixin{
  void changePage(BuildContext context, int index, {bool shouldPop = true}){
    Provider.of<CustomerProvider>(context, listen: false).changePage(index);
    if(shouldPop){
      Navigator.pop(context);
    }
  }
}