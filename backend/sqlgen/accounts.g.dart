import 'dart:convert';

class Accounts {
  const Accounts({
    required this.created_at,
    required this.balance,
    required this.id,
    required this.currency,
    required this.owner,
  });

  factory Accounts.fromMap(Map<String, dynamic> map) {
    return Accounts(
      created_at: DateTime.parse(map['created_at'].toString()),
      balance: map['balance'].toInt(),
      id: map['id'].toInt(),
      currency: map['currency'],
      owner: map['owner'],
    );
  }

  factory Accounts.fromJson(String source) => Accounts.fromMap(json.decode(source));

  final DateTime created_at;

  final int balance;

  final int id;

  final String currency;

  final String owner;

  Accounts copyWith({
    DateTime? created_at,
    int? balance,
    int? id,
    String? currency,
    String? owner,
  }) {
    return Accounts(
      created_at: created_at ?? this.created_at,
      balance: balance ?? this.balance,
      id: id ?? this.id,
      currency: currency ?? this.currency,
      owner: owner ?? this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': created_at.toIso8601String(),
      'balance': balance,
      'id': id,
      'currency': currency,
      'owner': owner,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Accounts &&
        other.created_at == created_at &&
        other.balance == balance &&
        other.id == id &&
        other.currency == currency &&
        other.owner == owner;
  }

  @override
  int get hashCode {
    return created_at.hashCode ^ balance.hashCode ^ id.hashCode ^ currency.hashCode ^ owner.hashCode;
  }

  @override
  String toString() {
    return 'Accounts(created_at: $created_at  , balance: $balance, id: $id, currency: $currency, owner: $owner)';
  }
}
