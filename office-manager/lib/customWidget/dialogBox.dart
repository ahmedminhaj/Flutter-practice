import 'package:flutter/material.dart';
import 'package:HajiraKhata/customWidget/customText.dart';

class DialogBox extends StatelessWidget {
  String popUpText;
  final confirmAction;
  final backAction;

  DialogBox({
    this.backAction,
    this.confirmAction,
    this.popUpText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: CustomText(
                inputText: popUpText,
                align: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  onPressed: confirmAction,
                  child: CustomText(
                    inputText: "Confirm",
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  color: Colors.red,
                  onPressed: backAction,
                  child: CustomText(
                    inputText: "Back",
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}