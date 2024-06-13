import 'package:payment_management_app/repository/payment/model/payment_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PaymentDatabase {
  static final PaymentDatabase _instance = PaymentDatabase._internal();
  factory PaymentDatabase() => _instance;

  PaymentDatabase._internal();

  late Database _db;

  ///-------- PAYMENT data initialization method
  Future<void> initializeDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'payment_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE payments(id TEXT PRIMARY KEY, amount TEXT, userId TEXT, note TEXT, date TEXT)",
        );
      },
      version: 1,
    );
  }

  /// ------ add payment method
  Future<void> insertPayment(PaymentModel paymentModel) async {
    await _db.insert('payments', paymentModel.toJson());
  }

  /// ------ get payment method
  Future<List<PaymentModel>> getPayments() async {
    final List<Map<String, dynamic>> maps = await _db.query('payments');
    return List.generate(maps.length, (i) {
      return PaymentModel.fromJson(maps[i]);
    });
  }

  /// ------ update payment method
  Future<void> updatePayments(PaymentModel paymentModel) async {
    await _db.update(
      'payments',
      paymentModel.toJson(),
      where: 'id = ?',
      whereArgs: [paymentModel.id],
    );
  }

  /// ------ delete payment method
  Future<void> deletePayments(String id) async {
    await _db.delete(
      'payments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }






  ///------------------------------------------------------------
}
