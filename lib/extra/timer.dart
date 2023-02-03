// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// class timerEx extends StatefulWidget {
//   const timerEx({Key? key}) : super(key: key);
//
//   @override
//   State<timerEx> createState() => _timerExState();
// }
//
// class _timerExState extends State<timerEx> {
//   String fromDate="Thu, Dec 8, 2022 2:41 PM";
//   String toDate="Thu, Dec 8, 2022 2:47 PM";
//    var dateArray;
//   void DateformatterChanger (){
//     //   String data=DateFormat('yyyy-MM-dd HH:mm aa').format(DateTime.now());
//     //    DateTime dt=   DateFormat('yyyy-MM-dd HH:mm aa').parse(data);
//     //   print("currentTime is ${dt}");
//
//     // print("current time is ${DateTime.now()} fromDate is ${e['fromDate']}  "
//     //     " ${DateFormat().parse(DateTime.now().toString()).compareTo(DateFormat('E, LLL d, y HH:mm aa').parse(e['fromDate']))}");
//     // print(" current time is  ${DateTime.now().compareTo(DateFormat('E, LLL d, y HH:mm a').parse(e['fromDate']))} jobStartTime ${e['fromDate']} durationstartTime ${e['jobDuration']} from Date  ${ DateformatterChanger(e['fromDate'])} toDate ${DateformatterChanger(e['toDate'])} BookOn ${e['deployment']['bookOn']}"); // 1 means job time not Live
//
//      setState(() {
//        dateArray=toDate.split(",");
//
//      });
//      print(" Thu -> DAY with name ${DateFormat('E').format(DateTime.now())}");
//      print(" Dec -> month with name ${DateFormat('LLL').format(DateTime.now())}");
//      print(" 8 -> DAY with number ${DateFormat('d').format(DateTime.now())}");
//      print(" 2022 -> year  ${DateFormat('y').format(DateTime.now())}");
//      print(" Time -> Time  ${DateFormat('HH:mm').format(DateTime.now())}");
//      print(" AM/PM -> Time  ${DateFormat('a').format(DateTime.now())}");
//      //Thu Dec 8 2022 4:44 PM
//   var exactdate="${dateArray[0]}${dateArray[1]}${dateArray[2]}";
//   print("exactdate ${exactdate}");
//    print("${DateFormat("E LLL d y HH:mm a").parse(exactdate)}");
//    print("current date  > fromdate ${DateTime.now().compareTo(DateFormat("E LLL d y HH:mm a").parse(exactdate)) } ${2 > 1}");
//      print("current date  > fromdate ${DateTime.now().compareTo(DateFormat("E LLL d y HH:mm a").parse("Thu Dec 8 2022 5:45 PM")) }"); //this retun -1 means curent date is not greater than that parse time
//
//    //if currentdate is higher then startdatetime
//    // print("dateArray is ${DateFormat('E LLL d y HH:mm a').format(DateTime.now())} ");
//    //  print("DateTime parsing ${DateFormat('E LLL d y HH:mm a').parse()}");
//
//
//
//
//
//   }
//   @override
//   // void dispose() {
//   //   // TODO: implement dispose
//   //   super.dispose();
//   //   countdownTimer!.cancel();
//   //
//   // }
//   Timer? countdownTimer;
//   static Duration myDuration = Duration(seconds: 55*60*60);
//   void startTimer() {
//     countdownTimer = Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
//     print("COUNTDOWN TIMER ${countdownTimer}");
//   }
//   void stopTimer() {
//     setState(() => countdownTimer!.cancel());
//   }
//   void resetTimer() {
//     stopTimer();
//     setState(() => myDuration = Duration(seconds: 55*60*60));
//   }
//   void setCountDown() {
//     final reduceSecondsBy = 1;
//
//     setState(() {
//       final seconds = myDuration.inSeconds - reduceSecondsBy;
//       print("myDuration in seconds ${myDuration.inSeconds} seconds ${seconds}");
//       if (seconds < 0) {
//         countdownTimer!.cancel();
//       } else {
//         myDuration = Duration(seconds: seconds);
//       }
//     });
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//    // DateformatterChanger();
//
//
//
// // startTimer();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     String strDigits(int n) => n.toString().padLeft(2, '0');
//     final days = strDigits(myDuration.inDays);
//     print("Days is ${days} ${int.parse(days) > 0}");
//
//     // Step 7
//     final hours = strDigits( myDuration.inDays > 0 ? (myDuration.inDays) * 24 +  myDuration.inHours.remainder(24) : myDuration.inHours.remainder(24));
//     final minutes = strDigits(myDuration.inMinutes.remainder(60));
//     final seconds = strDigits(myDuration.inSeconds.remainder(60));
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Timer"),
//       ),
//       body: Center(
//         child: Container(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Text("days is ${myDuration.inDays * 24} ${int.parse(days) > 0}"),
//               Text("Date changer"),
//               SizedBox(
//                 height: 20,
//               ),
//               Text("start Date is ${fromDate}"),
//               Text("start Date conversion ${fromDate}"),
//               Text("dateArray ${dateArray}"),
//
//               SizedBox(
//                 height: 20,
//               ),
//               // Text("end Date is ${toDate}"),
//               // Text("end Date conversion ${toDate}"),
//
//               SizedBox(
//                 height: 50,
//               ),
//               Container(
//                 width: 400,
//                 height: 400,
//
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.blueGrey[100]
//                 ),
//
//
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       '${days}: $hours:$minutes:$seconds',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           fontSize: 50),
//                     ),
//                     Text("00:00:00",style: TextStyle(fontSize: 24,color: Colors.red),),
//                     SizedBox(height: 10,),
//                     Text("Remaining Time"),
//                     SizedBox(height: 10,),
//                     Text("00:00:00",style: TextStyle(fontSize: 24,color: Colors.blue),),
//                     ElevatedButton(
//                       onPressed: startTimer,
//                       child: Text(
//                         'Start',
//                         style: TextStyle(
//                           fontSize: 30,
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (countdownTimer == null || countdownTimer!.isActive) {
//                           stopTimer();
//                         }
//                       },
//                       child: Text(
//                         'Stop',
//                         style: TextStyle(
//                           fontSize: 30,
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                         onPressed: () {
//                           resetTimer();
//                         },
//                         child: Text(
//                           'Reset',
//                           style: TextStyle(
//                             fontSize: 30,
//                           ),
//                         ))
//                   ],
//                 ),
//               ),
//             ],
//           )
//
//
//
//
//         ),
//       ),
//     );
//   }
// }
