import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeautyTextfield extends StatefulWidget {
  final Color backgroundColor, accentColor, textColor;
  final String placeholder;
  final Icon prefixIcon, suffixIcon;
  final bool isBox;
  final TextInputType inputType;
  final Duration duration;
  final bool readOnly;
  final String suffixText;
  final String prefixText;
  // final FontStyle fontStyle;
  final TextStyle textStyle;
  final String helperText;
  final bool autofocus, autocorrect, enabled, obscureText, isShadow;
  final int maxLength, minLines, maxLines;
  final ValueChanged<String> onChanged, onSubmitted;
  final GestureTapCallback onTap;

  const BeautyTextfield(
      {this.prefixIcon,
      this.inputType,
      this.textStyle,
      this.isBox = false,
      this.suffixIcon,
      this.readOnly = false,
      this.duration = const Duration(milliseconds: 500),
      this.obscureText = false,
      this.helperText = '',
      this.suffixText,
      this.prefixText,
      this.backgroundColor = const Color(0xFF2B0B3A),
      this.textColor = const Color(0xFF9A9A2D),
      this.accentColor = Colors.white,
      this.placeholder = "Placeholder",
      this.isShadow = true,
      // this.fontStyle,
      this.autofocus = false,
      this.autocorrect = false,
      this.enabled = true,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.onChanged,
      this.onTap,
      this.onSubmitted})
      :
        // assert(prefixIcon != null),
        assert(inputType != null);

  @override
  _BeautyTextfieldState createState() => _BeautyTextfieldState();
}

class _BeautyTextfieldState extends State<BeautyTextfield> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // width: ScreenUtil().setWidth(300),
      height: !widget.isBox ? 120.h : 400.h,
      // margin: widget.margin,
      // alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          boxShadow: widget.isShadow
              ? [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]
              : BoxShadow(spreadRadius: 0, blurRadius: 0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: widget.suffixIcon == null
              ? isFocus
                  ? widget.accentColor
                  : widget.backgroundColor
              : widget.backgroundColor),
      child: Center(
        child: TextField(
          // cursorWidth: 2,
          maxLength: widget.maxLength,
          obscureText: widget.obscureText,
          readOnly: widget.readOnly,
          // maxLength: !widget.isBox ? 1 : 4,
          maxLines: !widget.isBox ? 1 : 4,
          keyboardType: widget.inputType,

          controller: widget.readOnly
              ? TextEditingController(text: widget.placeholder)
              : null,
          style: widget.textStyle,
          textInputAction: TextInputAction.done,
          // toolbarOptions: ToolbarOptions(),

          autofocus: widget.autofocus,
          autocorrect: widget.autocorrect,
          enabled: widget.enabled,
          // maxLength: widget.maxLength,
          // maxLines: widget.maxLines,
          // minLines: widget.minLines,
          onChanged: widget.onChanged,
          onTap: () {
            setState(() {
              isFocus = true;
            });
            if (widget.onTap != null) {
              widget.onTap();
            }
          },
          onSubmitted: (t) {
            setState(() {
              isFocus = false;
            });
            widget.onSubmitted(t);
          },

          // textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              suffixText: widget.suffixText,
              prefixText: widget.prefixText,
              labelStyle: TextStyle(color: Colors.pink),
              hintText: widget.helperText,
              // labelText: 'labels',
              counterText: '',
              // prefixIcon: widget.prefixIcon,
              border: new OutlineInputBorder(borderSide: BorderSide.none),
              // hintText: widget.placeholder,
              // helperText: 'Keep it short, this is just a demo.',
              labelText: widget.helperText),
          cursorColor: isFocus ? widget.accentColor : widget.backgroundColor,
        ),
      ),

      duration: widget.duration,
    );
  }
}
