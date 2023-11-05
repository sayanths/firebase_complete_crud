import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPaddingTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final String title;
  final String? hint;
  final bool? suffixIconHide;
  final TextInputType? textInputType;
  const CustomPaddingTextfield({
    super.key,
    this.controller,
    this.validate,
    required this.title,
    this.hint,
    this.suffixIconHide,
    this.textInputType,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomPaddingTextfieldState createState() => _CustomPaddingTextfieldState();
}

class _CustomPaddingTextfieldState extends State<CustomPaddingTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // Set the initial state of obscureText based on the suffixIconHide property
    _obscureText = widget.suffixIconHide != true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: TextFormField(
        keyboardType: widget.textInputType,
        validator: widget.validate,
        controller: widget.controller,
        obscureText: _obscureText, // Use the _obscureText state variable
        decoration: InputDecoration(
          labelText: widget.title,
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          suffixIcon: widget.suffixIconHide == true
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText; // Toggle obscureText
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validate;
  final String title;
  final TextInputType textInputType;
  final String? hint;
  final bool readOnly;
  final double horizontalL;
  final double horizontalR;
  final int? maxLinesl;
  final bool? obscure;
  final List<TextInputFormatter>? inputFormatters;
  final bool showPasswordToggleIcon; // Added parameter

  const CustomTextField({
    Key? key,
    this.horizontalL = 18,
    this.horizontalR = 18,
    this.controller,
    this.validate,
    required this.title,
    required this.textInputType,
    this.hint,
    this.readOnly = false,
    this.maxLinesl,
    this.obscure,
    this.inputFormatters,
    this.focusNode,
    this.showPasswordToggleIcon = false, // Default value is false
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: widget.horizontalL, right: widget.horizontalR),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(widget.focusNode);
            },
            child: TextFormField(
              style: K2DFonts.regular(
                fontSize: 15,
              ),
              maxLines: widget.maxLinesl,
              keyboardType: widget.textInputType,
              controller: widget.controller,
              focusNode: widget.focusNode,
              readOnly: widget.readOnly,
              validator: widget.validate,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                hintText: widget.hint,
                labelText: widget.title,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

InputDecoration inputDecoration({String? labelText, String? hintText}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: K2DFonts.medium(
      color: Colors.black.withOpacity(0.6),
      fontSize: 15,
    ),
    hintText: hintText,
    labelText: labelText,
    hintStyle: K2DFonts.medium(
      color: Colors.black.withOpacity(0.5),
      fontSize: 15,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
  );
}
