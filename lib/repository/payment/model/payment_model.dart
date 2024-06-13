// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  String? id;
  String? amount;
  String? userId;
  String? note;
  String? date;

  PaymentModel({
    this.id,
    this.amount,
    this.userId,
    this.note,
    this.date,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: json["id"],
    amount: json["amount"],
    userId: json["userId"],
    note: json["note"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "userId": userId,
    "note": note,
    "date": date,
  };
}
