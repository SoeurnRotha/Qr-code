import 'package:flutter/material.dart';
import 'package:learncode_qr_code/Create%20Code.dart';
import 'package:learncode_qr_code/Scanner%20Qr%20code.dart';

void main() => runApp(LearnCodeQrCode());
class LearnCodeQrCode extends StatefulWidget {
  const LearnCodeQrCode({Key? key}) : super(key: key);

  @override
  State<LearnCodeQrCode> createState() => _LearnCodeQrCodeState();
}

class _LearnCodeQrCodeState extends State<LearnCodeQrCode> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _buildAppbar,
          body: _buildBody,
        ),

      ),
    );
  }
  get _buildAppbar {
    return AppBar(
      title: Text("LearnCode Scanner Qr Code"),
      centerTitle: true,
      backgroundColor: Colors.purpleAccent,
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.document_scanner_rounded),),
          Tab(icon: Icon(Icons.edit),),
        ],
      ),
    );
  }
  get _buildBody {
    return TabBarView(
      children: [
        Scanner(),
        CreateCode(),
      ],

    );
  }
}
