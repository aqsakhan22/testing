// import 'package:flutter/material.dart';
//
// class CalenderEx extends StatefulWidget {
//   const CalenderEx({Key? key}) : super(key: key);
//
//   @override
//   State<CalenderEx> createState() => _CalenderExState();
// }
//
// class _CalenderExState extends State<CalenderEx> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     DateTime dt1 = DateTime.parse("2022-12-16 11:47:00");
//     DateTime dt2 = DateTime.parse("2022-12-17 10:09:00");
//
//     print("dt1 is greater or lesser  ${dt2.compareTo(dt1)}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           child: Text("Date Picker"),
//           onPressed: () async{
//             DateTime? pickedDate =
//                 await showDatePicker(
//
//                 builder: (context, child) {
//                   return Theme(
//                     data: Theme.of(context).copyWith(
//                         colorScheme: ColorScheme.light(
//                           primary: CustomColor.primary, // <-- SEE HERE
//                           onPrimary: Colors.white, // <-- SEE HERE
//                           onSurface: CustomColor.primary, // <-- SEE HERE
//                         ),
//                         textButtonTheme: TextButtonThemeData(
//                           style: TextButton.styleFrom(
//                             primary: CustomColor.primary, // button text color
//                           ),
//                         )
//
//                     ) ,
//                     child: child!,
//                   );
//
//                 },
//                 selectableDayPredicate: (DateTime val) =>
//                 val.day == DateTime.now().day - 1 ? false : true,
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime.now(),
//                 // DateTime.now() - not to allow to choose before today.
//                 lastDate: DateTime(2101));
//           },
//         ),
//       ),
//     );
//   }
// }
