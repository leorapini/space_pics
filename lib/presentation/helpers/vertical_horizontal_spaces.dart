import 'package:flutter/material.dart';

class AddVerticalSpace extends StatelessWidget {
  final double height;

  const AddVerticalSpace(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,);
  }
}

class AddHorizontalSpace extends StatelessWidget {
  final double width;

  const AddHorizontalSpace(this.width);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,);
  }
}