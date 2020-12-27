import 'package:beautina_provider/screens/dates/ui/calendar/calendar.dart';
import 'package:beautina_provider/utils/size/edge_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeautyTextfield extends StatefulWidget {
  final Color backgroundColor, accentColor, textColor;
  final String placeholder;
  final Icon prefixIcon, suffixIcon;
  final bool isBox;
  final bool isSquare;
  final TextEditingController controller;
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
      this.controller,
      this.inputType,
      this.isSquare = false,
      this.textStyle,
      this.isBox = false,
      this.suffixIcon,
      this.readOnly = false,
      this.duration = const Duration(milliseconds: 500),
      this.obscureText = false,
      this.helperText = '',
      this.suffixText,
      this.prefixText,
      this.backgroundColor = Colors.white70,
      this.textColor = Colors.transparent,
      this.accentColor = Colors.white,
      this.placeholder = "",
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
  String text = '';
  TextEditingController _controller;

  @override
  void dispose() {
    _controller?.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      text = widget.placeholder;
      _controller = TextEditingController(text: widget.placeholder);
    } else
      _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // width: ScreenUtil().setWidth(300),
      height: !widget.isBox
          ? widget.isSquare
              ? heightBtnSquare
              : heightTextField
          : 250.h,
      // margin: widget.margin,
      // alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      decoration: BoxDecoration(
          boxShadow: widget.isShadow
              ? [
                  BoxShadow(
                      color: Colors.transparent, blurRadius: 0, spreadRadius: 0)
                ]
              : BoxShadow(spreadRadius: 0, blurRadius: 0),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: !widget.readOnly
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
          // textStyle: TextStyle(color: AppColors.pinkBright),

          controller: widget.readOnly
              ? TextEditingController(text: widget.placeholder)
              : _controller,
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
              enabledBorder: InputBorder.none,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              suffixText: widget.suffixText,
              prefixText: widget.prefixText,
              // labelStyle: TextStyle(color: Colors.pink),
              // hintText: widget.placeholder,
              // labelText: 'labels',
              counterText: '',
              // prefixIcon: widget.prefixIcon,
              border: InputBorder.none,

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
