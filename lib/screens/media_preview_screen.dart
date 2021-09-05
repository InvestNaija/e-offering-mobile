import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:invest_naija/business_logic/providers/customer_provider.dart';
import 'package:invest_naija/constants.dart';
import 'package:invest_naija/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

class MediaPreviewScreen extends StatefulWidget {
  final XFile image;

  MediaPreviewScreen({this.image});

  @override
  _MediaPreviewScreenState createState() => _MediaPreviewScreenState();
}

class _MediaPreviewScreenState extends State<MediaPreviewScreen> {

  CustomerProvider _customerProvider;

  @override
  void initState() {
    super.initState();
    _customerProvider = Provider.of<CustomerProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          Image.file(
            File(widget.image.path),
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            bottom: 40,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CameraActionButton(
                  icon: Icons.check,
                  onTap: () async{
                    String base64 = await _customerProvider.getBase64FromFile(widget.image);
                    await _customerProvider.updateProfileImage(imageBase64: base64);
                    await _customerProvider.getCustomerDetails();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DashboardScreen()), (route) => false);
                  },
                ),
                const SizedBox(width: 30,),
                CameraActionButton(
                  icon: Icons.close,
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class CameraActionButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  const CameraActionButton({Key key, this.icon, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Constants.whiteColor, width: 2),
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: 25,
        icon: Icon(icon, color: Constants.whiteColor,),
        onPressed: () {
          this.onTap();
        },
      ),
    );
  }
}
