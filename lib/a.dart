// import 'dart:io';

// import 'package:flutter/material.dart';

// class SharedPreferencesProvider {
//   static SharedPreferencesProvider? _instance;
//   final SharedPreferences _sharedPreferences;

//   static Future<SharedPreferencesProvider> getInstance() async {
//     if (_instance == null) {
//       final sharedPreferences = await SharedPreferences.getInstance();
//       _instance = SharedPreferencesProvider._(sharedPreferences);
//     }
//     return _instance!;
//   }

//   SharedPreferencesProvider._(SharedPreferences sharedPreferences)
//       : _sharedPreferences = sharedPreferences;
// }


// void main() => runApp(MaterialApp(home: Home()));

// class Home extends StatelessWidget {
//   TextEditingController myIp = TextEditingController()..text = '192.168.7.137';
//   late RawDatagramSocket udp;
//   TextStyle big = const TextStyle(fontSize: 30);
//   TextStyle mid = const TextStyle(fontSize: 25);

//   Home({super.key});

//   connect() async {
//     udp = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8000);
//   }

//   send(String data) {
//     udp.send(data.codeUnits, InternetAddress(myIp.text), 8000);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(35.0),
//               child: Text(
//                 'press connect, fill in ip address use fing app from google playstore to find ip address of rp2040 challenger wifi, led will blink on the pico while connecting and led will be steady on after successfully connecting, then press on/off',
//                 style: mid,
//               ),
//             ),
//             SizedBox(
//               width: 350,
//               child: TextField(
//                 style: big,
//                 controller: myIp,
//                 decoration: const InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       width: 3,
//                       color: Colors.greenAccent,
//                     ),
//                   ),
//                   labelText: 'ip address, use fing to find',
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () => connect(),
//               child: Text('connect', style: big),
//             ),
//             ElevatedButton(
//               onPressed: () => send('led on'),
//               child: Text('led on', style: big),
//             ),
//             ElevatedButton(
//               onPressed: () => send('led off'),
//               child: Text('led off', style: big),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
