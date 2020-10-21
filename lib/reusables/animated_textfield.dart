import 'package:beautina_provider/reusables/text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class BeautyTextfieldT extends StatefulWidget {
  final BorderRadius cornerRadius;
  final double width, height, wordSpacing;
  final Color backgroundColor, accentColor, textColor;
  final String placeholder, fontFamily;
  final Icon prefixIcon, suffixIcon;
  final TextInputType inputType;
  final EdgeInsets margin;
  final Duration duration;
  final VoidCallback onClickSuffix;
  final TextBaseline textBaseline;
  final FontStyle fontStyle;
  final TextStyle textStyle;
  final String helperText;
  final FontWeight fontWeight;
  final bool autofocus, autocorrect, enabled, obscureText, isShadow;
  final FocusNode focusNode;
  final int maxLength, minLines, maxLines;
  final ValueChanged<String> onChanged, onSubmitted;
  final GestureTapCallback onTap;

  const BeautyTextfieldT(
      {@required this.width,
      @required this.height,
      @required this.prefixIcon,
      @required this.inputType,
      this.textStyle,
      this.suffixIcon,
      this.duration = const Duration(milliseconds: 500),
      this.margin = const EdgeInsets.all(10),
      this.obscureText = false,
      this.helperText = '',
      this.backgroundColor = const Color(0xFF2B0B3A),
      this.cornerRadius = const BorderRadius.all(Radius.circular(10)),
      this.textColor = const Color(0xFF9A9A2D),
      this.accentColor = Colors.white,
      this.placeholder = "Placeholder",
      this.isShadow = true,
      this.onClickSuffix,
      this.wordSpacing,
      this.textBaseline,
      this.fontFamily,
      this.fontStyle,
      this.fontWeight,
      this.autofocus = false,
      this.autocorrect = false,
      this.focusNode,
      this.enabled = true,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.onChanged,
      this.onTap,
      this.onSubmitted})
      : assert(width != null),
        assert(height != null),
        assert(prefixIcon != null),
        assert(inputType != null);

  @override
  _BeautyTextfieldTState createState() => _BeautyTextfieldTState();
}

class _BeautyTextfieldTState extends State<BeautyTextfieldT> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: widget.height,

      // margin: widget.margin,
      // alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          boxShadow: widget.isShadow
              ? [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]
              : BoxShadow(spreadRadius: 0, blurRadius: 0),
          borderRadius: widget.cornerRadius,
          color: widget.suffixIcon == null
              ? isFocus
                  ? widget.accentColor
                  : widget.backgroundColor
              : widget.backgroundColor),
      child: Center(
        child: TextField(
          // cursorWidth: 2,
          obscureText: widget.obscureText,
          keyboardType: widget.inputType,
          style: widget.textStyle,
          textInputAction: TextInputAction.done,
          // toolbarOptions: ToolbarOptions(),

          autofocus: widget.autofocus,
          autocorrect: widget.autocorrect,
          focusNode: widget.focusNode,
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
              hintStyle: TextStyle(color: widget.textColor),
              hintText: widget.placeholder,
              // helperText: 'هنا ضع اسمك',
              // suffixText: 'suffex',

              // labelText: 'labels',
              prefixIcon: widget.prefixIcon,
              border: InputBorder.none),
          cursorColor: isFocus ? widget.accentColor : widget.backgroundColor,
        ),
      ),

      duration: widget.duration,
    );
  }
}
