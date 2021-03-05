import 'package:flutter/material.dart';

class InformationItem extends StatelessWidget {
  final IconData icon;
  final String text;
  InformationItem({@required this.icon, @required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(icon), SizedBox(width: 3), Text(text)],
    );
  }
}
