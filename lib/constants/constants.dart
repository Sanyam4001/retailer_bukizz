

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:retailer_bukizz/models/home_model.dart';
import 'package:retailer_bukizz/models/retailer%20model.dart';

import 'colors.dart';

class AppConstants {
  static late RetailerModel userData;
  static String fcmToken = '';
  static bool isLogin = false;
  static String retailerId='';

  static buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: SpinKitChasingDots(size: 24,color: AppColors.primaryColor,),
          );
        });
  }

  static Future<void> showSnackBar(BuildContext context , String text , Color color , IconData icon , {int time = 2}) async {
    var snackBar = SnackBar(
      elevation: 0,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 25.h,
          left: 10,
          right: 10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: GestureDetector(
        onTap: (){

        },
        child: Container(
          width: 270,
          // padding: const EdgeInsets.all(16),
          padding: EdgeInsets.only(left: 10),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black54,width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon ,color: Colors.white,size: 24,),
              SizedBox(height: 10,),
              SizedBox(
                width: 70.w,
                child: Wrap(
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'nunito',
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
      duration: Duration(seconds: time),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}