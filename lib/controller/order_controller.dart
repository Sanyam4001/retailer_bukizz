import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:retailer_bukizz/constants/constants.dart';
import 'package:retailer_bukizz/models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  var isLoading = false.obs;
  var deliveredOrders = <HomeModel>[].obs;
  var pendingOrders = <HomeModel>[].obs;
  var redeliveryOrders = <HomeModel>[].obs;
  List<String> fetchedOrderIds = [];
  var _selectedOrder = HomeModel(
    address: 'Sample Address',
    cancellationcharges: '0',
    city: 'Sample City',
    column1: 'Sample Column 1',
    column2: 'Sample Column 2',
    column3: 'Sample Column 3',
    grossamount: '0',
    mapaddress: 'Sample Map Address',
    mobile: '1234567890',
    name: 'Sample Name',
    ordernumber: '12345',
    pincode: '123456',
    retailer: 'Sample Retailer ID',
    status: 'Sample Status',
    deliveryBoy: 'Not Alloted',
  ).obs; // Variable to store the selected HomeModel

  HomeModel get selectedOrder => _selectedOrder.value;

  set selectedOrder(HomeModel value) => _selectedOrder.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      fetchedOrderIds = prefs.getStringList('fetchedOrderIds') ?? [];

      var querySnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('retailer', isEqualTo: prefs.getString('retailerId'))
          .get();

      deliveredOrders.clear();
      pendingOrders.clear();
      redeliveryOrders.clear();

      for (var doc in querySnapshot.docs) {
        var orderData = doc.data();
        var orderModel = HomeModel.fromMap(orderData);

        // Categorize orders based on status
        switch (orderModel.status) {
          case 'Delivered':
            deliveredOrders.insert(0,orderModel);
            break;
          case 'initiated':
            pendingOrders.insert(0,orderModel);
            break;
          case 'Packed':
            pendingOrders.insert(0,orderModel);
            break;
          case 'Redelivery':
            redeliveryOrders.insert(0,orderModel);
            break;
          default:
          // Do nothing or handle other statuses if needed
            break;
        }
      }

      // Save fetchedOrderIds to SharedPreferences
      await prefs.setStringList('fetchedOrderIds', fetchedOrderIds);

      isLoading(false);
    } catch (error) {
      print('Error fetching orders: $error');
      isLoading(false);
    }
  }
}
