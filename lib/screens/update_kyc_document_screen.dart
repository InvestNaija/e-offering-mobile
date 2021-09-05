import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/document_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/components/dropdown_below.dart';
import 'package:invest_naija/constants.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:provider/provider.dart';

import 'fragments/documents_upload/proof_of_address_screen.dart';
import 'fragments/documents_upload/proof_of_id_screen.dart';
import 'fragments/documents_upload/signature_screen.dart';

class UpdateKycDocumentScreen extends StatefulWidget {
  @override
  _UpdateKycDocumentScreenState createState() =>
      _UpdateKycDocumentScreenState();
}

class _UpdateKycDocumentScreenState extends State<UpdateKycDocumentScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<DocumentProvider>(context, listen: false).getSavedDocuments();
  }

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 60),
            child: Transform.translate(
              offset: Offset(0, 20),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                leading: Transform.translate(
                  offset: Offset(22, 0),
                  child: CustomLeadIcon(),
                ),
                title: const Text("Document & KYC",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Constants.fontColor2)),
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 22, right: 22, top: 50),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    onTap: (index) {},
                    tabs: [
                      Tab(text: 'Proof of Address',),
                      Tab(text: 'Proof of Id',),
                      Tab(text: 'Signature',),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        ProofOfAddressScreen(),
                        ProofOfIdScreen(),
                        SignatureScreen(),
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: false,
                    child: Align(
                      alignment: Alignment.center,
                      child: const Text("Back to Settings",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Constants.greenColor)),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _imageUploaded({String documentType, String imageUrl}) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.03),
            spreadRadius: 2,
            blurRadius: 17,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        shadowColor: Constants.cardShadowColor,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
          child: Row(
            children: [
              Image.network(imageUrl.isEmpty ? 'https://i.ibb.co/w7kRwHV/kyc-doc.png' : imageUrl, width: 71, height: 44,),
              const SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(documentType,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Constants.blackColor)),
                  const SizedBox(height: 3,),
                  const Text("Upload completed",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Constants.successColor))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePreview(File imageFile, {Function onCloseTapped}) {
    return Stack(
      children: [
        Container(
          child: Align(
              alignment: Alignment.center,
              child: Image.file(
                imageFile,
                height: 200,
              )),
        ),
        Positioned(
            top: 5,
            right: -15,
            child: MaterialButton(
              onPressed: () => onCloseTapped(),
              color: Constants.primaryColor,
              textColor: Colors.white,
              child: Icon(
                Icons.close,
                size: 18,
              ),
              padding: EdgeInsets.all(5),
              shape: CircleBorder(),
            )),
      ],
    );
  }
}
