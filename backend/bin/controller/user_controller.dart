

import 'dart:convert';

import '../../sqlgen/db.dart';
import '../../sqlgen/account.sql.dart';
import '../../sqlgen/accounts.g.dart';
import '../../bin/postgres_helper.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class UserController {
 String path = "/v1/customer";

createuser(Request request)async{
try{
  await PostgresHelp().init();
final String queryparam =await request.readAsString();
  Map val= jsonDecode(queryparam);
String owner =val['owner'];
int bal =int.parse(val['balance']);
String currency = val['currency'];
  CreateAccountParams createAccountParams = 
  CreateAccountParams(owner: owner, balance: bal, currency: currency);
  AccountOperation accountOperation =AccountOperation(Transaction() as DBTX);
  Accounts accounts = await  accountOperation.createAccount(createAccountParams);
return Response.ok("created ${accounts.toString()}");
}catch(e){
return Response.ok("...${request.requestedUri } ${e.toString()}");
}
}

  Handler get router{
final routers = Router();
routers.post("/createuser", createuser);
return routers;
  }
}