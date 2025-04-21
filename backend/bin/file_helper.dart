

import 'dart:io';

class Filehelper{

  getListOffliner(String filepath) async{
    List<String> val=[];

    File file = File('${filepath}');
bool val2 =await file.exists();
    if(val2){
      final lines =file.readAsLinesSync();
      StringBuffer buffer = StringBuffer();

      for(final line in lines){
        // final parts =line.split("; ");
        // for(final part in parts){
        //   val.add(part.trim());
        // }
        buffer.write(line);
        if(line.contains(";")) {
          val.add(buffer.toString().trim());
          buffer.clear();
        }
      }
      file=File("");
    }else{
      print("file not found:${file.path}");
    }

return val;
  }
}