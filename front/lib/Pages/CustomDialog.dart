import 'package:flutter/material.dart';
import 'package:test_url/Styles/icons.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  // final String buttonText;

  CustomDialog({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: 100,
            left: 10,
            bottom: 10,
            right: 10
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2000,
                offset: Offset(0.0, 10.0)
            )]
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 24.0,),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24.0,),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: TextButton(
              //     onPressed: () => {
              //   },
              //   child: Text(
              //     buttonText
              //   ),
              //   ),
              // ),
            ],
          ),
        ),
       Align(
         alignment: Alignment.topCenter,
                child: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      radius: 50,
                      child: Icon(networkErrorIcon, size: 32,),
                      ),
       ),
                  
      ],
    );
  }
}
