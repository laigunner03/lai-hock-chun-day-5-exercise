import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:io';
void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');

//Call name, price, date from tick history (quote=> price)

  print("Please enter symbol ID:");
  var symbolID = stdin.readLineSync();

  channel.stream.listen((message) { 
    final decodedMessage = jsonDecode(message);

    //Symbol
    final symbol = decodedMessage['tick']['symbol'];    

    //Price
    final price = decodedMessage['tick']['quote'];   

    //Servertime
    final serverTime = decodedMessage['tick']['epoch'];
    final displayServerTime = DateTime.fromMillisecondsSinceEpoch(serverTime * 1000);


    //Print
    print("Symbol: $symbol");
    print("Price: $price");
    print("Time: $displayServerTime");
    //channel.sink.close();
  });

  channel.sink.add('{"ticks": "$symbolID",  "subscribe": 1}');
}
