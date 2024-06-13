import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:payment_management_app/database/payment_database.dart';
import 'package:payment_management_app/repository/common/model/user_model.dart';
import 'package:payment_management_app/repository/payment/contract/payment_repository.dart';
import 'package:payment_management_app/repository/payment/model/payment_model.dart';
import 'package:payment_management_app/repository/payment/repository/payment_repository_builder.dart';
import '../../repository/common/model/activity_list_model.dart';

class PaymentController extends ChangeNotifier {

  ///---------------------- methods---------------------


  int selectedBottomNavigationIndex = 0;

  ///-------- changing the index of bottom navigation in home screen
  void setSelectedBottomNavigationIndex(int index){
    selectedBottomNavigationIndex = index;
    notifyListeners();
  }

  /// -------------------------DataBase-------------------

  final PaymentRepository _paymentRepository = PaymentRepositoryBuilder.repository();


  List<PaymentModel> _payments = [];

  List<PaymentModel> get payments => _payments;

  /// ----- method for fetching payments and updating the _payments list
  Future<void> getPayments() async {
    _payments = await _paymentRepository.getPayment();
    notifyListeners();
  }

  /// ----- method for fetching payments for (future builder)
  Future<List<PaymentModel>> fetchPayments() async {
    return await _paymentRepository.getPayment();
  }

  /// ----- method for adding payments
  Future<void> addPayment(PaymentModel paymentModel) async {
    _paymentRepository.addPayment(paymentModel);
    getPayments();
  }

  /// ----- method for update payments
  Future<void> updatePayment(PaymentModel paymentModel) async {
    _paymentRepository.updatePayment(paymentModel);
    getPayments();
  }


  /// ----- method for delete
  Future<void> deletePayment(String id) async {
    _paymentRepository.deletePayment(id);
    getPayments();
  }



  ///---------------------mock data--------------------

  ///------ user list
 List<UserModel> userList = [
   UserModel(
     id: "376d6a47-8215-4094-a1b7-dd1207257175",
     firstName: "John",
     lastName: "Deo",
     avtarUrl: "https://avatar.iran.liara.run/public/2"
   ),
   UserModel(
       id: "376d6a47-8215-4094-a1b7-dd1207257176",
       firstName: "Johnny",
       lastName: "Chimpo",
       avtarUrl: "https://avatar.iran.liara.run/public/3"
   ),
   UserModel(
       id: "376d6a47-8215-4094-a1b7-dd1207257177",
       firstName: "Gail",
       lastName: "Mechnet",
       avtarUrl: "https://avatar.iran.liara.run/public/4"
   ),
   UserModel(
       id: "376d6a47-8215-4094-a1b7-dd1207257178",
       firstName: "Maa",
       lastName: "Jamison",
       avtarUrl: "https://avatar.iran.liara.run/public/5"
   ),
   UserModel(
       id: "376d6a47-8215-4094-a1b7-dd1207257179",
       firstName: "Rochel",
       lastName: "Desong",
       avtarUrl: "https://avatar.iran.liara.run/public/6"
   ),
   UserModel(
       id: "376d6a47-8215-4094-a1b7-dd1207257180",
       firstName: "Delores",
       lastName: "Rathbun",
       avtarUrl: "https://avatar.iran.liara.run/public/7"
   ),
 ];


  ///------ setting screen list
  List settingItemsList = [
    {
      "title":"Personal",
      "icon": Icons.person,
    },
    {
      "title":"My QR Code",
      "icon": Icons.qr_code,
    },
    {
      "title":"Bank and Cards",
      "icon": Icons.home_work_outlined,
    },
    {
      "title":"Payment Preferences",
      "icon": Icons.payments,
    },
    {
      "title":"Automatic Payment",
      "icon": Icons.autorenew,
    },
    {
      "title":"Login and Security",
      "icon": Icons.login,
    },
    {
      "title":"Notification",
      "icon": Icons.notifications,
    },
    {
      "title":"Logout",
      "icon": Icons.logout,
    },
  ];

  ///------ payment transaction list
  final List<ActivityListModel> activities = [
    ActivityListModel(
      title: 'Apple MacBook Pro 16-Silver',
      subtitle: 'Payment',
      trailingText: '\$3,234.03',
      description: 'Return time remaining 2week'
    ),
    ActivityListModel(
      title: 'Ueno Coffee Filters',
      subtitle: 'Target',
      trailingText: '\$5.03',
        description: 'Return time remaining 2week'
    ),
    ActivityListModel(
      title: 'Cycle',
      subtitle: 'Payments',
      trailingText: '\$35.03',
        description: 'Return time remaining 2week'
    ),
    ActivityListModel(
      title: 'Mobile',
      subtitle: 'Payments',
      trailingText: '\$3435.03',
        description: 'Return time remaining 2week'
    ),
  ];


  ///------ home screen bottom navigation list
  final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.dashboard, 'label': 'Dashboard'},
    {'icon': Icons.qr_code, 'label': 'Scan Receipt'},
    {'icon': Icons.send, 'label': 'Send&Request'},
    {'icon': Icons.settings, 'label': 'Settings'},
  ];









}

