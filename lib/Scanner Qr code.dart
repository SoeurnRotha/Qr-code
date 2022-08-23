import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learncode_qr_code/PageWeb.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  @override
  void dispose() {
    controller?.dispose();
    // TODO: implement dispose
    super.dispose();

  }
  @override
  void reassemble()async {
    // TODO: implement reassemble
    super.reassemble();
    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody,
    );
  }
  get _buildBody{
    return Stack(
      children: [
        _buildViewCode,
        Positioned(bottom: 10,left: 68,child: _buildResult),
        Positioned(top: 10,child: _buildBottomController)

      ],
    );
  }
  get _buildViewCode{
    return QRView(
        key: qrkey  ,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 20,
        borderWidth: 10,
        borderLength: 20,
        cutOutSize: MediaQuery.of(context).size.width * 0.8
      ),
    );
  }
  void onQRViewCreated(QRViewController controller){
    setState(() => this.controller = controller);
    controller.scannedDataStream
      .listen((barcode) => setState(() => this.barcode = barcode) );
  }
  get _buildResult {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
          ),
            child: InkWell(
                child: Text(barcode!=null ? "Result: ${barcode!.code}" : "Scan a Code ",maxLines: 3,style: TextStyle(fontSize: 18),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>code()));
              },
            )
        ,
      ),
    );
  }
  Future openUrl({required String url, bool inApp = false}) async{
    if(await canLaunch(url)){
      await launch(
          url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true

      );
    }else{
      throw("Error");
    }
  }
  get _buildBottomController{
    return Container(
      margin: EdgeInsets.only(left: 128),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: FutureBuilder<bool?>(
            future: controller?.getFlashStatus(),
            builder: (context,snapshot){
              if(snapshot.data != null){
                return Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off_sharp);
              }else{
                return Container();
              }
            }),

            onPressed: () async{
              await controller?.toggleFlash();
              setState((){

              });
            },
          ),
          IconButton(
            icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context,snapshot){
                  if(snapshot.data != null){
                    return Icon(Icons.camera_alt_outlined);
                  }else{
                    return Container();
                  }
                }),
            onPressed: () async{
              await controller?.flipCamera();
              setState((){

              });
            },
          ),

        ],
      ),
    );
  }
}
