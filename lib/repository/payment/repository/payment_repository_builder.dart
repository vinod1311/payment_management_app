import 'package:payment_management_app/repository/payment/contract/payment_repository.dart';
import 'package:payment_management_app/repository/payment/repository/payment_database_repository.dart';


abstract class PaymentRepositoryBuilder {
  static PaymentRepository repository() {
    return PaymentDatabaseRepository();
  }
}