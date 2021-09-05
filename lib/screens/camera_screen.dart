import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:invest_naija/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'media_preview_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraScreen> {
  CameraController controller;
  List<CameraDescription> cameras;
  int selectedCameraIndex = 0;
  bool isPicture = true;
  File _image;
  //final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void initializeCamera() async {
    cameras = await availableCameras();
    _initCameraController(cameras[selectedCameraIndex]);
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    // if (controller != null) {
    //   await controller.dispose();
    // }

    controller = CameraController(cameraDescription, ResolutionPreset.high);
    if (mounted) {
      setState(() {});
    }

    if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
    }
    try {
      await controller.initialize();
    } on CameraException catch (e) {}

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Container();
    }
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Stack(
      children: [
        CameraPreview(controller),
        Positioned(
          bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

          children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 85,
                      height: 85,
                      child: FlatButton(
                        color: Constants.whiteColor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(100.0)),
                        onPressed: () async{
                          AudioCache().play("audio/camera-shutter.mp3");
                          try {
                            final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png',);
                            XFile image = await controller.takePicture();
                            Navigator.push(context, MaterialPageRoute(
                               builder: (context) => MediaPreviewScreen(image: image),),
                            );
                          } catch (e) {}
                        },
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Constants.neutralColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
            FlatButton(
                color: Colors.transparent,
                onPressed: (){},
                child: Column(
                  children: [
                    Icon(Icons.keyboard_arrow_up, color: Constants.neutralColor,),
                    Text("Gallery", style: TextStyle(color: Constants.whiteColor),)
                  ],
                )
            )
          ],
        ),
              ),
            ))
      ],
    );
  }

  Widget cameraUtilityIcon({String name, Function onTap}){
    return GestureDetector(
      onTap: () { onTap();},
      child: Container(
        constraints: BoxConstraints(minHeight: 35, maxHeight: 35, maxWidth: 35, minWidth: 35),
        decoration: BoxDecoration(
          color: Constants.blackColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(name),
        ),
      ),
    );
  }
}
