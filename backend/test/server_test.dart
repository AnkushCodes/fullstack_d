
import 'package:test/test.dart';

import '../bin/postgres_helper.dart';
import '../bin/store.dart';
import '../sqlgen/account.sql.dart';
import '../sqlgen/accounts.g.dart';
import '../sqlgen/db.dart';
import '../utils/random.dart';

// void main() {
//   final port = '8080';
//   final host = 'http://0.0.0.0:$port';
//   late Process p;
//
//   setUp(() async {
//     p = await Process.start(
//       'dart',
//       ['run', 'bin/server.dart'],
//       environment: {'PORT': port},
//     );
//     // Wait for server to start and print to stdout.
//     await p.stdout.first;
//   });
//
//   tearDown(() => p.kill());
//
//   test('Root', () async {
//     final response = await get(Uri.parse('$host/'));
//     expect(response.statusCode, 200);
//     expect(response.body, 'Hello, World!\n');
//   });
//
//   test('Echo', () async {
//     final response = await get(Uri.parse('$host/echo/hello'));
//     expect(response.statusCode, 200);
//     expect(response.body, 'hello\n');
//   });
//
//   test('404', () async {
//     final response = await get(Uri.parse('$host/foobar'));
//     expect(response.statusCode, 404);
//   });
// }

createTestAccount(PostgresHelp postgresHelp) async{
  RandomUtils randomUtils = RandomUtils();

  CreateAccountParams createAccountParams = CreateAccountParams(owner: randomUtils.randomOwnerName(), balance: randomUtils.randomMoney(), currency: randomUtils.randomCurrency());
  AccountOperation accountOperation =AccountOperation(Transaction() as DBTX);
  Accounts accounts = await  accountOperation.createAccount(createAccountParams);

  expect(accounts.balance, createAccountParams.balance);
  expect(accounts.owner, createAccountParams.owner);
  expect(accounts.currency, createAccountParams.currency);
  expect(accounts.id,isNonZero);
  expect(accounts.created_at,isNotNull);
  return accounts;
}

void main(){
  PostgresHelp postgresHelp = PostgresHelp();
    setUp(() async {

  });

  test('test create account', () async{
    await postgresHelp.init();
    await createTestAccount(postgresHelp);
  });


  test('test getaccount', () async{
    await postgresHelp.init();
    Accounts accounts1 = await createTestAccount(postgresHelp);
    await Future.delayed(Duration(seconds: 2));
    AccountOperation accountOperation =AccountOperation(Transaction() as DBTX);
    Accounts accounts2  = await accountOperation.getAccount(accounts1.id);

    expect(accounts1.id, accounts2.id);
    expect(accounts1.owner, accounts2.owner);
    expect(accounts1.balance, accounts2.balance);
    expect(accounts1.currency, accounts2.currency);
  });

  test('test update account', () async{
    await postgresHelp.init();
    Accounts accounts1 = await createTestAccount(postgresHelp);
    await Future.delayed(Duration(seconds: 2));
    AccountOperation accountOperation =AccountOperation(Transaction() as DBTX);
    UpdateAccountParams updateAccountParams =UpdateAccountParams(balance: RandomUtils().randomMoney(),id: accounts1.id);
    Accounts accounts2  = await accountOperation.updateAccount(updateAccountParams);

    expect(accounts1.id, accounts2.id);
    expect(accounts1.owner, accounts2.owner);
    expect(updateAccountParams.balance, accounts2.balance);
    expect(accounts1.currency, accounts2.currency);
  });


  test('test delete account', () async{
    await postgresHelp.init();
    Accounts accounts1 = await createTestAccount(postgresHelp);
    await Future.delayed(Duration(seconds: 2));
    AccountOperation accountOperation =AccountOperation(Transaction() as DBTX);
     await accountOperation.deleteAccount(accounts1.id);
     // Accounts accounts2 = await accountOperation.getAccount(accounts1.id);
// print(accounts2);
    // expect(accounts1.id, accounts2.id);
    // expect(accounts1.owner, accounts2.owner);
    // expect(updateAccountParams.balance, accounts2.balance);
    // expect(accounts1.currency, accounts2.currency);
  });

  test('test list account', () async{
    await postgresHelp.init();
    for(int i=0;i<2;i++){
      await createTestAccount(postgresHelp);
    }
    ListAccountsParams listAccountsParams=ListAccountsParams(limit: 5,offset: 5);
    AccountOperation accountOperation =AccountOperation(Transaction() as DBTX);
   List<Accounts> acc= await accountOperation.listAccounts(listAccountsParams);
   print(acc);
  });

  test('transaction table',()async {
    try{
      final params =TransferTxParams(fromAccountId: 1, toAccountId: 2, amount: 100);

      final result = await Storetx().transferTx(params);

      print("$result");
    }catch(e){
      print(e);
    }finally{

    }
  });


}

