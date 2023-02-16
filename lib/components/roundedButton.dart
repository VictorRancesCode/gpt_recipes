import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  String buttonName;
  final VoidCallback? onTap;

  double height;
  double width;
  double bottomMargin;
  double borderWidth;
  Color buttonColor;
  Color textColor;
  Color borderColor;
  bool loading;

  RoundedButton(
      {this.loading = false,
      this.buttonName = "",
      this.onTap,
      this.height = 10.0,
      this.bottomMargin = 0.0,
      this.borderWidth = 1,
      this.width = 200.0,
      this.buttonColor = Colors.blue,
      this.textColor = Colors.white,
      this.borderColor = const Color.fromRGBO(221, 221, 221, 1.0)});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: textColor, fontSize: 16.0, fontWeight: FontWeight.bold);
    if (borderWidth != 0.0) {
      return InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.only(bottom: bottomMargin),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: !loading
              ? Text(buttonName, style: textStyle)
              : const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(bottom: bottomMargin),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: !loading
            ? Text(buttonName, style: textStyle)
            : const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
