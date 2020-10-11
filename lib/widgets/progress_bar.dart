import 'package:flutter/material.dart';

import 'package:to_da/constant.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final int index;

  const ProgressBar({Key key, this.value, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: LayoutBuilder(
          builder: (context, size) {
        double barWidth;
        if(value < 1){
          barWidth = size.maxWidth * (value - 0.01) ;
        }
        else {
          barWidth = size.maxWidth * value - 40;
        }
        return Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 7.0,
                  width: size.maxWidth - 40,
                  decoration: BoxDecoration(

                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(2.5)),
                ),
                AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 500),
                  width: value == 0
                      ? 0.0
                      : barWidth,
                  height: 7,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,width: 1),
                      borderRadius: BorderRadius.circular(2.5),
                      gradient: LinearGradient(colors: appColor[index])),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    height: 0,
                    fontFamily: 'Baloo Tammudu 2',
                    color: Colors.white),
              ),
            )
          ],
        );
      }),
    );
  }
}
