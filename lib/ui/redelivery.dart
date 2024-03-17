import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:retailer_bukizz/Widgets/PDF/pdf_viewer.dart';
import 'package:retailer_bukizz/constants/dimensions.dart';
import 'package:retailer_bukizz/controller/order_controller.dart';

import '../Widgets/text and textforms/Reusable_text.dart';
import '../constants/colors.dart';
import '../models/home_model.dart';

class RedeliveryScreen extends StatefulWidget {
  @override
  State<RedeliveryScreen> createState() => _RedeliveryScreenState();
}

class _RedeliveryScreenState extends State<RedeliveryScreen> {
  final OrderController controller = Get.put(OrderController());
  Future<void> _refreshOrders() async {
    await controller.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.redeliveryOrders.isEmpty) {
            return const Center(
              child: Text('No orders available'),
            );
          } else {
            return Container(
              height: 110.sp,
              child: RefreshIndicator(
                onRefresh: _refreshOrders,
                child: ListView.builder(
                  itemCount: controller.redeliveryOrders.length,
                  itemBuilder: (context, index) {
                    final order = controller.redeliveryOrders[index];
                    double price = 0.0;
                    double cancel = 0.0;

                    try {
                      price = double.parse(order.grossamount);
                    } catch (e) {
                      print('Error parsing price: $e');
                    }

                    try {
                      cancel = double.parse(order.cancellationcharges);
                    } catch (e) {
                      print('Error parsing cancel: $e');
                    }

                    double total = cancel + price;
                    return GestureDetector(
                      onTap: (){
                        controller.selectedOrder=order;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFViewer()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: dimensions.width24,left: 12,right: 12,top: 24),
                        padding: EdgeInsets.symmetric(
                          horizontal: dimensions.width10 * 2,
                          vertical: dimensions.height10 * 2,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 12,
                                  spreadRadius: 4,
                                  offset: Offset(0,-1)
                              )
                            ]
                        ),
                        width: dimensions.screenWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReusableText(
                                  text: "#${order.ordernumber}",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                Column(
                                  children: [
                                    ReusableText(
                                      text: 'Amount',
                                      fontSize: 12,
                                      color: AppColors.lightTextColor,
                                    ),
                                    SizedBox(height: 20,),
                                    ReusableText(
                                      text: '₹ $total',
                                      fontSize: 16,
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: dimensions.height10 * 1.2,),
                            SizedBox(
                              width: dimensions.width10 * 19,
                              child: Text(
                                '${order.column1}',
                                style: TextStyle(
                                  color: Color(0xFF121212),
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(height: dimensions.height10,),
                            SizedBox(
                              width: dimensions.width10 * 19,
                              child: Text(
                                '${order.column2}',
                                style: TextStyle(
                                  color: Color(0xFF121212),
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(height: dimensions.height10,),
                            SizedBox(
                              width: dimensions.width10 * 19,
                              child: Text(
                                '${order.column3}',
                                style: TextStyle(
                                  color: Color(0xFF121212),
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(height: dimensions.height10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: 'Status:',
                                  fontSize: 12,
                                  color: AppColors.lightTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(width: 4,),
                                ReusableText(
                                  text: order.status,
                                  fontSize: 12,
                                  color: Color(0xFF058FFF),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),

                            if (order.status == 'initiated' || order.status == 'Redelivery')
                              InkWell(
                                onTap: () {
                                  showCustomAboutDialog(context , order);
                                  return;
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100.w,
                                  height: 25.sp,
                                  decoration: ShapeDecoration(
                                    shadows: const [
                                      BoxShadow(
                                        color: AppColors.tabcolor,
                                        offset: Offset(0, 4),
                                      )
                                    ],
                                    color: AppColors.buttonColor,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.50,
                                        color: Colors.black12,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: ReusableText(
                                    text: 'Pack Order',
                                    fontSize: 16,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

void showCustomAboutDialog(BuildContext context  , HomeModel orderData) {
  Dimensions dimensions=Dimensions(context);
  var orderController=Get.put(OrderController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
          title: Center(
            child: Column(
              children: [
                ReusableText(text: 'Are You ready to pack this order', fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xFF121212),),
                SizedBox(height: dimensions.height10*2,),
                const SizedBox(
                  width: 294,
                  child: Text(
                    'Please ensure all items are checked and ready for shipment.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          content:Container(
            // width: dimensions.width10*35.6,
            height: dimensions.height10*8.5,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: dimensions.width10*11.5,
                    height: dimensions.height10*3.5,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: ReusableText(text: 'Cancel', fontSize: 14,fontWeight: FontWeight.w600, color: Color(0xFF00579E),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async{
                    await FirebaseFirestore.instance.collection('Orders').doc(orderData.ordernumber).update({
                      'status':"Packed"
                    }).then((value) {
                      orderController.selectedOrder=orderData;
                      // context.read<order.Order>().setSelectedOrder(orderData);
                      Navigator.of(context).pop();
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => BillScreen()));
                    }).catchError((e){
                      Get.snackbar('Error', '$e');
                    });
                  },
                  child: Container(
                    width: dimensions.width10*11.5,
                    height: dimensions.height10*3.5,
                    decoration: ShapeDecoration(
                      color: Color(0xFF058FFF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: Center(
                      child: ReusableText(text: 'Pack', fontSize: 14,fontWeight: FontWeight.w600, color:Colors.white,),
                    ),
                  ),
                )
              ],
            ),
          )

      );

    },
  );
}
