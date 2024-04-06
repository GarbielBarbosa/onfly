// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Expense {
  final String? id;
  final String? userId;
  final String category;
  final String description;
  final double value;
  final String currency;
  final DateTime date;
  Expense({
    this.id,
    this.userId,
    required this.category,
    required this.description,
    required this.value,
    required this.currency,
    required this.date,
  });

  Expense copyWith({
    String? id,
    String? userId,
    String? category,
    String? description,
    double? value,
    String? currency,
    DateTime? date,
  }) {
    return Expense(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      description: description ?? this.description,
      value: value ?? this.value,
      currency: currency ?? this.currency,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'category': category,
      'description': description,
      'value': value,
      'currency': currency,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      category: map['category'] as String,
      description: map['description'] as String,
      value: map['value'] as double,
      currency: map['currency'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) => Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, userId: $userId, category: $category, description: $description, value: $value, currency: $currency, date: $date)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == id && other.userId == userId && other.category == category && other.description == description && other.value == value && other.currency == currency && other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ category.hashCode ^ description.hashCode ^ value.hashCode ^ currency.hashCode ^ date.hashCode;
  }
}
