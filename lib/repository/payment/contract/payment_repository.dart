import 'package:payment_management_app/repository/payment/model/payment_model.dart';

abstract class PaymentRepository {

  ///------- for adding payment
  Future<void> addPayment(PaymentModel paymentModel);

  ///------- for updating payment
  Future<void> updatePayment(PaymentModel paymentModel);

  ///------- for deleting payment
  Future<void> deletePayment(String id);

  ///------- for getting payment
  Future<List<PaymentModel>> getPayment();


}