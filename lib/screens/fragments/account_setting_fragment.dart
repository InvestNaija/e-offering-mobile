import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/business_logic/providers/login_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/camera_screen.dart';
import 'package:invest_naija/screens/change_password_screen.dart';
import 'package:invest_naija/screens/login_screen.dart';
import 'package:invest_naija/screens/update_kyc_document_screen.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../enter_bank_information_screen.dart';


class AccountSettingFragment extends StatefulWidget {
  @override
  _AccountSettingFragmentState createState() => _AccountSettingFragmentState();
}

class _AccountSettingFragmentState extends State<AccountSettingFragment> with DialogMixins {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      color: Constants.whiteColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<CustomerProvider>(
              builder: (context, customerProvider, widget){
            return GestureDetector(
              onTap: (){
                showUploadProfileImage(
                    context,
                    onCameraTapped : (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraScreen()));
                    },
                    onGalleryTapped: () async{
                      PickedFile pickedFile = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                        maxWidth: 1024.0,
                        maxHeight: 1024.0,
                        imageQuality: 50,
                      );
                      Navigator.pop(context);
                      if(pickedFile == null) return;
                      String base64 = await customerProvider.getBase64FromPickedFile(pickedFile);
                      await customerProvider.updateProfileImage(imageBase64: base64);
                      await customerProvider.getCustomerDetails();
                    }
                );
              },
              child: CircleAvatar(
                radius: 27,
                backgroundImage:
                NetworkImage(customerProvider.user.image == null || customerProvider.user.image == "" ? "https://i.ibb.co/9hgQFDx/user.png" : customerProvider.user.image),
              ),
            );
          }),
          const SizedBox(height: 18,),
          Consumer<CustomerProvider>(builder: (context, customerProvider, widget){
            return Text(
              '${FormatterUtil.formatName('${customerProvider.user.firstName} ${customerProvider.user.lastName}')}',
              style: const TextStyle(
                  color: Constants.fontColor2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            );
          }),
          const SizedBox(height: 40,),
          _optionRow("assets/images/share.svg", "Change Password", () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChangePasswordScreen()));
          }),
          const SizedBox(height: 10,),
          _optionRow("assets/images/document-black.svg", "Document & KYC", () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UpdateKycDocumentScreen()));
          }),
          const SizedBox(height: 10,),
          _optionRow("assets/images/bank-card.svg", "Bank Details", () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EnterBankInformationScreen()));
          }),
          const SizedBox(height: 10,),
          _optionRow("assets/images/logout-red.svg", "Logout", () async{
               bool hasClearedCache = await Provider.of<LoginProvider>(context, listen: false).logout();
               if(hasClearedCache){
                 Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) => LoginScreen()));
               }
          }),
        ],
      ),
    );
  }

  Widget _optionRow(String svgUrl, String text, Function onTap) {
    return Material(
      color: Colors.white.withOpacity(0.8),
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              SvgPicture.asset(svgUrl),
              const SizedBox(width: 17,),
              Text(text,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Constants.blackColor)),
              Spacer(),
             // SvgPicture.asset(Strings.arrowForwardSvgImage),
            ],
          ),
        ),
      ),
    );
  }
  Future<dynamic> showUploadBottomSheet(){
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 30),
          height: 250,
          decoration: BoxDecoration(
            color: Constants.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const Text("Document & KYC",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Constants.fontColor2)),
              const SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17),
                child: const Text(
                    "Choosing your preferred document helps us prove your identity. The information should be the same as that in your Bank Verification Details",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Constants.fontColor2)),
              ),
              const SizedBox(height: 30,),
              CustomButton(
                data: "Upload Document",
                color: Constants.primaryColor,
                icon: "assets/images/upload-icon.svg",
                textColor: Constants.whiteColor,
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ChangeKycDocument()));
                },
              ),
            ],
          ),
        ));
  }
}
