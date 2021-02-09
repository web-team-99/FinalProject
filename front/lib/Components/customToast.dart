import 'package:flutter/material.dart';

/*
instruction:
1. implement:
      // Ftoast ftoast;

2. initialize in initState():
      // fToast = FToast();
         fToast.init(context);

3. use in your code:
    //  fToast.showToast(
          child: CustomToast(
            'Toast text',
            Icons.check,
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        ),
            

*/
class CustomToast extends StatelessWidget {
  final String text;
  final IconData iconData;

  CustomToast(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              width: 12.0,
            ),
            Icon(iconData),
          ],
        ),
      ),
    );
  }
}
