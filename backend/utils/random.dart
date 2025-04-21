import 'dart:math';

const alphabet = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z"
];

const k = 26;

class RandomUtils {

  randomInt(int min, int max) {

    return min + Random().nextInt(max - min + 1);
  }

  String randomString(int n) {
    StringBuffer sb = StringBuffer();
    try {
      for (int i = 0; i < n; i++) {
        int i1 = Random().nextInt(k);
        String val = alphabet[i1];
        sb.write(val);
      }
    }catch(e){
      print(e);
    }
    return sb.toString();
  }

  String randomOwnerName(){
    return randomString(6);
  }

  int randomMoney(){
    return randomInt(0, 1000);
  }

  String randomCurrency(){

    List<String> currency =["EUR","USD","CAD"];
    int len = currency.length;
    return currency[Random().nextInt(len)];
  }
}
