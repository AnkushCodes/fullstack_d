import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_proxy/shelf_proxy.dart';
import 'package:shelf_static/shelf_static.dart';




void main() async {
  final flutterWebDir = 'build/web'; 
  final apiUrl = 'http://backend:8086'; 

  final flutterWebHandler = createStaticHandler(
    flutterWebDir,
    defaultDocument: 'index.html', 
  );

 
  final apiProxyHandler = _proxyHandler(apiUrl, 'api');


  final handler = Cascade()
      .add(flutterWebHandler)
      .add(apiProxyHandler) 
      .handler;


  final pipeline = Pipeline().addMiddleware(logRequests()).addHandler(handler);

  
  final port = int.parse(Platform.environment['PORT'] ?? '8082');
  final server = await io.serve(pipeline, '0.0.0.0', port);
  print('Server running on port ${server.port}');
}

Handler _proxyHandler(String targetUrl, String pathPrefix) {
  return (Request request) {
    print("flag1 ${request.url.path} $pathPrefix ${request.url.path.startsWith(pathPrefix)}");
    if (request.url.path.startsWith(pathPrefix)) {
      print("flag2 request.url.path ${request.url.path}");
      // final updatedUrl = request.url.replace(
      //   pathSegments: request.url.pathSegments.skip(pathPrefix.split('/').length),
      // );
      //  print("flag3 updatedUrl $updatedUrl");
      final targetUri = Uri.parse(targetUrl);
      // resolveUri(updatedUrl);
       print("flag2 targetUri $targetUri");
      return proxyHandler(targetUri.toString())(request);
    }else{
      return Response.notFound('notfound \n');
    }

  };
}