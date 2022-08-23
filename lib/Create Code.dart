import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class CreateCode extends StatefulWidget {
  const CreateCode({Key? key}) : super(key: key);

  @override
  State<CreateCode> createState() => _CreateCodeState();
}

class _CreateCodeState extends State<CreateCode> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            _buildQr,
            SizedBox(height: 20,),
            _inputData,

          ],
        ),
      ),
    );
  }
  get _buildQr{
    return QrImage(
      data: controller.text,
      size: 200,
      backgroundColor: Colors.white,

    );
  }
  get _inputData{
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: (){
              setState((){

              });
            },
            icon: Icon(Icons.done),
            color: Colors.green,
          ),
          hintText: "Enter Url",
          hintStyle: TextStyle(fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.blue
            )
          ),

          
          
        ),

      ),
    );
  }
}
