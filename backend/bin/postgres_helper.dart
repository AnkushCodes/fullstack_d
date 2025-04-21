
import 'package:postgres/postgres.dart';

import 'file_helper.dart';

class PostgresHelp{
  static Connection? conn;
  init() async{
    try {
      if(conn!=null) {

      }else{
      conn = await Connection.open(
        Endpoint(
            host: 'db',
            database: 'dbs',
            username: 'postgres',
            password: 'password',
            port: 5432
        ),
        // The postgres server hosted locally doesn't have SSL by default. If you're
        // accessing a postgres server over the Internet, the server should support
        // SSL and you should swap out the mode with `SslMode.verifyFull`.
        settings: ConnectionSettings(sslMode: SslMode.disable),
      );
      print('has connection!');
      }
    }catch(e){
      print(e);
    }
  }

  up(String file)async{
    List<String> val= await Filehelper().getListOffliner(file);
for(String exc in val){
  final result0 = await conn!.execute("""$exc""");
  print(result0);
}

  }

  down(String file)async{
    List<String> val= await Filehelper().getListOffliner(file);
    for(String exc in val){
      final result0 = await conn!.execute("""$exc""");
      print(result0);
    }

  }
  close()async {
    if(conn!=null)
    conn!.close();
  }
}