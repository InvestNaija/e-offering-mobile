import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/data/response/nin_response_model.dart';
import 'package:invest_naija/business_logic/data/response/response_model.dart';
import 'package:invest_naija/business_logic/providers/assets_provider.dart';
import 'package:invest_naija/business_logic/providers/broker_provider.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/components/custom_button.dart';
import 'package:invest_naija/components/custom_dropdown_textfield.dart';
import 'package:invest_naija/components/custom_lead_icon.dart';
import 'package:invest_naija/components/custom_textfield.dart';
import 'package:invest_naija/mixins/dialog_mixin.dart';
import 'package:invest_naija/screens/successful_screen.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CreateCscsAccountScreen extends StatefulWidget {
  final User user;
  const CreateCscsAccountScreen({Key key, this.user}) : super(key: key);
  @override
  _CreateCscsAccountScreenState createState() => _CreateCscsAccountScreenState();
}

class _CreateCscsAccountScreenState extends State<CreateCscsAccountScreen> with DialogMixins {
  TextEditingController fullNameTextEditController = TextEditingController(text: "");
  TextEditingController maidenNameTextEditController = TextEditingController(text: "");
  TextEditingController countryTextEditController = TextEditingController(text: "Nigeria");
  TextEditingController stateTextEditController = TextEditingController(text: "");
  TextEditingController cityTextEditController = TextEditingController(text: "");
  TextEditingController localGovernmentAreaTextEditController = TextEditingController(text: "");
  TextEditingController postalCodeTextEditController = TextEditingController(text: "");
  TextEditingController nationalityTextEditController = TextEditingController(text: "Nigerian");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var countries = ['Afghanistan', 'Albania', 'Algeria', 'Argentina', 'Australia', 'Austria', 'Bangladesh', 'Belgium', 'Bolivia', 'Botswana', 'Brazil', 'Bulgaria', 'Cambodia', 'Cameroon', 'Canada', 'Chile', 'China', 'Colombia', 'Costa Rica', 'Croatia', 'Cuba', 'Czech Republic', 'Denmark', 'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'England', 'Estonia', 'Ethiopia', 'Fiji', 'Finland', 'France', 'Germany', 'Ghana', 'Greece', 'Guatemala', 'Haiti', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy', 'Jamaica', 'Japan', 'Jordan', 'Kenya', 'Kuwait', 'Laos', 'Latvia', 'Lebanon', 'Libya', 'Lithuania', 'Madagascar', 'Malaysia', 'Mali', 'Malta', 'Mexico', 'Mongolia', 'Morocco', 'Mozambique', 'Namibia', 'Nepal', 'Netherlands', 'New Zealand', 'Nicaragua', 'Nigeria', 'Norway', 'Pakistan', 'Panama', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal', 'Romania', 'Russia', 'Saudi Arabia', 'Scotland', 'Senegal', 'Serbia', 'Singapore', 'Slovakia', 'South Africa', 'South Korea', 'Spain', 'Sri Lanka', 'Sudan', 'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 'Thailand', 'Tonga', 'Tunisia', 'Turkey', 'Ukraine', 'United Arab Emirates', '(The) United Kingdom', '(The) United States', 'Uruguay', 'Venezuela', 'Vietnam', 'Wales', 'Zambia', 'Zimbabwe'];
  var nationalities = ['Afghan', 'Albanian', 'Algerian', 'Argentine', 'Argentinian', 'Australian', 'Austrian', 'Bangladeshi', 'Belgian', 'Bolivian', 'Batswana', 'Brazilian', 'Bulgarian', 'Cambodian', 'Cameroonian', 'Canadian', 'Chilean', 'Chinese', 'Colombian', 'Costa Rican', 'Croatian', 'Cuban', 'Czech', 'Danish', 'Dominican', 'Ecuadorian', 'Egyptian', 'Salvadorian', 'English', 'Estonian', 'Ethiopian', 'Fijian', 'Finnish', 'French', 'German', 'Ghanaian', 'Greek', 'Guatemalan', 'Haitian', 'Honduran', 'Hungarian', 'Icelandic', 'Indian', 'Indonesian', 'Iranian', 'Iraqi', 'Irish', 'Israeli', 'Italian', 'Jamaican', 'Japanese', 'Jordanian', 'Kenyan', 'Kuwaiti', 'Lao', 'Latvian', 'Lebanese', 'Libyan', 'Lithuanian', 'Malagasy', 'Malaysian', 'Malian', 'Maltese', 'Mexican', 'Mongolian', 'Moroccan', 'Mozambican', 'Namibian', 'Nepalese', 'Dutch', 'New Zealand', 'Nicaraguan', 'Nigerian', 'Norwegian', 'Pakistani', 'Panamanian', 'Paraguayan', 'Peruvian', 'Philippine', 'Polish', 'Portuguese', 'Romanian', 'Russian', 'Saudi', 'Scottish', 'Senegalese', 'Serbian', 'Singaporean', 'Slovak', 'South African', 'Korean', 'Spanish', 'Sri Lankan', 'Sudanese', 'Swedish', 'Swiss', 'Syrian', 'Taiwanese', 'Tajikistani', 'Thai', 'Tongan', 'Tunisian', 'Turkish', 'Ukrainian', 'Emirati', 'British', 'American', 'Uruguayan', 'Venezuelan', 'Vietnamese', 'Welsh', 'Zambian', 'Zimbabwean'];
  bool brokerSelection = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onFinish());
  }

  Future<bool> onFinish({bool isRefresh = false}) async {
    Provider.of<BrokerProvider>(context, listen: false).getBrokers();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 31, vertical: 32),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                CustomLeadIcon(),
                const SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Create CSCS Account", textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Constants.blackColor)),
                ),
                const SizedBox(
                  height: 13,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Please complete the form below to create an account",
                      textAlign: TextAlign.left, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Constants.neutralColor)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Do you have a preferred broker",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Constants.blackColor,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No, choose for me",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Constants.neutralColor),
                    ),
                    Switch(
                      value: brokerSelection,
                      onChanged: (value) {
                        Provider.of<BrokerProvider>(context, listen: false).setFirst();
                        setState(() {
                          brokerSelection = value;
                        });
                      },
                    ),
                    Text(
                      "Yes, let me choose",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Constants.neutralColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<BrokerProvider>(
                  builder: (BuildContext context, provider, Widget child) {
                    return Offstage(
                      offstage: !brokerSelection,
                      child: CustomDropdownTextField(
                        label: "Brokers",
                        items: provider.brokers.map((e) => e.name).toSet().toList(),
                        value: provider.selectedBroker?.name,
                        onChanged: (value) {
                          Provider.of<BrokerProvider>(context, listen: false).brokerSelected(value);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Consumer<CustomerProvider>(
                  builder: (BuildContext context, customerProvider, Widget child) {
                    return CustomTextField(
                      label: "Your Full name",
                      readOnly: true,
                      controller: fullNameTextEditController..text = '${customerProvider.user.lastName} ${customerProvider.user.firstName} ${customerProvider.user.middleName}',
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Consumer<CustomerProvider>(
                  builder: (BuildContext context, customerProvider, Widget child) {
                    return CustomTextField(
                      label: "Maiden Name",
                      readOnly: true,
                      controller: maidenNameTextEditController..text = customerProvider.user.mothersMaidenName,
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomDropdownTextField(
                  label: "Country",
                  items: countries,
                  value: countries[0],
                  onChanged: (value) {
                    countryTextEditController..text = value;
                  },
                  controller: postalCodeTextEditController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomDropdownTextField(
                  label: "Nationality",
                  items: nationalities,
                  value: nationalities[0],
                  onChanged: (value) {
                    nationalityTextEditController..text = value;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  label: "State",
                  controller: stateTextEditController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  label: "City",
                  controller: cityTextEditController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  label: "Local Government Area",
                  controller: localGovernmentAreaTextEditController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  label: "Postal Code",
                  controller: postalCodeTextEditController,
                ),
                const SizedBox(
                  height: 32,
                ),
                Consumer<AssetsProvider>(
                  builder: (context, assetProvider, child) {
                    return CustomButton(
                      data: "Create Cscs account",
                      isLoading: assetProvider.isCreatingCscs,
                      textColor: Constants.whiteColor,
                      color: Constants.primaryColor,
                      onPressed: assetProvider.isCreatingCscs
                          ? null
                          : () async {
                              if (!formKey.currentState.validate()) return;

                              bool hasNuban = await Provider.of<CustomerProvider>(context, listen: false).hasNuban();
                              print(hasNuban);
                              if (!hasNuban) {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Update Bank Details'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('Input bank details to proceed'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text(
                                            'Update Bank Details',
                                            style: TextStyle(color: Constants.blackColor),
                                          ),
                                          onPressed: () {
                                            Navigator.popAndPushNamed(context, '/enter-bank-detail', arguments: true);
                                          },
                                        ),
                                        // TextButton(
                                        //   child: const Text('Cancel', style: TextStyle(color: Constants.blackColor)),
                                        //   onPressed: () {
                                        //     Navigator.of(context).pop();
                                        //   },
                                        // ),
                                      ],
                                    );
                                  },
                                );
                                return;
                              }

                              ResponseModel responseModel = await Provider.of<AssetsProvider>(context, listen: false).createCscsAccount(
                                citizen: nationalityTextEditController.text,
                                city: cityTextEditController.text,
                                country: countryTextEditController.text,
                                maidenName: maidenNameTextEditController.text,
                                state: stateTextEditController.text,
                                brokerName: !brokerSelection ? "CHDS" : Provider.of<BrokerProvider>(context, listen: false).selectedBroker.code,
                                selectBroker: brokerSelection,
                                lga: localGovernmentAreaTextEditController.text
                              );
                              if (responseModel.error == null) {
                                Provider.of<CustomerProvider>(context, listen: false).getCustomerDetailsSilently();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SuccessfulScreen(
                                        header: 'Congratulations',
                                        body: responseModel.message,
                                        buttonText: 'Go back',
                                        onButtonClicked: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        })));
                              } else {
                                showSimpleModalDialog(context: context, title: 'Registration error', message: responseModel.error.message);
                              }
                            },
                    );
                  },
                ),
                const SizedBox(
                  height: 27,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
