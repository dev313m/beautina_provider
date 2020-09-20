import 'package:flutter/material.dart';

class AnimatedSubmitButton extends StatefulWidget {
  final Function function;
  final Color color;
  final double height;
  final double width;
  final Widget insideWidget;
  final Duration animationDuration;
  final Color splashColor; 
  AnimatedSubmitButton(
      {Key key,
      this.splashColor,
      this.animationDuration,
      this.function,
      this.color,
      this.width,
      this.height,
      this.insideWidget})
      : super(key: key);

  _AnimatedSubmitButtonState createState() => _AnimatedSubmitButtonState();
}

class _AnimatedSubmitButtonState extends State<AnimatedSubmitButton>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
        upperBound: widget.width - widget.height,
        lowerBound: 1);
    animationController.addListener(() async {
      this.setState(() {
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width - animationController.value,
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        shadowColor: widget.color.withAlpha(99),
        color: widget.color,
        elevation: 7.0,
        child: InkWell(
          borderRadius: new BorderRadius.circular(22),
          splashColor: widget.splashColor,
          onTap: () async {
            widget.function(animationController);
          },
          child: animationController.isCompleted
              ? CircularProgressIndicator(
                  strokeWidth: 4,
                  backgroundColor: Colors.indigo,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
                )
              : Center(child: widget.insideWidget),
        ),
      ),
    );
  }
}
