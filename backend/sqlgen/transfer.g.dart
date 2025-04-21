import 'dart:convert';

class Transfer {
  const Transfer({
    required this.toAccountId,
    this.fromAccountId,
    required this.createdAt,
    required this.id,
    required this.amount,
  });

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      toAccountId: map['to_account_id'].toInt(),
      fromAccountId: map['from_account_id']?.toInt(),
      createdAt: DateTime.parse(map['created_at']),
      id: map['id'].toInt(),
      amount: map['amount'].toInt(),
    );
  }

  factory Transfer.fromJson(String source) => Transfer.fromMap(json.decode(source));

  final int toAccountId;

  final int? fromAccountId;

  final DateTime createdAt;

  final int id;

  final int amount;

  Transfer copyWith({
    int? toAccountId,
    int? fromAccountId,
    DateTime? createdAt,
    int? id,
    int? amount,
  }) {
    return Transfer(
      toAccountId: toAccountId ?? this.toAccountId,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'to_account_id': toAccountId,
      'from_account_id': fromAccountId,
      'created_at': createdAt.toIso8601String(),
      'id': id,
      'amount': amount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transfer &&
        other.toAccountId == toAccountId &&
        other.fromAccountId == fromAccountId &&
        other.createdAt == createdAt &&
        other.id == id &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return toAccountId.hashCode ^ fromAccountId.hashCode ^ createdAt.hashCode ^ id.hashCode ^ amount.hashCode;
  }

  @override
  String toString() {
    return 'Transfer(toAccountId: $toAccountId, fromAccountId: $fromAccountId, createdAt: $createdAt, id: $id, amount: $amount)';
  }
}
