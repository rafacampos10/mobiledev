import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LetsStart extends StatelessWidget {
  const LetsStart({Key? key, this.onPressed}) : super(key: key);
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Vamos Começar",
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 25,
              )),
          Icon(CupertinoIcons.right_chevron,
              color: CupertinoColors.white),
        ],
      ),
    );
  }
}