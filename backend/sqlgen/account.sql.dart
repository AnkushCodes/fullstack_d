
import 'accounts.g.dart';
import 'db.dart';

class CreateAccountParams{
  final String owner;
  final int balance;
  final String currency;
  CreateAccountParams({required this.owner, required this.balance, required this.currency});
}

 String createAccountQuery="INSERT INTO accounts (owner,balance,currency) VALUES (@owner,@balance,@currency) RETURNING id,owner,balance,currency,created_at";

 // String createAccountQuery="INSERT INTO accounts ( owner, balance, currency) VALUES ('ank1',1,'USD')";


class AddAccountBalanceParams {
  final int amount;
  final int id;

  AddAccountBalanceParams({required this.amount, required this.id});
}
class ListAccountsParams {
  final int limit;
  final int offset;

  ListAccountsParams({ required this.limit, required this.offset});
}

/// Parameters for updating an account.
class UpdateAccountParams {
  final int id;
  final int balance;

  UpdateAccountParams({required this.id, required this.balance});
}


class AccountOperation extends Queries {
  AccountOperation(super.db);

  Future<Accounts> createAccount(CreateAccountParams params) async {
    Transaction transaction =Transaction();
    final result = await transaction.queryRow(createAccountQuery, params: {
      'owner': params.owner,
      'balance': params.balance,
      'currency': params.currency
    });

    if (result.isNotEmpty) {
      try {
        final row = result;
        DateTime dateTime = DateTime.parse(row[4].toString());
        Accounts accounts = Accounts(id: row[0],
            owner: row[1],
            balance: row[2],
            currency: row[3],
            created_at: dateTime
        );
        return accounts;
      }catch(e){
        print(e);
        rethrow;
      }
    } else {
      throw Exception("Account creation failed");
    }
  }

  Future<Accounts> addAccountBalance(AddAccountBalanceParams params) async {
    final result = await db.query(
      '''
      UPDATE accounts
      SET balance = balance + @amount
      WHERE id = @id
      RETURNING id, owner, balance, currency, created_at
      ''',
      params: {
        'amount': params.amount.toString(),
        'id': params.id.toString(),
      },
    );
    if (result.isEmpty) {
      throw Exception('Account not found');
    }
    return Accounts.fromMap(result.first);
  }

  Future<Accounts> addAccountBalanceUpdate(AddAccountBalanceParams params) async {
    final result = await db.query(
      '''
      UPDATE accounts
      SET balance = balance + @amount
      WHERE id = @id
      RETURNING id, owner, balance, currency, created_at
      ''',
      params: {
        'amount': params.amount.toString(),
        'id': params.id.toString(),
      },
    );
    if (result.isEmpty) {
      throw Exception('Account not found');
    }
    return Accounts.fromMap(result.first);
  }



  /// Adds balance to an account and returns the updated account.
  /// Deletes an account by its ID.
  Future<void> deleteAccount(int id) async {
    try {
    await db.exec(
        '''
      DELETE FROM accounts
      WHERE id = @id
      ''',
        params: {'id': id.toString()},
      );

  // print(val);
    }catch(e){
      print(e);
    }
  }

  Future<Accounts> getAccountUpdate(int id) async {
    try {
      final result = await db.queryRow(
        '''
      SELECT id, owner, balance, currency, created_at
      FROM accounts
      WHERE id = @id
      LIMIT 1 FOR NO KEY UPDATE 
      ''',
        params: {'id': id.toString()},
      );

      if (result.isEmpty) {
        throw Exception('Account not found');
      }
      Map<String, dynamic> val = {
        "id": result[0].toInt(),
        "owner": result[1],
        "created_at":
        DateTime.parse(result[4].toString()),
        "balance": result[2].toInt(),
        "currency": result[3],

      };
      return Accounts.fromMap(val);
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }

  Future<Accounts> getAccount(int id) async {
    try {
      final result = await db.queryRow(
        '''
      SELECT id, owner, balance, currency, created_at
      FROM accounts
      WHERE id = @id
      LIMIT 1
      ''',
        params: {'id': id.toString()},
      );

      if (result.isEmpty) {
        throw Exception('Account not found');
      }
      Map<String, dynamic> val = {
        "id": result[0].toInt(),
        "owner": result[1],
        "created_at":
        DateTime.parse(result[4].toString()),
        "balance": result[2].toInt(),
        "currency": result[3],

      };
      return Accounts.fromMap(val);
    }catch(e){
      print(e.toString());
      rethrow;
    }
  }


  Future<Accounts> getAccountForUpdate(int id) async {
    final result = await db.query(
      '''
      SELECT id, owner, balance, currency, created_at
      FROM accounts
      WHERE id = @id
      LIMIT 1
      FOR NO KEY UPDATE
      ''',
      params: {'id': id.toString()},
    );
    if (result.isEmpty) {
      throw Exception('Account not found');
    }
    return Accounts.fromMap(result.first);
  }

  Future<List<Accounts>> listAccounts(ListAccountsParams params) async {
    try {
      List<List<dynamic>> results = await db.query(
        '''
      SELECT id, owner, balance, currency, created_at
      FROM accounts
      ORDER BY id
      LIMIT @limit OFFSET @offset
      ''',
        params: {
          'limit': params.limit.toString(),
          'offset': params.offset.toString(),
        },
      );
      List<dynamic> accounts =
      results.map((result) {
        Map<String, dynamic> val = {
          "id": result[0].toInt(),
          "owner": result[1],
          "created_at":
          DateTime.parse(result[4].toString()),
          "balance": result[2].toInt(),
          "currency": result[3],

        };
        return Accounts.fromMap(val);
      }
      ).toList() ;

      return accounts as List<Accounts>;
    }catch(e){
      print(e);
      rethrow;
    }
  }
  Future<Accounts> updateAccount(UpdateAccountParams params) async {
    final result = await db.queryRow(
      '''
      UPDATE accounts
      SET balance = @balance
      WHERE id = @id
      RETURNING id, owner, balance, currency, created_at
      ''',
      params: {
        'id': params.id.toString(),
        'balance': params.balance.toString(),
      },
    );
    if (result.isEmpty) {
      throw Exception('Account not found');
    }
    Map<String, dynamic> val = {
      "id": result[0].toInt(),
      "owner": result[1],
      "created_at":
      DateTime.parse(result[4].toString()),
      "balance": result[2].toInt(),
      "currency": result[3],

    };
    return Accounts.fromMap(val);
  }

}








/// Handles all database operations related to accounts.




  /// Retrieves an account by its ID.

  /// Retrieves an account by its ID with a "FOR NO KEY UPDATE" lock.

  /// Lists accounts for a specific owner with pagination.
 

  /// Updates an account's balance and returns the updated account.

