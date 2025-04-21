import 'dart:async';

import 'package:postgres/postgres.dart';

import '../bin/postgres_helper.dart';

abstract class DBTX {
  Future<void> exec(String sql, {required Map<String, String> params});
  Future<dynamic> query(String sql,{required Map<String, String> params});
  Future<List<dynamic>> queryRow(String sql,{required Map<String, String> params});
}

class Queries{
  final DBTX db;
  Queries(this.db);
  Queries withTx(Transaction tx){
    return Queries(tx);
  }
}

class Transaction implements DBTX{
 
  @override
  Future<void> exec(String sql, {required Map<String, String> params}) async{
    await PostgresHelp.conn!.execute(
        Sql.named(sql),
        parameters: params
      // sql
    );
  }

  @override
  Future<dynamic> query(String sql, {required Map<String, String> params}) async{
    final resultRow = await PostgresHelp.conn!.execute(
        Sql.named(sql),
        parameters: params
      // sql
    );
    return resultRow;
  }

  @override
  Future<List<dynamic>> queryRow(String sql, {required Map<String, dynamic> params}) async{
    try {
      await PostgresHelp().init();
      final resultRow = await PostgresHelp.conn!.execute(
          Sql.named(sql),
          parameters: params
          // sql
      );
      await Future.delayed(Duration(seconds: 2));
      print(resultRow.first);
      return resultRow.first;
    }catch(e){
      print(e.toString());
      await Future.delayed(Duration(seconds: 10));

      return [];
    }
  }


}

