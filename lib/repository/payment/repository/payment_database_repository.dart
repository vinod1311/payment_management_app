import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payment_management_app/database/payment_database.dart';
import 'package:payment_management_app/repository/payment/model/payment_model.dart';

import '../contract/payment_repository.dart';


class PaymentDatabaseRepository implements PaymentRepository {

  PaymentDatabase paymentDatabase = PaymentDatabase();


  @override
  Future<void> addPayment(PaymentModel paymentModel) async{
    // TODO: implement addPayment
    try{
      await paymentDatabase.insertPayment(paymentModel);
    }catch(e){
      log("Error While adding payments ${e.toString()}");
    }
  }

  @override
  Future<void> deletePayment(String id) async{
    // TODO: implement deletePayment
    try{
      await paymentDatabase.deletePayments(id);
    }catch(e){
      log("Error While deleting payments ${e.toString()}");
    }
  }

  @override
  Future<List<PaymentModel>> getPayment() async{
    // TODO: implement getPayment
    try {
      return await paymentDatabase.getPayments();
    } catch (e) {
      log("Error fetching payments: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> updatePayment(PaymentModel paymentModel) async{
    // TODO: implement updatePayment
    try{
      await paymentDatabase.updatePayments(paymentModel);
    }catch(e){
      log("Error While updating payment ${e.toString()}");
    }
  }


}