import 'dart:io';

import '../bin/postgres_helper.dart';

void main(List<String> args) async {
  await PostgresHelp().init();
  if(args.contains("up")){
    await PostgresHelp().up("migrate/sqlfileup.sql");
  }else if(args.contains("down")){
    await PostgresHelp().down("migrate/sqlfiledown.sql");
  }
  await PostgresHelp().close();
  exit(0);
}