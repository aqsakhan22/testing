// import 'package:flutter/material.dart';
// import 'package:novus_guard_pro_flutter/services/background_service.dart';
// import 'package:novus_guard_pro_flutter/utility/top_level_variables.dart';
// class ServicesPractice extends StatefulWidget {
//   const ServicesPractice({Key? key}) : super(key: key);
//
//   @override
//   State<ServicesPractice> createState() => _ServicesPracticeState();
// }
//
// class _ServicesPracticeState extends State<ServicesPractice> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     WidgetsFlutterBinding.ensureInitialized();
//     TopVariables.service.startService().then((value) {
//       //Run After Service Start
//       print("Background Service Started In Foreground In Home");
//       TopVariables.service.on(actionStartBGServices);
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child:Row(children: [
//           ElevatedButton(onPressed:() async{
//             print("Invking start trip");
//
//             await initializeService().then((value) {
//               TopVariables.service
//                   .startService()
//                   .then((value) {
//                 //Run After Service Start
//                 print("Background Service Started In Foreground In Start_Run");
//                 TopVariables.service
//                     .invoke(startTripService, {
//                   "updateInterval": 5,
//                 });
//                 TopVariables.service
//                     .on(actionRunningProgress)
//                     .listen((event) {
//                   // Call Function
//                   print(
//                       "Update Run API Called In Frontend In Start_Run");
//                   // RunProvider().updateRun().then((value) {
//                   //   print(
//                   //       "Updating Map After Updating Data To Server");
//                   //   updateMap(value);
//                   // });
//                 });
//
//
//               });
//             });
//
//
//           }, child: Text("Start service")) ,
//           ElevatedButton(onPressed:(){
//             print("Invking stop trip");
//             TopVariables.service.invoke('stopService');
//
//           }, child: Text("stop service"))
//         ],),
//       ),
//     );
//   }
// }
