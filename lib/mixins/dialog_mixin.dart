import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_icon_button.dart';
import 'package:invest_naija/screens/create_cscs_account_screen.dart';
import 'package:invest_naija/screens/enter_cscs_number.dart';

import '../constants.dart';

class DialogMixins{


  Future<dynamic> showUploadProfileImage(BuildContext context, {Function onCameraTapped, Function onGalleryTapped}){
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.only(left: 22, right: 22, top: 30, bottom: 10),
          height: 200,
          decoration: BoxDecoration(
            color: Constants.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const Text("Profile upload",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Constants.fontColor2)),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    icon: Icons.camera_alt,
                    onTap: (){
                      onCameraTapped();
                    },
                  ),
                  const SizedBox(width: 25,),
                  CustomIconButton(
                    icon: Icons.folder,
                    onTap: (){
                      onGalleryTapped();
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Future<void> selectDate({BuildContext context, Function onSelected}) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        lastDate: DateTime.now(), firstDate: DateTime(1970),
        builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Constants.primaryColor,
            ),
          ),
          child: child,
        );
      },
    );
    onSelected(pickedDate);
  }

  showSimpleModalDialog({BuildContext context, String title, String message, Function onClose}){
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Info', style: TextStyle(fontWeight: FontWeight.w700),),
          content: SingleChildScrollView(
            child: Text(message ?? 'Oops, and error occurred!!'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay', style: TextStyle(color: Constants.blackColor),),
              onPressed: () {
                Navigator.of(context).pop();
                if(onClose != null){onClose();}
              },
            ),
          ],
        );
      },
    );
  }

  showCssBottomSheet(BuildContext context,){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context){
      return Container(
        decoration: BoxDecoration(
          color: Constants.dashboardBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: SizedBox(
            height: 250,
            child: Column(
              children: [
                const Text("CSCS Details", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                const SizedBox(height: 14,),
                const Text("To express interest in this shares, you must have a CSCS Number. Do you have one?", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
                const SizedBox(height: 30,),
                CustomButton(
                    data: "Yes, I Do",
                    textColor: Constants.whiteColor,
                    color: Constants.primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EnterCscsNumber()));
                    }),
                CustomButton(
                    data: "No, I don’t",
                    textColor: Constants.blackColor,
                    color: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                      showCssAccountCreationBottomSheet(context);
                    })
              ],
            ),
          ),
        ),
      );
    });
  }

  showCssAccountCreationBottomSheet(BuildContext context,){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context){
          return Container(
            decoration: BoxDecoration(
              color: Constants.dashboardBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: SizedBox(
                height: 250,
                child: Column(
                  children: [
                    const Text("CSCS Account Creation", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                    const SizedBox(height: 14,),
                    const Text("Your CSCS Number is mandatory to complete this transaction. Would you like one created for you?", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
                    const SizedBox(height: 30,),
                    CustomButton(
                        data: "Yes, I Do",
                        textColor: Constants.whiteColor,
                        color: Constants.primaryColor,
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CreateCscsAccountScreen()));
                        }),
                    CustomButton(
                        data: "No, I don’t",
                        textColor: Constants.blackColor,
                        color: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).pop();
                          showCssAccountDeclinedBottomSheet(context);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  showCssAccountDeclinedBottomSheet(BuildContext context,){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context){
          return Container(
            decoration: BoxDecoration(
              color: Constants.dashboardBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: SizedBox(
                height: 250,
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/css-declined.svg', width: 70, height: 70,),
                    const SizedBox(height: 12,),
                    const Text("CSCS Account Declined", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Constants.blackColor),),
                    const SizedBox(height: 14,),
                    const Text("We’re sorry, you can’t complete this transaction without a CSCS Number", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Constants.neutralColor),),
                    const SizedBox(height: 30,),
                    CustomButton(
                        data: "Back to Shares",
                        textColor: Constants.whiteColor,
                        color: Constants.primaryColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showWhyWeNeedYourNinModalDialog({BuildContext context}){
    List<String> menuItems = ["Full name", "Phone Number", "Date of Birth"];
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.only(left: 22, right: 22, top: 30, bottom: 10),
          height: 320,
          decoration: BoxDecoration(
            color: Constants.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Why do we need your NIN?",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constants.blackColor)),
              const SizedBox(height: 10,),
              const Text(
                  "We only need to access some of your information:",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Constants.fontColor2)),
              const SizedBox(height: 15,),
              Container(
                child: Column(
                  children: menuItems.map((item) => SizedBox(
                    height: 25,
                    child: Row(children: [
                      Container(
                        color: Constants.greenColor,
                        width: 5,
                        height: 5,
                      ),
                      SizedBox(width: 10,),
                      Text(item,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Constants.fontColor2))
                    ],),
                  )).toList(),
                ),
              ),
              const SizedBox(height: 15,),
              const Text(
                  "Your NIN does not give us access to your bank account or transactions",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Constants.fontColor2)),
              const SizedBox(height: 20,),
              CustomButton(
                data: "I understand",
                color: Constants.whiteColor,
                icon: "assets/images/upload-icon.svg",
                textColor: Constants.primaryColor,
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ));
  }

  showWhyWeNeedYourBvnModalDialog({BuildContext context}){
    List<String> menuItems = ["Full name", "Phone Number", "Date of Birth"];
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.only(left: 22, right: 22, top: 30, bottom: 10),
          height: 320,
          decoration: BoxDecoration(
            color: Constants.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Why do we need your BVN?",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Constants.blackColor)),
              const SizedBox(height: 10,),
              const Text(
                  "We only need to access some of your information:",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Constants.fontColor2)),
              const SizedBox(height: 15,),
              Container(
                child: Column(
                  children: menuItems.map((item) => SizedBox(
                    height: 25,
                    child: Row(children: [
                      Container(
                        color: Constants.greenColor,
                        width: 5,
                        height: 5,
                      ),
                      SizedBox(width: 10,),
                      Text(item,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Constants.fontColor2))
                    ],),
                  )).toList(),
                ),
              ),
              const SizedBox(height: 15,),
              const Text(
                  "Your BVN does not give us access to your bank account or transactions",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Constants.fontColor2)),
              const SizedBox(height: 20,),
              CustomButton(
                data: "I understand",
                color: Constants.whiteColor,
                icon: "assets/images/upload-icon.svg",
                textColor: Constants.primaryColor,
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ));
  }
}