import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/providers/register_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/otp/otp_field.dart';
import 'package:invest_naija/components/otp/otp_field_style.dart';
import 'package:invest_naija/components/otp/style.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/login_screen.dart';
import 'package:invest_naija/screens/successful_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String phoneNumber;

  const OtpScreen({Key key, this.email, this.phoneNumber}) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with DialogMixins{

  String pin = '';

  RegisterProvider registerProvider;

  @override
  void initState() {
    registerProvider = Provider.of<RegisterProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31, vertical: 32),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              CustomLeadIcon(),
              const SizedBox(height: 32,),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text("Enter Security Code",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Constants.blackColor)),
              ),
              const SizedBox(height: 13,),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                      text: 'We’ve sent a 6 - Digit code to your email address ',
                      style: const TextStyle(
                          height: 1.5,
                          color: Constants.neutralColor,
                          fontSize: 12),
                    ),
                    const TextSpan(
                      text: ' at ',
                      style: const TextStyle(
                          height: 1.5,
                          color: Constants.neutralColor,
                          fontSize: 12),
                    ),
                    TextSpan(
                      text: widget.email,
                      style: const TextStyle(
                          height: 1.5,
                          color: Constants.primaryColor,
                          fontSize: 12),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 42,),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceBetween,
                fieldWidth: 46,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 8,
                style: TextStyle(fontSize: 17),
                otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Constants.bleachSilkColor,
                    focusBorderColor: Constants.primaryColor
                ),
                onChanged: (pin) {},
                onCompleted: (pin){
                  this.pin = pin;
                },
              ),
              const SizedBox(height: 32,),
              Consumer<RegisterProvider>(
                builder: (context, registerProvider, child) {
                  return  CustomButton(
                    data: "Validate OTP",
                    isLoading: registerProvider.isLoading || registerProvider.resendingOtp,
                    textColor: Constants.whiteColor,
                    color: Constants.primaryColor,
                    onPressed: () async{
                      if(this.pin.isEmpty){
                        final snackBar = SnackBar(content: Text('Please enter your otp to continue'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      ResponseModel responseModel = await registerProvider.confirmOtp(otp: pin, email: widget.email,);
                      if(responseModel.code == 201 || responseModel.code == 200){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SuccessfulScreen(
                                header : 'Congratulations',
                                body : 'You have successfully setup your account with us.',
                                buttonText : 'Go to login page',
                                onButtonClicked : (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => LoginScreen())
                                  );
                                }
                            )));
                      }else{
                        showSimpleModalDialog(context: context, title: 'Otp error', message: responseModel?.error?.message ?? 'An error has occurred');
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 30,),
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () async{
                    ResponseModel responseModel = await registerProvider.resendOtp(email: widget.email);
                    showSimpleModalDialog(
                        context: context,
                        title: responseModel.error == null ? 'Success' : 'Error',
                        message: responseModel.message
                    );
                  },
                  child: const Text("Click to resend token",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Constants.greenColor)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
