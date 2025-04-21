
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:io';
import 'package:shelf/shelf_io.dart';
import 'controller/user_controller.dart';
// Configure routes.


Response _handleOptions(Request request) =>
    Response.ok('', headers: {'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Methods': 'POST, GET, OPTIONS', 'Access-Control-Allow-Headers': '*'});

Middleware corsHeaders() {
  return (Handler handler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return _handleOptions(request);
      }
      final response = await handler(request);
      return response.change(headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
        'Access-Control-Allow-Headers': '*',
      });
    };
  };
}

final _router = Router()

  ..get('/api/', _rootHandler)
  ..get('/api/echo/<message>', _echoHandler)
  ..mount('/api${UserController().path}',UserController().router);
Response _rootHandler(Request req) {
  return Response.ok('/api${UserController().path}');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  //  await PostgresHelp().init();

   // await PostgresHelp().down();
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
  
  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addMiddleware(corsHeaders()).addHandler(_router);
  
  // For running in containers, we respect the PORT environment variable.
  
  int port = 8086;
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
