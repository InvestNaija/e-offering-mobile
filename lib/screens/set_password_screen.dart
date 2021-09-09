import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/request/register_request_model.dart';
import 'package:invest_naija/business_logic/data/response/register_response_model.dart';
import 'package:invest_naija/business_logic/providers/register_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_checkbox.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_password_field.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/login_screen.dart';
import 'package:invest_naija/screens/otp_screen.dart';
import 'package:invest_naija/utils/formatter_util.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SetPasswordScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String middleName;
  final String dob;
  final String email;
  final String address;
  final String phone;
  final String nin;
  final String gender;
  final String bvn;

  const SetPasswordScreen({
    Key key,
    this.firstName,
    this.lastName,
    this.dob,
    this.email,
    this.address,
    this.phone,
    this.middleName,
    this.nin,
    this.gender,
    this.bvn = ''
  }) : super(key: key);



  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> with DialogMixins{

  TextEditingController phoneTextEditController;
  TextEditingController emailTextEditController;
  TextEditingController bvnTextEditController;
  TextEditingController addressTextEditController;
  TextEditingController passwordTextEditController;
  TextEditingController confirmPasswordTextEditController;
  TextEditingController placeOfBirthTextEditController;
  TextEditingController motherMaidenTextEditController;
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  bool hasAcceptedTermsAndConditions = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addressTextEditController = TextEditingController(text: widget.address ?? '');
    passwordTextEditController = TextEditingController(text: "");
    bvnTextEditController = TextEditingController(text: widget.bvn);
    phoneTextEditController = TextEditingController(text: widget.phone);
    emailTextEditController = TextEditingController(text: widget.email);
    placeOfBirthTextEditController = TextEditingController();
    motherMaidenTextEditController = TextEditingController();
    confirmPasswordTextEditController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Transform.translate(
            offset: Offset(25, 0),
        child: CustomLeadIcon()),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31, vertical: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Almost Done!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Constants.blackColor)),
              ),
              const SizedBox(height: 13,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "To continue, we will need you to confirm your personal details,\nand enter your password.",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Constants.neutralColor)),
              ),
              const SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                children: [
                  CustomTextField(
                    readOnly: true,
                    controller: TextEditingController(text: "${FormatterUtil.formatName('${widget.firstName} ${widget.lastName}')}"),
                  ),
                  const SizedBox(height: 25,),
                  CustomTextField(
                    readOnly: true,
                    controller: TextEditingController(text: widget.dob),
                    suffixIcon: "assets/images/calendar.png",
                  ),
                  const SizedBox(height: 25,),
                  CustomTextField(
                    label: "Phone number",
                    readOnly: widget.phone != null ? widget.phone.isNotEmpty ? true  : false : false,
                    controller: phoneTextEditController,
                  ),
                  const SizedBox(height: 25,),
                  CustomTextField(
                    label: "Email",
                    readOnly: widget.email != null ? widget.email.isNotEmpty ? true  : false : false,
                    controller: emailTextEditController,
                    keyboardType : TextInputType.emailAddress
                  ),
                  const SizedBox(height: 25,),
                  CustomTextField(
                    readOnly: widget.bvn.isNotEmpty,
                    label: "BVN",
                    controller: bvnTextEditController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 25,),
                  CustomTextField(
                    label: "Mother Maiden Name",
                    controller: motherMaidenTextEditController,
                  ),
                  const SizedBox(height: 25,),
                  CustomTextField(
                    label: "Place of Birth",
                    controller: placeOfBirthTextEditController,
                  ),
                  const SizedBox(height: 25,),
                  CustomTextField(
                    label: "Address",
                    controller: addressTextEditController,
                  ),
                  const SizedBox(height: 25,),
                  CustomPasswordField(
                    label: "Your Password",
                    suffixIcon: "assets/images/show-password.png",
                    controller: passwordTextEditController,
                    focusNode: passwordFocusNode,
                    onChange: (value){
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 25,),
                  CustomPasswordField(
                    label: "Confirm Password",
                    suffixIcon: "assets/images/show-password.png",
                    controller: confirmPasswordTextEditController,
                    matcher: passwordTextEditController.text,
                    focusNode: confirmPasswordFocusNode,
                  ),
                ],
              )),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCheckbox(
                    onTap: (value){
                      setState(() => hasAcceptedTermsAndConditions = value);
                    },
                    hasAcceptedTermsAndConditions: hasAcceptedTermsAndConditions,
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text:
                              'I have read and accept the purchase conditions, and understand the ',
                          style: const TextStyle(
                              color: Constants.neutralColor, fontSize: 12),
                        ),
                        TextSpan(
                            text: 'Terms and Conditions',
                            style: const TextStyle(
                                color: Constants.primaryColor, fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // navigate to desired screen
                              })
                      ]),
                    ),
                  ),
                  const SizedBox(width: 5,),
                ],
              ),
              const SizedBox(height: 32,),
              Consumer<RegisterProvider>(
                builder: (context, registerProvider, child) {
                  return  CustomButton(
                    data: "Create account",
                    isLoading: registerProvider.isLoading,
                    textColor: Constants.whiteColor,
                    color: Constants.primaryColor,
                    onPressed: () async {
                      if(!_formKey.currentState.validate()) return;
                      if(!hasAcceptedTermsAndConditions) return;

                      RegisterRequestModel registerRequestModel = RegisterRequestModel(
                          loading : true,
                          firstName : widget.firstName,
                          lastName : widget.lastName,
                          middleName : widget.middleName,
                          dob : FormatterUtil.formatDate(widget.dob),
                          gender : widget.gender,
                          phone : phoneTextEditController.text,
                          address : addressTextEditController.text,
                          email : emailTextEditController.text,
                          nin : widget.nin,
                          mothersMaidenName : motherMaidenTextEditController.text,
                          password : passwordTextEditController.text,
                          bvn : bvnTextEditController.text,
                          placeOfBirth : placeOfBirthTextEditController.text
                      );

                      RegisterResponseModel registerResponseModel = await Provider.of<RegisterProvider>(context, listen: false).registerUser(registerRequestModel);
                      if(registerResponseModel.error == null ){
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => OtpScreen(
                               email: registerResponseModel.data.email,
                               phoneNumber: registerResponseModel.data.phone,
                             )));
                      }else{
                        showSimpleModalDialog(context: context, title: 'Registration error', message: registerResponseModel.error.message);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 27,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
