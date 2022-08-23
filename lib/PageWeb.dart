import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
class code extends StatefulWidget {
  const code({Key? key}) : super(key: key);

  @override
  State<code> createState() => _codeState();
}

class _codeState extends State<code> {
  Barcode?barcode;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ElevatedButton(
        child: Text("${barcode!.code}"),
        onPressed: (){
          final url = "${barcode!.code}";
          openUrl(url: url, inApp: true);
        },
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
}
