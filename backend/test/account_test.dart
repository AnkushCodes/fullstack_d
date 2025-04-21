//
//
// import 'dart:indexed_db';
//
// import 'package:test/expect.dart';
//
// import '../bin/postgres_helper.dart';
// import '../sqlgen/account.sql.dart';
// import '../sqlgen/accounts.g.dart';
// import '../sqlgen/db.dart';
// import '../utils/random.dart';
//
// class AccountTest{
//   PostgresHelp? postgresHelp;
//   Future<Accounts> createRandomAccount() async{
//
// return Acc
//   }
//
//   testCreateAccount() async{
//     await createRandomAccount();
//   }
//
//   testGetAccount() async{
//     Accounts accounts1 = await createRandomAccount();
//     AccountOperation accountOperation =AccountOperation(Transaction() as DBTX);
//     Accounts accounts2  = await accountOperation.getAccount(accounts1.id);
//
//     expect(accounts1.id, accounts2.id);
//     expect(accounts1.owner, accounts2.owner);
//     expect(accounts1.balance, accounts2.balance);
//     expect(accounts1.currency, accounts2.currency);
//   }
//
// }