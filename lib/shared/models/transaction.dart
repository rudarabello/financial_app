import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';

enum Payment { normal, parcelada, fixa }

class Transaction {
  final DateTime date;
  final String description;
  final double value;
  final Type type;
  final String categoryId;
  final bool fulfilled;
  final String? id;
  final Payment payment;
  final DateTime? endDate;

  Transaction({
    this.id,
    required this.date,
    required this.description,
    required this.value,
    required this.type,
    required this.categoryId,
    required this.fulfilled,
    required this.payment,
    this.endDate,
  }) : assert(payment != Payment.fixa || endDate != null);

  factory Transaction.fromCategory({
    required DateTime date,
    required String description,
    required double value,
    required Category category,
    required bool fulfilled,
    required Payment payment,
    DateTime? endDate,
  }) {
    return Transaction(
      date: date,
      description: description,
      value: value,
      type: category.type,
      categoryId: category.id!,
      fulfilled: fulfilled,
      payment: payment,
      endDate: endDate,
    );
  }

  String get valueString =>
      'R\$ ${value.toStringAsFixed(2).replaceFirst('.', ',')}';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': Timestamp.fromDate(date)});
    result.addAll({'description': description});
    result.addAll({'value': value});
    result.addAll({'type': type.name});
    result.addAll({'categoryId': categoryId});
    result.addAll({'fulfilled': fulfilled});
    result.addAll({'payment': payment.name});
    if (endDate != null) {
      result.addAll({'endDate': Timestamp.fromDate(endDate!)});
    }

    return result;
  }

  factory Transaction.fromMap(String id, Map<String, dynamic> map) {
    final type = map['type'] == 'expense' ? Type.expense : Type.income;
    final payment = map['payment'] == 'normal'
        ? Payment.normal
        : map['payment'] == 'fixa'
            ? Payment.fixa
            : Payment.parcelada;
    
    DateTime? endDate;
    try {
      endDate = (map['endDate'] as Timestamp).toDate();
    } catch (e) {
      endDate = null;
    }

    return Transaction(
      id: id,
      date: (map['date'] as Timestamp).toDate(),
      description: map['description'] ?? '',
      value: (map['value'] ?? 0).toDouble(),
      type: type,
      categoryId: map['categoryId'] ?? '',
      fulfilled: map['fulfilled'] ?? false,
      payment: payment,
      endDate: endDate,
    );
  }

  Transaction copyWith({
    DateTime? date,
    String? description,
    double? value,
    Type? type,
    String? categoryId,
    bool? fulfilled,
    Payment? payment,
    DateTime? endDate,
  }) {
    return Transaction(
      id: id,
      date: date ?? this.date,
      description: description ?? this.description,
      value: value ?? this.value * 100,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      fulfilled: fulfilled ?? this.fulfilled,
      payment: payment ?? this.payment,
      endDate: endDate ?? this.endDate,
    );
  }
}
