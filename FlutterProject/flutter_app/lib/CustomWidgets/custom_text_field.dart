import 'package:flutter/material.dart';
import 'package:flutter_app/Resources/resources.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String topHintText;
  final void Function()? callback;
  final Function(String)? onChanged;
  final bool readOnly;  // Yeni parametre: readOnly ekledik
  final String? initialValue;  // Yeni parametre: initialValue ekledik

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.topHintText,
    this.onChanged,
    this.callback,
    this.readOnly = false,  // Varsayılan olarak false
    this.initialValue,  // initialValue parametresini ekledik
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);  // initialValue ile controller'ı başlatıyoruz
  }

  @override
  void dispose() {
    _controller.dispose();  // Controller'ı dispose etmemiz gerekiyor
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          shape: BoxShape.rectangle,
          color: R.colors.textBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 0, 0),
            child: Text(
              widget.topHintText,
              style: TextStyle(color: R.colors.textHintColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
            child: TextField(
              controller: _controller,  // Controller'ı kullanıyoruz
              onChanged: widget.onChanged,
              readOnly: widget.readOnly,  // Burada readOnly parametresini kullanıyoruz
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
