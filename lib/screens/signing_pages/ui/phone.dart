import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WdgtLoginPhone extends StatefulWidget {
  const WdgtLoginPhone({Key key}) : super(key: key);

  @override
  _WdgtLoginPhoneState createState() => _WdgtLoginPhoneState();
}

class _WdgtLoginPhoneState extends State<WdgtLoginPhone> {
  final txtController = TextEditingController(text: '');

  validateText() {
    Provider.of<VMLoginData>(context).phoneNum = txtController.text;
    print(Provider.of<VMLoginData>(context).phoneNum);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      controller: txtController,
      maxLength: 9,
      maxLengthEnforced: true,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.pink),
      onChanged: (str) {
        validateText();
      },
      decoration: InputDecoration(
        fillColor: Colors.blue,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue)),
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.blue,
        ),
        labelText: '+966',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.pink)),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.pink)),
      ),
    );
  }
}
