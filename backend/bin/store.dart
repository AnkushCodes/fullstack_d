

import 'package:postgres/postgres.dart';

import 'postgres_helper.dart';

class TransferTxParams{
  final int fromAccountId;
  final int toAccountId;
  final int amount;
  TransferTxParams({required this.fromAccountId,required this.toAccountId,required this.amount});
}

class TransferTxResult{
  final Map<String, dynamic> transfer;
  final Map<String, dynamic> fromAccount;
  final Map<String, dynamic> toAccount;
  final Map<String, dynamic> fromEntry;
  final Map<String, dynamic> toEntry;
  TransferTxResult({required this.transfer, required this.fromAccount, required this.toAccount, required this.fromEntry, required this.toEntry});
}


class Storetx{

Future<TransferTxResult> transferTx(TransferTxParams params)async {
  await PostgresHelp().init();
  return await PostgresHelp.conn!.runTx((session) async{
   late final Map<String, dynamic> transfer;
   late final Map<String, dynamic> fromAccount;
   late final Map<String, dynamic> toAccount;
   late final Map<String, dynamic> fromEntry;
   late final Map<String, dynamic> toEntry;
try {
  // Create transfer record
  transfer = await session.execute(
    Sql.named('INSERT INTO transfer (from_account_id, to_account_id, amount) '
        'VALUES (@fromAccountId, @toAccountId, @amount) RETURNING *'),
    parameters: {
      'fromAccountId': params.fromAccountId,
      'toAccountId': params.toAccountId,
      'amount': params.amount,
    },
  ).then((rows) => rows.first.toColumnMap());

  // Create from entry
  fromEntry = await session.execute(
      Sql.named('INSERT INTO entries (account_id, amount) VALUES (@accountId, @amount) RETURNING *'),
    parameters: {
      'accountId': params.fromAccountId,
      'amount': -params.amount,
    },
  ).then((rows) => rows.first.toColumnMap());

  // Create to entry
  toEntry = await session.execute(
    Sql.named( 'INSERT INTO entries (account_id, amount) VALUES (@accountId, @amount) RETURNING *'),
    parameters: {
      'accountId': params.toAccountId,
      'amount': params.amount,
    },
  ).then((rows) => rows.first.toColumnMap());

  // Update balances atomically
  fromAccount = await session.execute(
    Sql.named('UPDATE accounts SET balance = balance - @amount WHERE id = @id RETURNING *'),
    parameters: {
      'id': params.fromAccountId,
      'amount': params.amount,
    },
  ).then((rows) => rows.first.toColumnMap());

  toAccount = await session.execute(
      Sql.named('UPDATE accounts SET balance = balance + @amount WHERE id = @id RETURNING *'),
    parameters: {
      'id': params.toAccountId,
      'amount': params.amount,
    },
  ).then((rows) => rows.first.toColumnMap());

  return TransferTxResult(transfer: transfer,
      fromAccount: fromAccount,
      toAccount: toAccount,
      fromEntry: fromEntry,
      toEntry: toEntry);
}catch(e){
  print(e);
  return TransferTxResult(transfer: transfer,
      fromAccount: fromAccount,
      toAccount: toAccount,
      fromEntry: fromEntry,
      toEntry: toEntry);
}
  });
}


}