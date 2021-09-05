import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/document_provider.dart';
import 'package:invest_naija/business_logic/providers/proof_of_address_document_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/components/dropdown_below.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class ProofOfAddressScreen extends StatefulWidget {
  const ProofOfAddressScreen({Key key}) : super(key: key);

  @override
  _ProofOfAddressScreenState createState() => _ProofOfAddressScreenState();
}

class _ProofOfAddressScreenState extends State<ProofOfAddressScreen> with DialogMixins{

  String selectedFilePath;
  TextEditingController _identificationNumberTEC = TextEditingController();
  List _proofOfAddressList = [
    {'no': 1, 'keyword': 'National Identification Card'},
    {'no': 2, 'keyword': 'International Passport'},
    {'no': 3, 'keyword': 'Driver Licence'},
    {'no': 4, 'keyword': 'Utility Bill'}
  ];
  List<DropdownMenuItem> _dropdownTestItems;

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(_proofOfAddressList);
    super.initState();
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

  var _selectedDocument;
  onChangeDropdownTests(selectedTest) {
    setState(() {
      _selectedDocument = selectedTest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 15,),
          const Text(
              "Please select and upload a valid means of Identification and your utility bill to help us identify you.",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Constants.blackColor)),
          const SizedBox(height: 10,),
          const Text("Note: App supports png or jpeg format.",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Constants.errorAlertColor)),
          const SizedBox(height: 40,),
          DropdownBelow(
            itemWidth: MediaQuery.of(context).size.width - 44,
            itemTextstyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Constants.walrusColor),
            boxTextstyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Constants.walrusColor),
            boxPadding: const EdgeInsets.fromLTRB(13, 12, 0, 12),
            boxHeight: 50,
            boxColor: Constants.dropdownBackgroundColor,
            boxWidth: MediaQuery.of(context).size.width,
            hint: const Text('Select a document type'),
            value: _selectedDocument,
            items: _dropdownTestItems,
            onChanged:onChangeDropdownTests,
          ),
          const SizedBox(height: 40,),
          Consumer<ProofOfAddressDocumentProvider>(
            builder: (context, provider, child) {
              return InkWell(
                  onTap: () async {
                    XFile pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1024.0,
                      maxHeight: 1024.0,
                      imageQuality: 50,
                    );
                    if (pickedFile == null) return;
                    provider.onImageSelected(pickedFile.path);
                  },
                  child: IndexedStack(
                    index: provider.selectedFilePath.isEmpty ? 0 : 1,
                    children: [
                      Align(
                        child: SvgPicture.asset(
                          'assets/images/upload-document.svg',
                        ),
                      ),
                      _imagePreview(File(provider.selectedFilePath),
                          onCloseTapped: () {
                            provider.removeImage();
                          })
                    ],
                  ));
            },
          ),
          const SizedBox(height: 20,),
          Offstage(
            offstage: _selectedDocument != null && _selectedDocument['keyword'] == 'Utility Bill',
            child: CustomTextField(
              label: "Enter Identification Number",
              keyboardType: TextInputType.number,
              controller: _identificationNumberTEC,
            ),
          ),
          const SizedBox(height: 25,),
          Consumer<DocumentProvider>(
            builder: (context, documentProvider, widget) {
              return Container(
                child: AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: documentProvider.profOfAddressImage.isEmpty? Offstage( offstage: true,) :
                  _imageUploaded(
                      documentType: documentProvider.profOfAddressDocumentType,
                      imageUrl: documentProvider.profOfAddressImage
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 70,),
          Consumer<ProofOfAddressDocumentProvider>(
              builder: (context, documentProvider, widget) {
                return CustomButton(
                  data: "Save Document",
                  isLoading: documentProvider.isUploadingProofOfAddress,
                  color: Constants.primaryColor,
                  textColor: Constants.whiteColor,
                  onPressed: documentProvider.isUploadingProofOfAddress
                      ? null
                      : () async {
                    ResponseModel response = await documentProvider.uploadProofOfAddress(
                        documentProvider.selectedFilePath,
                        _selectedDocument['keyword'],
                        _identificationNumberTEC.text);
                    showSimpleModalDialog(context: context, title: 'Image upload info', message: response.message ?? response.error.message);
                    await Provider.of<DocumentProvider>(context, listen: false).refreshImages();
                  },
                );
              }),
          const SizedBox(height: 20,),
        ],
      ),
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
