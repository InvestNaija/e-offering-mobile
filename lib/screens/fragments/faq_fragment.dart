import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:invest_naija/constants.dart';

class FaqFragment extends StatefulWidget {
  @override
  _FaqFragmentState createState() => _FaqFragmentState();
}

class _FaqFragmentState extends State<FaqFragment> {

var faqs = [
  {'isExpanded' : false, 'question': 'How do I subscribe', 'answer': '<br>Follow the steps below to subscribe<ul><li>Select available asset.</li><li>View details of the transaction.</li><li>Input units to subscribe,CSCS and Bank details</li><li>Read and accept the terms and conditions of the application and prospectus</li><li>Proceed to pay</li><li>You will receive a notification of the transaction in your email</li></ul>'},
  {'isExpanded' : false, 'question': 'What is a CSCS No?', 'answer': 'The CSCS No. (Central Securities Clearing System) and CHN (Clearing House Number) are investors unique identifier to purchase and/or sell securities.'},
  {'isExpanded' : false, 'question': 'I already have a CSCS number, what do I do?', 'answer': 'If you have a CSCS number, simply input your number in the relevant field and follow the steps for verification.'},
  {'isExpanded' : false, 'question': 'I don’t have a CSCS, can I still apply?', 'answer': 'Yes, if you do not have a CSCS account, one will be created for you as part of the application process on the PrimaryOffer platform. You will be required to input necessary details for creation. You will get an email informing you that your CSCS will be created and made available to you as soon as possible, however you can proceed to pay for your shares.'},
  {'isExpanded' : false, 'question': 'How do I pay?', 'answer': '<br>Select one of the options available on the payment page<ul><li>Pay with card</li><li>Direct debit from your account</li><li>Pay via Electronic transfer</li><li>Pay with QR Code</li><li>Pay with USSD Code</li><li>Pay at the bank</li><li>Confirm the amount to be paid</li><li>Click on the Continue button</li></ul>(Once you select an option to make payment, you will find a summary with the details of your Transaction)'},
  {'isExpanded' : false, 'question': 'How will I know my transaction is successful?', 'answer': 'If you subscribe through PrimaryOffer application, you will receive a confirmation via email advising that your application has been successfully submitted. You will also be notified via the same platform of a copy of the application form and payment evidence.'},
  {'isExpanded' : false, 'question': 'What information should I keep after I submit the application?', 'answer': 'If you submit through PrimaryOffer, you will receive a confirmation via email advising that your application has been successfully submitted. You will also be notified via the same platform of a copy of the application form and payment evidence.'},
  {'isExpanded' : false, 'question': 'Can I submit multiple applications in the same name?', 'answer': 'No but you can buy more units during the offer period by following the same steps used for the initial purchase'},
  {'isExpanded' : false, 'question': 'Will there be any charges when purchasing the shares on PrimaryOffer?', 'answer': 'No, there are no charges for purchasing shares, however there will be transaction charges from the payment platform service provider/your bank.'},
  {'isExpanded' : false, 'question': 'Can I change my password, how do I go about it?', 'answer': 'Yes, kindly select the ‘’forgot password’’ option on the login page and follow the instructions for a password reset.'},
  {'isExpanded' : false, 'question': 'I tried to subscribe to the MTN share offer but I don’t have a CSCS account number', 'answer': 'Kindly follow the prompt on the application to create a CSCS account and your account details would be forwarded within 24 working hours.'},
  {'isExpanded' : false, 'question': 'The App keeps timing out', 'answer': 'The application automatically logs you out if idle for a period of time.'},
  {'isExpanded' : false, 'question': 'I get an error to contact my Bank when I tried to make payment with my Card', 'answer': 'Kindly contact your Bank for card enablement or make use of other available payment options.'},
  {'isExpanded' : false, 'question': 'I got a failed error response after funding but was debited', 'answer': 'Reversal of funds typically takes 24 working hours. However, you may need to contact your Bank for further assistance.'},
  {'isExpanded' : false, 'question': 'I have paid and received proof of payment; what next?', 'answer': 'You will be contacted with the details of your allotment after the process is over'},
  {'isExpanded' : false, 'question': 'I have been debited but my payment status shows pending', 'answer': 'Confirmation takes 24-48 working hours. However, you can forward proof of payment to info@primaryofferng.com.'},
  {'isExpanded' : false, 'question': 'I am unable to change password/login', 'answer': 'The password field is case and space sensitive, ensure you input your details correctly and if it persists, please log out and log in again.'},
  {'isExpanded' : false, 'question': 'I am unable to relaunch the app after updating the app.', 'answer': 'Kindly switch off your phone, restart it and try again'},
  {'isExpanded' : false, 'question': 'I received an error response "Page could not be found" while making payment with the USSD option', 'answer': 'Kindly refresh page to confirm if payment was successful. However, you can subscribe via other payment options.'},
  {'isExpanded' : false, 'question': 'How do I contact your customer care?', 'answer': '<div class="text-danger"><b>Telephone</b> - 0700 46837862452<br><b>Email</b> – info@primaryofferng.com</div>'},
];



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "FAQs",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Constants.fontColor2,
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 30,),
          Expanded(
            child: ListView(
              children: [
                ExpansionPanelList(
                  animationDuration: Duration(milliseconds: 500),
                  dividerColor: Colors.white,
                  elevation: 0,
                  children: List.generate(faqs.length, (index) => ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          faqs[index]['question'],
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Answer:'),
                          Html(
                            data: """${faqs[index]['answer']}""",
                          ),
                        ],
                      ),
                    ),
                    isExpanded: faqs[index]['isExpanded'],
                  ),),
                  expansionCallback: (int item, bool status) {
                    print(item);
                    print(status);
                    setState(() {
                      faqs[item]['isExpanded'] = !status;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
