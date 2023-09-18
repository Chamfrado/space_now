import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? textController;
  final bool? obscureText;
  final TextInputType? inputType;
  final String? Function(String?)? inputValidator;
  final Icon? iconInput;

  const FormTextField(
      {super.key,
      this.labelText,
      this.hintText,
      this.textController,
      this.obscureText,
      this.inputType,
      this.inputValidator,
      this.iconInput});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
        vertical: 10,
      ),
      child: TextFormField(
        controller: textController,
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: iconInput,
          labelText: labelText,
          hintText: hintText,
          border: const UnderlineInputBorder(),
        ),
        obscureText: obscureText ?? false,
        validator: inputValidator,
      ),
    );
  }
}
