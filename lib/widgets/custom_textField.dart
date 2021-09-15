import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextFieldWidget extends StatefulWidget {
  CustomTextFieldWidget({
    Key? key,
    this.controller,
    this.helperValue = "",
    this.validator,
    this.readOnly = false,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.hintValue,
    this.onChanged,
    this.prefixText,
    this.type,
    this.textCapitalization = TextCapitalization.none,
    // this.fillColor = null,
    // this.textColor = null,
    this.maxLength = 30,
    this.onSubmit,
    this.helperTextStyle,
    this.focusNode,
    this.upperLabel,
    this.onEditingComplete,
    // this.textInputAction,
    this.inputFormatters,
  }) : super(key: key);
  final String? hintValue;
  final dynamic helperValue;
  final TextEditingController? controller;
  final validator;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? prefixText;
  final bool? suffixIcon;
  final TextInputType? type;
  final upperLabel;
  // TextInputAction textInputAction;
  final dynamic onChanged;
  final dynamic onEditingComplete;
  final int maxLength;
  final dynamic onSubmit;
  final TextStyle? helperTextStyle;
  final FocusNode? focusNode;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: helperValue.contains("null") ? 50 : 80,
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        readOnly: widget.readOnly,
        // style: new TextStyle(
        //     color: textColor == null
        //         ? ThemeConstants.primaryTextColor
        //         : textColor),
        focusNode: widget.focusNode,
        // cursorColor: ThemeConstants.accentColor,
        keyboardType: widget.type,
        // autocorrect: false,
        // enableSuggestions: false,
        obscureText: widget.obscureText ? _obscureText : false,
        onEditingComplete: widget.onEditingComplete,
        textCapitalization: widget.textCapitalization,
        decoration: InputDecoration(
          // suffixIcon: suffixIcon,

          suffixIcon: widget.obscureText
              ? GestureDetector(
                  onTap: _toggle,
                  child: Icon(
                    _obscureText
                        ? Icons.visibility_sharp
                        : Icons.visibility_off_sharp,
                    color: Color(0xFFA31103),
                  ),
                )
              : null,
          prefixIcon: widget.prefixIcon != null
              ? (widget.prefixIcon != null)
                  ? Icon(
                      widget.prefixIcon,
                      color: Color(0xFFA31103),
                      size: 16,
                    )
                  : null
              : widget.prefixText,
          // contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Color(0xFFA31103),
              // width: 0.1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.red,
              // width: 0.1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              width: 0,
              color: Color(0xFFA31103),
              // style: BorderStyle.none,
            ), // borderSide: BorderSide(
            //   color: ThemeConstants.black,
            //   width: 0.1,
            // ),
          ),
          border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            // borderSide: BorderSide(
            //   color: ThemeConstants.accentColor,
            //   width: 0.05,
            // ),
            // borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          // fillColor:
          //     fillColor == null ? Colors.black.withOpacity(0.3) : fillColor,
          filled: true,
          // focusColor: ThemeConstants.accentColor,
          counterText: "",
          helperText: widget.helperValue,

          // helperText: helperValue.contains("null") ? null : helperValue,
          // helperStyle: TextStyle(
          //     color: textColor == null
          //         ? ThemeConstants.primaryTextColor
          //         : textColor),
          labelText: widget.upperLabel,
          // labelStyle: TextStyle(
          //     color: textColor == null
          //         ? ThemeConstants.secondaryTextColor
          //         : textColor),
          hintText: widget.hintValue,
          // hintStyle: TextStyle(
          //     color: textColor == null
          //         ? ThemeConstants.secondaryTextColor
          //         : textColor),
        ),

        validator: widget.validator,
        controller: widget.controller,
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,
        onFieldSubmitted: widget.onSubmit,
      ),
    );
  }
}
