// import 'dart:async';
// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:novus_guard_pro_flutter/ViewModel/get_deployment_view_model.dart';
// import 'package:novus_guard_pro_flutter/controllers/sos_controller.dart';
// import 'package:novus_guard_pro_flutter/dialog/error_dialog.dart';
// import 'package:novus_guard_pro_flutter/dialog/progress_dialog.dart';
// import 'package:novus_guard_pro_flutter/network/app_url.dart';
// import 'package:novus_guard_pro_flutter/network/response/general_response.dart';
// import 'package:novus_guard_pro_flutter/theme/color.dart';
// import 'package:novus_guard_pro_flutter/utility/current_location.dart';
// import 'package:novus_guard_pro_flutter/utility/shared_preference.dart';
// import 'package:novus_guard_pro_flutter/utility/sos_types_enum.dart';
// import 'package:novus_guard_pro_flutter/utility/top_level_variables.dart';
// import 'package:novus_guard_pro_flutter/widgets/button_widgets.dart';
// import 'package:novus_guard_pro_flutter/widgets/drawer_widget.dart';
// import 'package:novus_guard_pro_flutter/widgets/slider_button.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:provider/provider.dart';
// import 'package:signature/signature.dart';
// import 'package:slider_button/slider_button.dart';
// import 'package:video_player/video_player.dart';
//
// import '../widgets/app_bar.dart';
//
// class Deployment extends StatefulWidget {
//   const Deployment({Key? key}) : super(key: key);
//
//   @override
//   State<Deployment> createState() => _DeploymentState();
// }
//
// class _DeploymentState extends State<Deployment> {
//   late GetDeploymentJobs getJobs;
//   String code = "";
//   var jobType = "";
//   late TextEditingController textEditingController = TextEditingController(text: "");
//   bool hasError = false;
//   bool Incorrectcode = false;
//   bool dateConversion = false;
//   Timer? countdownTimer;
//   static Duration myDuration = const Duration(seconds: 0);
//   int extend_minutes = 0;
//   int extend_hours = 0;
//
//   // Reporting Feature Check
//   late TextEditingController _controller;
//   bool checkCall = false;
//   bool checkHighRisk = false;
//   bool? enableActive = UserPreferences.isSessionHighRisk;
//   int enableRisk = 0;
//   bool wearableenable = false;
//   bool gpslocationenable = true;
//   bool isInternetAvailable = false;
//   bool videoenable = false;
//   bool locationenable = false;
//   bool voicerecordenable = false;
//   bool documentenable = false;
//   bool notesenable = false;
//   bool isLoader = false;
//
//   // [REPORTING] Camera
//   bool cameraenable = false;
//   final ImagePicker _picker = ImagePicker();
//   XFile? image;
//   File? pickedImage;
//   bool isLoadingcamera = false;
//   Uint8List? cameraImage;
//
//   // [REPORTING] Video
//   XFile? pickedVideo;
//   late VideoPlayerController _videocontroller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool isLoadingvideo = false;
//
//   // [REPORTING] Loctaion
//   bool isLoadinglocation = false;
//   int locationSent = 0;
//   String lastSent = "";
//
//   // [REPORTING] Signature
//   File? theChosenImg;
//   Uint8List? uploadedImage;
//   final SignatureController signatureController = SignatureController(
//     penStrokeWidth: 5,
//     penColor: Colors.black,
//     exportBackgroundColor: Colors.white,
//   );
//
//   // [REPORTING] Document
//   bool isLoadingdocument = false;
//
//   // [REPORTING] Notes
//   bool isLoadingnotes = false;
//
//   // [REPORTING] Audio
//   final recorder = FlutterSoundRecorder();
//   bool isLoadingaudio = false;
//   bool isRecorderReady = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // String endDatePM="Tue, Dec 28, 2022 12:37 PM";
//     // String endDateAM="Tue, Dec 28, 2022 12:37 AM";
//     // print("PM CONVERSION ${DateTime.now().compareTo(DateFormat('E, LLL d, y HH:mm aa').parse(endDatePM))}");
//     // print("AM CONVERSION ${DateTime.now().compareTo(DateFormat('E, LLL d, y HH:mm aa').parse(endDateAM))}");
//     // print("CURRENT TIME IS format ${DateFormat('yyyy-dd-mm hh:mm:ss aa').format(DateTime.now())} ");
//     // print("CURRENT TIME IS parse ${DateFormat('yyyy-dd-mm hh:mm:ss aa').parse(DateFormat('yyyy-dd-mm hh:mm:ss aa').format(DateTime.now()))} ");
//     _controller = TextEditingController();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       getJobs.getDeploymentJobs().then((value) {
//         setState(() {
//           isLoader = true;
//         });
//         setTimerdata();
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     signatureController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     getJobs = Provider.of<GetDeploymentJobs>(context);
//     String strDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = strDigits(myDuration.inHours.remainder(24));
//     final minutes = strDigits(myDuration.inMinutes.remainder(60));
//     final seconds = strDigits(myDuration.inSeconds.remainder(60));
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       drawer: NavigationDrawer(),
//       appBar: AppBarWidget.getAppBar("Deployment"),
//       body: Container(child: Consumer<GetDeploymentJobs>(builder: (context, getallJobs, child) {
//         if (getallJobs.listOfJobs.isEmpty) {
//           child = Center(
//               child: Text(
//                 "No Job Available",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: CustomColor.primary, fontWeight: FontWeight.w500, fontSize: 18),
//               ));
//         } else {
//           child = Stack(
//             children: [
//               ListView.builder(
//                   shrinkWrap: false,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: getallJobs.listOfJobs.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return SingleChildScrollView(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                         child: Column(
//                           children: [
//                             //client
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                     child: Text(
//                                       "Client",
//                                       style: TextStyle(
//                                           color: CustomColor.primary, fontWeight: FontWeight.w600, fontSize: 16),
//                                     ),
//                                     flex: 2),
//                                 Expanded(
//                                   child: Text(
//                                     "${getallJobs.listOfJobs[index]['clientName']}",
//                                     style: TextStyle(color: Colors.black, fontSize: 14),
//                                   ),
//                                   flex: 8,
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             //site
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                     child: Text(
//                                       "Site ",
//                                       style: TextStyle(
//                                           color: CustomColor.primary, fontWeight: FontWeight.w600, fontSize: 16),
//                                     ),
//                                     flex: 2),
//                                 Expanded(
//                                   child: Text(
//                                     "${getallJobs.listOfJobs[index]['siteAddress']}",
//                                     style: TextStyle(color: Colors.black, fontSize: 14),
//                                   ),
//                                   flex: 8,
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             //address
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                     child: Text(
//                                       "Address",
//                                       style: TextStyle(
//                                           color: CustomColor.primary, fontWeight: FontWeight.w600, fontSize: 16),
//                                     ),
//                                     flex: 2),
//                                 Expanded(
//                                   child: Text(
//                                     "${getallJobs.listOfJobs[index]['siteAddress']}",
//                                     style: TextStyle(color: Colors.black, fontSize: 14),
//                                   ),
//                                   flex: 8,
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             //jobid
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                     child: Text(
//                                       "Job ID",
//                                       style: TextStyle(
//                                           color: CustomColor.primary, fontWeight: FontWeight.w600, fontSize: 16),
//                                     ),
//                                     flex: 2),
//                                 Expanded(
//                                   child: Text(
//                                     "${getallJobs.listOfJobs[index]['jobId']}",
//                                     style: TextStyle(color: Colors.black, fontSize: 14),
//                                   ),
//                                   flex: 8,
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             //Start and End Time
//                             Container(
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5.0),
//                                     side: BorderSide(color: Colors.black, width: 0.5)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     //Start and End Time
//                                     //left part
//
//                                     Container(
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 10,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Start",
//                                             style: TextStyle(
//                                                 color: CustomColor.primary, fontWeight: FontWeight.w600, fontSize: 16),
//                                           ),
//                                           Text(
//                                             "${getallJobs.listOfJobs[index]['fromDate']}",
//                                             style: TextStyle(color: CustomColor.primary, fontSize: 14),
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Text(
//                                             "End",
//                                             style: TextStyle(
//                                                 color: CustomColor.primary, fontWeight: FontWeight.w600, fontSize: 16),
//                                           ),
//                                           Text(
//                                             "${getallJobs.listOfJobs[index]['toDate']}",
//                                             style: TextStyle(color: CustomColor.primary, fontSize: 14),
//                                           )
//                                         ],
//                                       ),
//                                     ), //right part
//                                     Padding(
//                                       padding: EdgeInsets.symmetric(horizontal: 10),
//                                       child: Container(
//                                           height: 140,
//                                           width: 120,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             border: Border.all(color: CustomColor.orangeColor, width: 2.5),
//                                           ),
//                                           child: Stack(
//                                             children: [
//                                               Positioned(
//                                                   top: 20,
//                                                   left: 10,
//                                                   right: 10,
//
//                                                   // height: 70,
//                                                   // width: 120,
//                                                   // alignment: Alignment.center,
//                                                   // color:Colors.blue,
//                                                   child: Container(
//                                                       alignment: Alignment.center,
//                                                       padding: EdgeInsets.symmetric(horizontal: 10),
//                                                       child: Column(
//                                                         children: [
//                                                           Text(
//                                                             "Total time",
//                                                             style:
//                                                             TextStyle(color: CustomColor.orangeColor, fontSize: 12),
//                                                           ),
//                                                           Text(
//                                                             "${getallJobs.listOfJobs[index]['jobDuration']}",
//                                                             style: TextStyle(
//                                                                 color: CustomColor.orangeColor,
//                                                                 fontWeight: FontWeight.bold),
//                                                           ),
//                                                           Divider(
//                                                             color: CustomColor.orangeColor,
//                                                           ),
//                                                           Text(
//                                                             "${DateformatterChanger(getallJobs.listOfJobs[index]['toDate']) == -1 ? "${hours}:${minutes}:${seconds}" : "00:00:00"}   ",
//                                                             textAlign: TextAlign.center,
//                                                             style: TextStyle(fontWeight: FontWeight.bold),
//                                                           ),
//                                                           Text(
//                                                             "Remaining",
//                                                           ),
//                                                         ],
//                                                       ))),
//                                               Positioned(
//                                                 right: 3,
//                                                 bottom: 3,
//                                                 child: InkWell(
//                                                   onTap: jobType == 'Live'
//                                                       ? () async {
//                                                     try {
//                                                       showDialog(
//                                                           context: context,
//                                                           builder: (BuildContextcontext) {
//                                                             return AlertDialog(
//                                                               contentPadding: EdgeInsets.symmetric(
//                                                                   horizontal: 20.0, vertical: 20.0),
//                                                               backgroundColor: Colors.white,
//                                                               shape: RoundedRectangleBorder(
//                                                                   borderRadius: BorderRadius.circular(10.0)),
//                                                               title: Container(
//                                                                   padding: const EdgeInsets.fromLTRB(
//                                                                       20.0, 10.0, 20.0, 10.0),
//                                                                   decoration: BoxDecoration(
//                                                                       color: CustomColor.primary,
//                                                                       borderRadius: BorderRadius.only(
//                                                                           topRight: Radius.circular(10.0),
//                                                                           topLeft: Radius.circular(10.0))),
//                                                                   child: Text(
//                                                                     "Extend Job",
//                                                                     style: TextStyle(
//                                                                         color: CustomColor.white, fontSize: 12),
//                                                                   )),
//                                                               content: Container(
//                                                                 width: size.width * 1,
//                                                                 child: Row(
//                                                                   children: [
//                                                                     Expanded(
//                                                                       child: TextFormField(
//                                                                         onChanged: (String value) {
//                                                                           extend_hours = int.parse(value);
//                                                                         },
//                                                                         decoration: InputDecoration(
//                                                                             contentPadding: EdgeInsets.symmetric(
//                                                                                 horizontal: 10.0),
//                                                                             hintText: "Hours",
//                                                                             hintStyle: TextStyle(fontSize: 12),
//                                                                             border: OutlineInputBorder(
//                                                                               borderRadius:
//                                                                               new BorderRadius.circular(10.0),
//                                                                               borderSide: new BorderSide(
//                                                                                   color: Colors.black),
//                                                                             )),
//                                                                       ),
//                                                                     ),
//                                                                     SizedBox(
//                                                                       width: 10,
//                                                                     ),
//                                                                     Expanded(
//                                                                       child: TextFormField(
//                                                                         onChanged: (String value) {
//                                                                           extend_minutes = int.parse(value);
//                                                                         },
//                                                                         decoration: InputDecoration(
//                                                                             contentPadding: EdgeInsets.symmetric(
//                                                                                 horizontal: 10.0),
//                                                                             hintText: "Minutes",
//                                                                             hintStyle: TextStyle(fontSize: 12),
//                                                                             border: OutlineInputBorder(
//                                                                               borderRadius:
//                                                                               new BorderRadius.circular(10.0),
//                                                                               borderSide: new BorderSide(
//                                                                                   color: Colors.black),
//                                                                             )),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               actions: [
//                                                                 Row(
//                                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                                   children: [
//                                                                     ButtonWidget(
//                                                                         btnWidth: 100,
//                                                                         btnColor: Colors.grey[400],
//                                                                         textColor: Colors.white,
//                                                                         onPressed: () {
//                                                                           Navigator.pop(context);
//                                                                         },
//                                                                         text: "Cancel"),
//                                                                     SizedBox(
//                                                                       width: 10,
//                                                                     ),
//                                                                     ButtonWidget(
//                                                                         btnWidth: 100,
//                                                                         textColor: Colors.white,
//                                                                         btnColor: CustomColor.primary,
//                                                                         onPressed: () async {
//                                                                           try {
//                                                                             CurrentLocation()
//                                                                                 .getCurrentLocation()
//                                                                                 .then((value) async {
//                                                                               final reqBody = {
//                                                                                 "organisation_id":
//                                                                                 "${UserPreferences.OrganizationId.toString()}",
//                                                                                 "jobId":
//                                                                                 "${getallJobs.listOfJobs[index]['jobId']}",
//                                                                                 "minutes":
//                                                                                 "${(extend_hours + extend_minutes).toString()}",
//                                                                                 "lat":
//                                                                                 "${value!.latitude.toString()}",
//                                                                                 "lng":
//                                                                                 "${value.longitude.toString()}"
//                                                                               };
//                                                                               print(
//                                                                                   "reqbody of extend session is ${reqBody} ");
//                                                                               GeneralResponse response =
//                                                                               await AppUrl.apiService
//                                                                                   .extendSession(reqBody);
//
//                                                                               if (response.error == 0) {
//                                                                                 TopFunctions.showScaffold(
//                                                                                     "${response.message}");
//                                                                                 int timeInSec =
//                                                                                     (extend_hours * 60 * 60) +
//                                                                                         (extend_minutes * 60);
//                                                                                 myDuration = Duration(
//                                                                                     seconds:
//                                                                                     myDuration.inSeconds +
//                                                                                         timeInSec);
//                                                                                 getallJobs.getDeploymentJobs();
//                                                                                 getallJobs.notifyListeners();
//                                                                                 Navigator.pop(context);
//                                                                               }
//                                                                             });
//                                                                           } catch (e) {
//                                                                             print("EXCEPTION IS ${e}");
//                                                                           }
//                                                                         },
//                                                                         text: "OK")
//                                                                   ],
//                                                                 )
//                                                               ],
//                                                             );
//                                                           });
//                                                     } catch (e) {
//                                                       print("EXCEPTION IN EXTEND JOB ${e}");
//                                                     }
//                                                   }
//                                                       : () {
//                                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                                         content:
//                                                         Text("Extend job is not applicable on Past job")));
//                                                   },
//                                                   child: Container(
//                                                     // alignment: Alignment.bottomRight,
//                                                       decoration: BoxDecoration(
//                                                           shape: BoxShape.circle,
//                                                           color: CustomColor.white,
//                                                           border: Border.all(color: CustomColor.orangeColor)),
//                                                       padding: EdgeInsets.all(10.0),
//                                                       child: Text("+")),
//                                                 ),
//                                               ),
//                                             ],
//                                           )),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             //slide to activate SOS
//                             //trip
//                             getallJobs.listOfJobs[index]['jobStatus'] == "4"
//                                 ? Container(
//                                 width: size.width * 1,
//                                 // padding: EdgeInsets.only(left: 10.0,right:10.0),
//                                 child: SliderButtonWidget(
//                                   backColor: CustomColor.subBtn,
//                                   onPressed: () {
//                                     SosController().raiseSOS(SosType.manual);
//                                     setState(() {});
//                                   },
//                                   lableText: "Slide to Start SOS",
//                                   image: Image.asset("assets/SOSIcon.png"),
//                                 ))
//                                 : SizedBox(),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             getallJobs.listOfJobs[index]['jobStatus'] == "4"
//                                 ? //slide to bOOK OFF via NFC
//                             Container(
//                                 width: size.width * 1,
//
//                                 // padding: EdgeInsets.only(left: 10.0,right:10.0),
//                                 child: SliderButtonWidget(
//                                   backColor: CustomColor.secondary,
//                                   onPressed: () {
//                                     setState(() {});
//                                   },
//                                   lableText: "Slide to Book OFF Via NFC",
//                                   image: Image.asset("assets/nfc.png"),
//                                 ))
//                                 : SizedBox(),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             //slide to bOOK OFF
//                             getallJobs.listOfJobs[index]['jobStatus'] == "4"
//                                 ? Container(
//                               width: size.width * 1,
//                               key: UniqueKey(),
//                               child: SliderButton(
//                                 dismissible: false,
//                                 action: () {
//                                   setState(() {});
//
//                                   showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           // key: UniqueKey(),
//                                             backgroundColor: Colors.white,
//                                             contentPadding: EdgeInsets.zero,
//                                             shape:
//                                             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                                             // insetPadding: EdgeInsets.all(10.0),
//                                             content: StatefulBuilder(
//                                               builder: (BuildContext context, StateSetter setState) {
//                                                 return Container(
//                                                   width: MediaQuery.of(context).size.width *
//                                                       1, // height: MediaQuery.of(context).size.height * 0.3,
//                                                   child: Column(
//                                                     mainAxisSize: MainAxisSize.min,
//                                                     children: [
//                                                       Container(
//                                                         width: MediaQuery.of(context).size.width * 1,
//                                                         padding:
//                                                         const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                                                         decoration: BoxDecoration(
//                                                           borderRadius: BorderRadius.only(
//                                                               topRight: Radius.circular(10.0),
//                                                               topLeft: Radius.circular(10.0)),
//                                                           color: CustomColor.primary,
//                                                         ),
//                                                         child: Text(
//                                                           "Enter Pin Code",
//                                                           textAlign: TextAlign.center,
//                                                           style:
//                                                           TextStyle(color: CustomColor.white, fontSize: 16),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       Image.asset(
//                                                         "assets/lock.png",
//                                                         width: 52,
//                                                       ),
//                                                       SizedBox(
//                                                         height: 15,
//                                                       ),
//                                                       Text(
//                                                         "Enter PIN",
//                                                         style: TextStyle(
//                                                             color: CustomColor.primary,
//                                                             fontWeight: FontWeight.w400),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       Container(
//                                                         padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
//                                                         child: PinCodeTextField(
//                                                           autoDisposeControllers: false,
//                                                           appContext: context,
//                                                           pastedTextStyle: TextStyle(
//                                                             // color: Colors.green.shade600,
//                                                             fontWeight: FontWeight.bold,
//                                                           ),
//                                                           length: 4,
//                                                           obscureText: false,
//                                                           obscuringCharacter: '*',
//                                                           animationType: AnimationType.fade,
//                                                           validator: (v) {
//                                                             if (v!.length < 3) {
//                                                               return "Enter 4 digits code";
//                                                             } else {
//                                                               return null;
//                                                             }
//                                                           },
//                                                           pinTheme: PinTheme(
//                                                               shape: PinCodeFieldShape.box,
//                                                               borderRadius: BorderRadius.circular(5),
//                                                               fieldHeight: 45,
//                                                               fieldWidth: 60,
//                                                               activeFillColor:
//                                                               hasError ? CustomColor.primary : Colors.white,
//                                                               //  inactiveColor:Colors.amberAccent //border of text field
//                                                               inactiveFillColor: Colors.white,
//                                                               inactiveColor: Colors.grey[500],
//                                                               selectedFillColor: CustomColor.fadeColor,
//                                                               selectedColor: CustomColor.primary),
//                                                           cursorColor: Colors.black,
//                                                           animationDuration: Duration(milliseconds: 300),
//                                                           textStyle: TextStyle(fontSize: 20, height: 1.6),
//                                                           backgroundColor: Colors.transparent,
//                                                           enableActiveFill: true,
//                                                           // errorAnimationController: errorController,
//                                                           controller: textEditingController
//                                                           // == null
//                                                           // ? TextEditingController(text: "hell")
//                                                           // : TextEditingController(text: "")
//                                                           ,
//                                                           keyboardType: TextInputType.number,
//                                                           onCompleted: (v) {
//                                                             setState(() {
//                                                               code = v;
//                                                             });
//                                                           },
//
//                                                           onChanged: (value) {},
//                                                           beforeTextPaste: (text) {
//                                                             //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                                                             //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                                                             return true;
//                                                           },
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         " ${Incorrectcode == true ? "Enter correct Pin Code" : ""} ",
//                                                         style: TextStyle(color: CustomColor.subBtn),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       Container(
//                                                         child: ButtonWidget(
//                                                             btnWidth: MediaQuery.of(context).size.width * 0.7,
//                                                             btnHeight: 40,
//                                                             textColor: CustomColor.white,
//                                                             btnColor: CustomColor.secondary,
//                                                             onPressed: () {
//                                                               setState(() {});
//                                                               if (code == UserPreferences.get_Login()['safe_pin']) {
//                                                                 setState(() {});
//                                                                 Navigator.pop(context);
//                                                                 setState(() {
//                                                                   Incorrectcode = false;
//                                                                   myDuration = Duration(seconds: 0);
//                                                                   textEditingController.text = "";
//                                                                 });
//                                                                 setState(() {
//                                                                   isLoader = true;
//                                                                 });
//                                                                 CurrentLocation()
//                                                                     .getCurrentLocation()
//                                                                     .then((value) {
//                                                                   getallJobs
//                                                                       .endSession(
//                                                                       getallJobs.listOfJobs[index]['jobId'],
//                                                                       "2",
//                                                                       value!.latitude.toString(),
//                                                                       value.longitude.toString())
//                                                                       .then((value) {
//                                                                     if (value == 0) {
//                                                                       setState(() {
//                                                                         isLoader = false;
//                                                                       });
//                                                                     } else {
//                                                                       setState(() {
//                                                                         isLoader = false;
//                                                                       });
//                                                                     }
//                                                                   });
//
//                                                                   ;
//                                                                 });
//                                                               } else {
//                                                                 setState(() {});
//
//                                                                 setState(() {
//                                                                   Incorrectcode = true;
//                                                                 });
//                                                               }
//                                                             },
//                                                             text: "Proceed"),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 15,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                             ));
//                                       });
//                                 },
//                                 label: Text(
//                                   "Slide to Book OFF",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(color: Colors.white, fontSize: 14),
//                                 ),
//                                 icon: Image.asset("assets/SlideToBook.png"),
//                                 buttonColor: CustomColor.white,
//                                 buttonSize: 40.0,
//                                 shimmer: false,
//                                 width: size.width * 0.9,
//                                 height: size.width * 0.12,
//                                 alignLabel: Alignment.center,
//                                 backgroundColor: CustomColor.secondary,
//                                 vibrationFlag: true,
//                                 // dismissThresholds:0.45
//                               ),
//                             )
//                                 : SizedBox(),
//                             getallJobs.listOfJobs[index]['jobStatus'] == "3"
//                                 ? Container(
//                                 width: size.width * 1,
//
//                                 // padding: EdgeInsets.only(left: 10.0,right:10.0),
//                                 child: SliderButtonWidget(
//                                   backColor: CustomColor.secondary,
//                                   onPressed: () {},
//                                   lableText: "Slide to Book ON",
//                                   image: Image.asset("assets/SlideToBook.png"),
//                                 ))
//                                 : SizedBox(),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             //WIFI GPS WATCH HIGH RISK
//                             jobType == "Live"
//                                 ? Row(
//                               children: [
//                                 //check call
//                                 Expanded(
//                                     flex: 2,
//                                     child: Container(
//                                         height: 50,
//                                         padding: EdgeInsets.symmetric(vertical: 5),
//                                         margin: EdgeInsets.only(left: 5),
//                                         decoration: BoxDecoration(
//                                             color: CustomColor.notificationMessageColor,
//                                             borderRadius: BorderRadius.circular(10.0)),
//
//                                         // width: 100,
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Image.asset(
//                                               "assets/missed_check.png",
//                                               width: 24,
//                                             ),
//                                             Text(
//                                               "0/0",
//                                               style: TextStyle(color: Colors.white, fontSize: 14),
//                                             )
//                                           ],
//                                         ))),
//
//                                 //high risk
//                                 // jobType == "Live" &&  isInternetAvailable == true ?
//
//                                 jobType == 'Live' && isInternetAvailable == true
//                                     ? Expanded(
//                                     child: IconButton(
//                                       padding: EdgeInsets.zero,
//                                       onPressed: () {
//                                         _highRiskConfirmation(context, getallJobs.listOfJobs[index]['jobId']);
//                                       },
//                                       icon: enableActive == true
//                                           ? Image.asset("assets/high_risk_color.png")
//                                           : Image.asset("assets/high_risk.png"),
//                                     ))
//                                     : Expanded(
//                                     child: IconButton(
//                                       padding: EdgeInsets.zero,
//                                       onPressed: () {
//                                         showErrorDialog("Job is not Live");
//                                       },
//                                       icon: Image.asset("assets/high_risk.png"),
//                                     )),
//
//                                 //Smart watch
//                                 Expanded(
//                                     child: IconButton(
//                                       padding: EdgeInsets.zero,
//                                       onPressed: () {},
//                                       icon: Image.asset("assets/MicrosoftTeams-grey-image.png"),
//                                     )), //gps
//                                 Expanded(
//                                     child: IconButton(
//                                       padding: EdgeInsets.zero,
//                                       onPressed: () {
//                                         gps_reporting(context);
//                                       },
//                                       icon: Image.asset("assets/gps-color.png"),
//                                     )),
//
//                                 //wifi
//                                 FutureBuilder<bool>(
//                                     future: TopFunctions.internetConnectivityStatus(),
//                                     builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
//                                       if (snapchat.hasData) {
//                                         if (snapchat.data == true) {
//                                           isInternetAvailable = true;
//                                           // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  setState(() {
//                                           //   isInternetAvailable=true;
//                                           // });});
//                                         } else {
//                                           isInternetAvailable = false;
//                                           // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  setState(() {
//                                           //   isInternetAvailable=false;
//                                           // });});
//                                         }
//                                         return snapchat.data == true
//                                             ? Expanded(
//                                             child: IconButton(
//                                               padding: EdgeInsets.zero,
//                                               onPressed: () {},
//                                               icon: Image.asset("assets/wifi_color.png"),
//                                             ))
//                                             : Expanded(
//                                             child: IconButton(
//                                               padding: EdgeInsets.zero,
//                                               onPressed: () {},
//                                               icon: Image.asset("assets/wifi-grey-color.png"),
//                                             ));
//                                       } else {
//                                         return Expanded(
//                                             child: IconButton(
//                                               padding: EdgeInsets.zero,
//                                               onPressed: () {},
//                                               icon: Image.asset("assets/wifi-grey-color.png"),
//                                             ));
//                                       }
//                                     }),
//                               ],
//                             )
//                                 : SizedBox(),
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                             //camera
//                             jobType == "Live" && isInternetAvailable == true
//                                 ? Row(
//                               children: [
//                                 //camera
//                                 Expanded(
//                                   child: IconButton(
//                                     padding: EdgeInsets.zero,
//                                     onPressed: () {
//                                       capture_Image(context, getallJobs.listOfJobs[index]['jobId']);
//                                     },
//                                     icon: Image.asset("assets/image_color.png"),
//                                   ),
//                                 ), //video
//                                 Expanded(
//                                   child: IconButton(
//                                     padding: EdgeInsets.zero,
//                                     onPressed: () {
//                                       record_video(context, getallJobs.listOfJobs[index]['jobId']);
//                                     },
//                                     icon: Image.asset("assets/movie_color.png"),
//                                   ),
//                                 ),
//
//                                 //location
//                                 Expanded(
//                                     child: isLoadinglocation == false
//                                         ? IconButton(
//                                       padding: EdgeInsets.zero,
//                                       onPressed: () {
//                                         setState(() {
//                                           isLoadinglocation = true;
//                                         });
//
//                                         logLocation(getallJobs.listOfJobs[index]['jobId']);
//                                       },
//                                       icon: Image.asset("assets/location_color.png"),
//                                     )
//                                         : Container(
//                                         padding: EdgeInsets.all(10.0),
//                                         child: CircularProgressIndicator(
//                                           color: CustomColor.primary,
//                                           strokeWidth: 1,
//                                         ))), //audio
//                                 Expanded(
//                                     child: IconButton(
//                                       padding: EdgeInsets.zero,
//                                       onPressed: () async {
//                                         await recorder.openRecorder();
//                                         isRecorderReady = true;
//                                         if (recorder.isRecording) {
//                                           setState(() {
//                                             recorder.isRecording != recorder.isRecording;
//                                           });
//                                           await stopRecording(getallJobs.listOfJobs[index]['jobId']);
//                                         } else {
//                                           setState(() {
//                                             recorder.isRecording != recorder.isRecording;
//                                           });
//                                           await startRecord();
//                                         }
//                                       },
//                                       icon: recorder.isRecording
//                                           ? Image.asset('assets/audiostop.png')
//                                           : Image.asset("assets/voice_color.png"),
//                                     )),
//
//                                 //document
//
//                                 Expanded(
//                                     child: isLoadingdocument == false
//                                         ? IconButton(
//                                       padding: EdgeInsets.zero,
//                                       onPressed: () {
//                                         document_reporting(context, getallJobs.listOfJobs[index]['jobId']);
//                                       },
//                                       icon: Image.asset("assets/document_color.png"),
//                                     )
//                                         : Container(
//                                         padding: EdgeInsets.all(10.0),
//                                         child: CircularProgressIndicator(
//                                           color: CustomColor.primary,
//                                           strokeWidth: 1,
//                                         ))),
//
//                                 //notes
//
//                                 Expanded(
//                                   child: IconButton(
//                                     padding: EdgeInsets.zero,
//                                     onPressed: () {
//                                       text_reporting(context, getallJobs.listOfJobs[index]['jobId']);
//                                     },
//                                     icon: Image.asset("assets/notes_color.png"),
//                                   ),
//                                 ),
//                               ],
//                             )
//                                 : SizedBox(),
//                             SizedBox(
//                               height: 10.0,
//                             ),
//                             //Task in progress ansd upcomming task
//                             // Container(
//                             //   margin: EdgeInsets.only(top: 10, bottom: 10),
//                             //   child: Column(
//                             //     crossAxisAlignment: CrossAxisAlignment.start,
//                             //     mainAxisAlignment: MainAxisAlignment.center,
//                             //     children: [
//                             //       Container(
//                             //           margin: EdgeInsets.only(top: 10, bottom: 10),
//                             //           alignment: Alignment.center,
//                             //           child: Text(
//                             //             "Task In-Progress",
//                             //             textAlign: TextAlign.center,
//                             //             style: TextStyle(
//                             //                 color: CustomColor.primary,
//                             //                 fontWeight: FontWeight.bold),
//                             //           )),
//                             //       Padding(
//                             //         padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             //         child: Container(
//                             //           padding: EdgeInsets.symmetric(
//                             //               horizontal: 10, vertical: 10),
//                             //           decoration: BoxDecoration(
//                             //               color: CustomColor
//                             //                   .notificationTabUnselectedTextColor,
//                             //               borderRadius: BorderRadius.circular(5.0)),
//                             //           child: Row(
//                             //             children: [
//                             //               Container(
//                             //                 padding: EdgeInsets.symmetric(
//                             //                     horizontal: 10, vertical: 5),
//                             //                 decoration: BoxDecoration(
//                             //                     color: CustomColor.orangeColor,
//                             //                     borderRadius:
//                             //                         BorderRadius.circular(5.0)),
//                             //                 child: Text("T1"),
//                             //               ),
//                             //               SizedBox(
//                             //                 width: 10,
//                             //               ),
//                             //               Text(
//                             //                 "This is just a task you dont need to worry",
//                             //                 style: TextStyle(
//                             //                     color: Colors.black, fontSize: 14),
//                             //               )
//                             //             ],
//                             //           ),
//                             //         ),
//                             //       ),
//                             //       Container(
//                             //           margin: EdgeInsets.only(top: 10, bottom: 10),
//                             //           alignment: Alignment.center,
//                             //           child: Text(
//                             //             "Upcomming Task",
//                             //             textAlign: TextAlign.center,
//                             //             style: TextStyle(
//                             //                 color: CustomColor.primary,
//                             //                 fontWeight: FontWeight.bold),
//                             //           )),
//                             //       Padding(
//                             //         padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             //         child: Container(
//                             //           padding: EdgeInsets.symmetric(
//                             //               horizontal: 10, vertical: 10),
//                             //           decoration: BoxDecoration(
//                             //               color: CustomColor
//                             //                   .notificationTabUnselectedTextColor,
//                             //               borderRadius: BorderRadius.circular(5.0)),
//                             //           child: Row(
//                             //             children: [
//                             //               Container(
//                             //                 padding: EdgeInsets.symmetric(
//                             //                     horizontal: 10, vertical: 5),
//                             //                 decoration: BoxDecoration(
//                             //                     color: CustomColor.orangeColor,
//                             //                     borderRadius:
//                             //                         BorderRadius.circular(5.0)),
//                             //                 child: Text("T1"),
//                             //               ),
//                             //               SizedBox(
//                             //                 width: 10,
//                             //               ),
//                             //               Text(
//                             //                 "This is just a task you dont need to worry",
//                             //                 style: TextStyle(
//                             //                     color: Colors.black, fontSize: 14),
//                             //               )
//                             //             ],
//                             //           ),
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//
//                             //Link a trip start petrol
//                             jobType == "Live" && isInternetAvailable == true
//                                 ? Row(
//                               //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Expanded(
//                                   child: ButtonWidget(
//                                       btnWidth: size.width * 0.4,
//                                       textColor: CustomColor.white,
//                                       btnColor: CustomColor.secondary,
//                                       onPressed: () {},
//                                       text: "Link a Trip"),
//                                 ),
//                                 SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 Expanded(
//                                   child: ButtonWidget(
//                                       btnWidth: size.width * 0.4,
//                                       textColor: CustomColor.white,
//                                       btnColor: CustomColor.notificationMessageColor,
//                                       onPressed: () {},
//                                       text: "Start Patrol"),
//                                 )
//                               ],
//                             )
//                                 : SizedBox(),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             //Reporting ans Task
//                             // Container(
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             //     children: [
//                             //       ButtonWidget(
//                             //           btnWidth: size.width * 0.4,
//                             //           textColor: CustomColor.white,
//                             //           btnColor: CustomColor.primary,
//                             //           onPressed: () {
//                             //             showModalBottomSheet<void>(
//                             //               context: context,
//                             //               builder: (BuildContext context) {
//                             //                 return Container(
//                             //                     height: 250,
//                             //                     padding: EdgeInsets.symmetric(
//                             //                         vertical: 10.0),
//                             //                     child: Column(
//                             //                       children: [
//                             //                         Text(
//                             //                           "Link A Trip",
//                             //                           style: TextStyle(
//                             //                               color: Colors.black,
//                             //                               fontWeight:
//                             //                                   FontWeight.bold,
//                             //                               fontSize: 16),
//                             //                         ),
//                             //                         SizedBox(
//                             //                           height: 10,
//                             //                         ),
//                             //                         Row(
//                             //                           children: [
//                             //                             //camera
//                             //                             Expanded(
//                             //                               child: IconButton(
//                             //                                 padding:
//                             //                                     EdgeInsets.zero,
//                             //                                 onPressed: () {},
//                             //                                 icon: Image.asset(
//                             //                                     "assets/image-grey-color.png"),
//                             //                               ),
//                             //                             ),
//                             //                             //video
//                             //                             Expanded(
//                             //                               child: IconButton(
//                             //                                 padding:
//                             //                                     EdgeInsets.zero,
//                             //                                 onPressed: () {},
//                             //                                 icon: Image.asset(
//                             //                                     "assets/movie-grey-color.png"),
//                             //                               ),
//                             //                             ),
//                             //                             //location
//                             //                             Expanded(
//                             //                                 child: IconButton(
//                             //                               padding: EdgeInsets.zero,
//                             //                               onPressed: () {},
//                             //                               icon: Image.asset(
//                             //                                   "assets/location.png"),
//                             //                             )),
//                             //                             //audio
//                             //                             Expanded(
//                             //                                 child: IconButton(
//                             //                               padding: EdgeInsets.zero,
//                             //                               onPressed: () {},
//                             //                               icon: Image.asset(
//                             //                                   "assets/voice-grey-color.png"),
//                             //                             )),
//                             //
//                             //                             //document
//                             //                             Expanded(
//                             //                                 child: IconButton(
//                             //                               padding: EdgeInsets.zero,
//                             //                               onPressed: () {},
//                             //                               icon: Image.asset(
//                             //                                   "assets/document-grey.png"),
//                             //                             )),
//                             //
//                             //                             //notes
//                             //
//                             //                             Expanded(
//                             //                               child: IconButton(
//                             //                                 padding:
//                             //                                     EdgeInsets.zero,
//                             //                                 onPressed: () {},
//                             //                                 icon: Image.asset(
//                             //                                     "assets/notes.png"),
//                             //                               ),
//                             //                             ),
//                             //                           ],
//                             //                         ),
//                             //                       ],
//                             //                     ));
//                             //               },
//                             //             );
//                             //           },
//                             //           text: "Reporting"),
//                             //       ButtonWidget(
//                             //           btnWidth: size.width * 0.4,
//                             //           textColor: CustomColor.white,
//                             //           btnColor: CustomColor.primary,
//                             //           onPressed: () {
//                             //             showModalBottomSheet<void>(
//                             //               backgroundColor: CustomColor.primary,
//                             //               context: context,
//                             //               builder: (BuildContext context) {
//                             //                 return Container(
//                             //
//                             //                     // height: 250,
//                             //
//                             //                     padding: EdgeInsets.symmetric(
//                             //                         vertical: 10.0),
//                             //                     child: ListView.separated(
//                             //                       separatorBuilder:
//                             //                           (context, index) => Divider(
//                             //                         color: Colors.white,
//                             //                       ),
//                             //                       itemCount: 10,
//                             //                       shrinkWrap: true,
//                             //                       itemBuilder:
//                             //                           (BuildContext context,
//                             //                               int index) {
//                             //                         return ExpansionTile(
//                             //                           tilePadding: EdgeInsets.zero,
//                             //
//                             //                           collapsedIconColor:
//                             //                               Colors.white,
//                             //                           iconColor: CustomColor.white,
//                             //
//                             //                           // leading: Icon(Icons.check,color: CustomColor.notificationTabUnselectedTextColor,),
//                             //                           title: Row(
//                             //                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //
//                             //                             children: [
//                             //                               Padding(
//                             //                                 padding:
//                             //                                     const EdgeInsets
//                             //                                         .only(left: 5),
//                             //                                 child: Icon(
//                             //                                   Icons.check,
//                             //                                   color: CustomColor
//                             //                                       .notificationTabUnselectedTextColor,
//                             //                                 ),
//                             //                               ),
//                             //                               SizedBox(
//                             //                                 width: 10,
//                             //                               ),
//                             //                               Container(
//                             //                                   padding: EdgeInsets
//                             //                                       .symmetric(
//                             //                                           vertical: 5,
//                             //                                           horizontal:
//                             //                                               10),
//                             //                                   decoration: BoxDecoration(
//                             //                                       color: CustomColor
//                             //                                           .orangeColor,
//                             //                                       borderRadius:
//                             //                                           BorderRadius
//                             //                                               .circular(
//                             //                                                   5.0)),
//                             //                                   child: Text(
//                             //                                     "T9",
//                             //                                     style: TextStyle(
//                             //                                         color:
//                             //                                             CustomColor
//                             //                                                 .white,
//                             //                                         fontSize: 16),
//                             //                                   )),
//                             //                               SizedBox(
//                             //                                 width: 5,
//                             //                               ),
//                             //                               Text(
//                             //                                 "Titkee",
//                             //                                 style: TextStyle(
//                             //                                     color: CustomColor
//                             //                                         .white,
//                             //                                     fontSize: 16),
//                             //                               ),
//                             //                               SizedBox(
//                             //                                 width: 15,
//                             //                               ),
//                             //                               Switch(
//                             //                                 value: true,
//                             //                                 onChanged:
//                             //                                     (bool value) {
//                             //                                   setState(() {});
//                             //                                 },
//                             //                                 activeTrackColor:
//                             //                                     CustomColor
//                             //                                         .secondary,
//                             //                                 activeColor: CustomColor
//                             //                                     .fadeColor,
//                             //                               ),
//                             //                               SizedBox(
//                             //                                 width: 5,
//                             //                               ),
//                             //                               Expanded(
//                             //                                 flex: 2,
//                             //                                 child: Column(
//                             //                                   children: [
//                             //                                     Text(
//                             //                                       "Start",
//                             //                                       style: TextStyle(
//                             //                                           fontSize: 10,
//                             //                                           color:
//                             //                                               CustomColor
//                             //                                                   .white),
//                             //                                     ),
//                             //                                     Text(
//                             //                                       "00:00:00",
//                             //                                       style: TextStyle(
//                             //                                           fontSize: 10,
//                             //                                           color:
//                             //                                               CustomColor
//                             //                                                   .white),
//                             //                                     ),
//                             //                                     Container(
//                             //                                         width: 60,
//                             //                                         child: Divider(
//                             //                                           color:
//                             //                                               CustomColor
//                             //                                                   .white,
//                             //                                           thickness:
//                             //                                               1.0,
//                             //                                         )),
//                             //                                     Text(
//                             //                                       "End",
//                             //                                       style: TextStyle(
//                             //                                           fontSize: 10,
//                             //                                           color:
//                             //                                               CustomColor
//                             //                                                   .white),
//                             //                                     ),
//                             //                                     Text(
//                             //                                       "00:00:00",
//                             //                                       style: TextStyle(
//                             //                                           fontSize: 10,
//                             //                                           color:
//                             //                                               CustomColor
//                             //                                                   .white),
//                             //                                     ),
//                             //                                   ],
//                             //                                 ),
//                             //                               ),
//                             //                               Expanded(
//                             //                                   flex: 2,
//                             //                                   child: Column(
//                             //                                     children: [
//                             //                                       Text(
//                             //                                         "Actual End",
//                             //                                         style: TextStyle(
//                             //                                             fontSize:
//                             //                                                 10,
//                             //                                             color: CustomColor
//                             //                                                 .white),
//                             //                                       ),
//                             //                                       Text(
//                             //                                         "00:00:00",
//                             //                                         style: TextStyle(
//                             //                                             fontSize:
//                             //                                                 10,
//                             //                                             color: CustomColor
//                             //                                                 .white),
//                             //                                       ),
//                             //                                       Container(
//                             //                                           width: 60,
//                             //                                           child:
//                             //                                               Divider(
//                             //                                             color: CustomColor
//                             //                                                 .white,
//                             //                                             thickness:
//                             //                                                 1.0,
//                             //                                           )),
//                             //                                       Text(
//                             //                                         "Actual Start",
//                             //                                         style: TextStyle(
//                             //                                             fontSize:
//                             //                                                 10,
//                             //                                             color: CustomColor
//                             //                                                 .white),
//                             //                                       ),
//                             //                                       Text(
//                             //                                         "00:00:00",
//                             //                                         style: TextStyle(
//                             //                                             fontSize:
//                             //                                                 10,
//                             //                                             color: CustomColor
//                             //                                                 .white),
//                             //                                       ),
//                             //                                     ],
//                             //                                   ))
//                             //                             ],
//                             //                           ),
//                             //
//                             //                           children: <Widget>[
//                             //                             ListView.separated(
//                             //                               separatorBuilder:
//                             //                                   (context, index) =>
//                             //                                       Divider(
//                             //                                 color: Colors.white,
//                             //                               ),
//                             //                               shrinkWrap: true,
//                             //                               itemCount: 3,
//                             //                               itemBuilder:
//                             //                                   (BuildContext context,
//                             //                                       int index) {
//                             //                                 return Row(
//                             //                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //
//                             //                                   children: [
//                             //                                     Padding(
//                             //                                       padding:
//                             //                                           const EdgeInsets
//                             //                                                   .only(
//                             //                                               left: 5),
//                             //                                       child: Icon(
//                             //                                         Icons.check,
//                             //                                         color: CustomColor
//                             //                                             .notificationTabUnselectedTextColor,
//                             //                                       ),
//                             //                                     ),
//                             //                                     SizedBox(
//                             //                                       width: 10,
//                             //                                     ),
//                             //                                     Container(
//                             //                                         padding: EdgeInsets
//                             //                                             .symmetric(
//                             //                                                 vertical:
//                             //                                                     5,
//                             //                                                 horizontal:
//                             //                                                     10),
//                             //                                         decoration: BoxDecoration(
//                             //                                             color: CustomColor
//                             //                                                 .orangeColor,
//                             //                                             borderRadius:
//                             //                                                 BorderRadius.circular(
//                             //                                                     5.0)),
//                             //                                         child: Text(
//                             //                                           "T9",
//                             //                                           style: TextStyle(
//                             //                                               color: CustomColor
//                             //                                                   .white,
//                             //                                               fontSize:
//                             //                                                   16),
//                             //                                         )),
//                             //                                     SizedBox(
//                             //                                       width: 5,
//                             //                                     ),
//                             //                                     Container(
//                             //                                         padding: EdgeInsets
//                             //                                             .symmetric(
//                             //                                                 vertical:
//                             //                                                     5,
//                             //                                                 horizontal:
//                             //                                                     10),
//                             //                                         decoration: BoxDecoration(
//                             //                                             color: CustomColor
//                             //                                                 .orangeColor,
//                             //                                             borderRadius:
//                             //                                                 BorderRadius.circular(
//                             //                                                     5.0)),
//                             //                                         child: Text(
//                             //                                           "T9",
//                             //                                           style: TextStyle(
//                             //                                               color: CustomColor
//                             //                                                   .white,
//                             //                                               fontSize:
//                             //                                                   16),
//                             //                                         )),
//                             //                                     SizedBox(
//                             //                                       width: 5,
//                             //                                     ),
//                             //                                     Text(
//                             //                                       "this is ${index}",
//                             //                                       style: TextStyle(
//                             //                                           color:
//                             //                                               CustomColor
//                             //                                                   .white,
//                             //                                           fontSize: 16),
//                             //                                     ),
//                             //                                     SizedBox(
//                             //                                       width: 15,
//                             //                                     ),
//                             //                                     Switch(
//                             //                                       value: true,
//                             //                                       onChanged:
//                             //                                           (bool value) {
//                             //                                         setState(() {});
//                             //                                       },
//                             //                                       activeTrackColor:
//                             //                                           CustomColor
//                             //                                               .secondary,
//                             //                                       activeColor:
//                             //                                           CustomColor
//                             //                                               .fadeColor,
//                             //                                     ),
//                             //                                     SizedBox(
//                             //                                       width: 5,
//                             //                                     ),
//                             //                                     Column(
//                             //                                       children: [
//                             //                                         Text(
//                             //                                           "Start",
//                             //                                           style: TextStyle(
//                             //                                               fontSize:
//                             //                                                   10,
//                             //                                               color: CustomColor
//                             //                                                   .white),
//                             //                                         ),
//                             //                                         Text(
//                             //                                           "00:00:00",
//                             //                                           style: TextStyle(
//                             //                                               fontSize:
//                             //                                                   10,
//                             //                                               color: CustomColor
//                             //                                                   .white),
//                             //                                         ),
//                             //                                         Container(
//                             //                                             width: 60,
//                             //                                             child:
//                             //                                                 Divider(
//                             //                                               color: CustomColor
//                             //                                                   .white,
//                             //                                               thickness:
//                             //                                                   1.0,
//                             //                                             )),
//                             //                                         Text(
//                             //                                           "End",
//                             //                                           style: TextStyle(
//                             //                                               fontSize:
//                             //                                                   10,
//                             //                                               color: CustomColor
//                             //                                                   .white),
//                             //                                         ),
//                             //                                         Text(
//                             //                                           "00:00:00",
//                             //                                           style: TextStyle(
//                             //                                               fontSize:
//                             //                                                   10,
//                             //                                               color: CustomColor
//                             //                                                   .white),
//                             //                                         ),
//                             //                                       ],
//                             //                                     ),
//                             //                                     SizedBox(
//                             //                                       width: 10,
//                             //                                     ),
//                             //                                     Column(
//                             //                                       children: [
//                             //                                         Text(
//                             //                                           "Actual End",
//                             //                                           style: TextStyle(
//                             //                                               fontSize:
//                             //                                                   10,
//                             //                                               color: CustomColor
//                             //                                                   .white),
//                             //                                         ),
//                             //                                         Text(
//                             //                                           "00:00:00",
//                             //                                           style: TextStyle(
//                             //                                               fontSize:
//                             //                                                   10,
//                             //                                               color: CustomColor
//                             //                                                   .white),
//                             //                                         ),
//                             //                                         Container(
//                             //                                             width: 60,
//                             //                                             child:
//                             //                                                 Divider(
//                             //                                               color: CustomColor
//                             //                                                   .white,
//                             //                                               thickness:
//                             //                                                   1.0,
//                             //                                             )),
//                             //                                         Text(
//                             //                                           "Actual Start",
//                             //                                           style: TextStyle(
//                             //                                               fontSize:
//                             //                                                   10,
//                             //                                               color: CustomColor
//                             //                                                   .white),
//                             //                                         ),
//                             //                                         Text(
//                             //                                           "00:00:00",
//                             //                                           style: TextStyle(
//                             //                                               fontSize:
//                             //                                                   10,
//                             //                                               color: CustomColor
//                             //                                                   .white),
//                             //                                         ),
//                             //                                       ],
//                             //                                     )
//                             //                                   ],
//                             //                                 );
//                             //                               },
//                             //                             )
//                             //                           ],
//                             //                         );
//                             //                       },
//                             //                     ));
//                             //               },
//                             //             );
//                             //           },
//                             //           text: "Task"),
//                             //     ],
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//               // TODO: Fix This Continuous Loading Bug
//               // isLoader == true
//               //     ? Center(
//               //   child: CircularProgressIndicator(
//               //     strokeWidth: 4,
//               //     color: CustomColor.primary,
//               //   ),
//               // )
//               //     : SizedBox()
//             ],
//           );
//         }
//         return child;
//       })),
//     );
//   }
//
//   int differenceTime(String endTime) {
//     DateTime toDate = DateFormat('E, LLL d, y HH:mm').parse(endTime);
//     int difference = 0;
//     if (DateTime.now().compareTo(toDate) < 0) {
//       difference = DateTime.now().difference(toDate).inSeconds;
//       return difference;
//     }
//     return difference;
//   }
//
//   int DateformatterChanger(String endDate) {
//     DateTime toDate;
//     if (endDate.contains("PM")) {
//       toDate = DateFormat('E, LLL d, y hh:mm aa').parse(endDate);
//     } else {
//       toDate = DateFormat('E, LLL d, y HH:mm aa').parse(endDate);
//     }
//     int comparision = DateTime.now().compareTo(toDate);
//     return comparision;
//   }
//
//   void setTimerdata() {
//     print("${getJobs.listOfJobs.map((e) {
//       if (e['deployment']['bookOn'] == 1 &&
//           DateformatterChanger(e['fromDate']) > 0 &&
//           DateformatterChanger(e['toDate']) < 0) {
//         setState(() {
//           jobType = 'Live';
//           isLoader = false;
//         });
//         if (jobType == 'Live') {
//           int _secStart1 = int.parse(e['jobDuration'].split(":")[0]) * 60 * 60;
//           int _secStart2 = int.parse(e['jobDuration'].split(":")[1]) * 60;
//           int startTimeInSec = _secStart1 + _secStart2;
//           if (myDuration.inSeconds == 0) {
//             myDuration = Duration(seconds: startTimeInSec); //00:05
//           } else {
//             myDuration = Duration(seconds: myDuration.inSeconds);
//           }
//           startTimer();
//         } else {
//           setState(() {
//             isLoader = false;
//           });
//         }
//       }
//     })} ");
//   }
//
//   void startTimer() {
//     countdownTimer = Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
//   }
//
//   void stopTimer() {
//     setState(() => countdownTimer!.cancel());
//   }
//
//   void resetTimer() {
//     stopTimer();
//     setState(() => myDuration = Duration(seconds: 0));
//   }
//
//   void setCountDown() {
//     final reduceSecondsBy = 1;
//     setState(() {
//       final seconds = myDuration.inSeconds - reduceSecondsBy;
//       if (seconds < 0) {
//         countdownTimer!.cancel();
//         myDuration = Duration(seconds: 0);
//         setState(() {
//           jobType = 'Past';
//         });
//       } else {
//         myDuration = Duration(seconds: seconds);
//       }
//     });
//   }
//
//   // [REPORTING] High Risk
//   _highRiskConfirmation(BuildContext parentContext, [String? LiveJobID]) async {
//     print("LivE JOB Id IS ${LiveJobID}");
//     return showDialog<void>(
//       context: context, barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           content: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: CustomColor.primary,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10.0),
//                       topLeft: Radius.circular(10.0),
//                     ),
//                   ),
//                   child: Text(
//                     "High Risk",
//                     style: TextStyle(color: CustomColor.white),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 Text(
//                   'Do you want to ${(enableActive == false || enableActive == null) ? "Enable" : "Disable"} High Risk ?',
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ButtonWidget(
//                     btnHeight: 40,
//                     btnWidth: 100,
//                     btnColor: CustomColor.notificationMessageColor,
//                     textColor: CustomColor.white,
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     text: "Cancel"),
//                 SizedBox(
//                   width: 10.0,
//                 ),
//                 ButtonWidget(
//                     btnHeight: 40,
//                     btnWidth: 100,
//                     btnColor: CustomColor.primary,
//                     textColor: CustomColor.white,
//                     onPressed: () async {
//                       CustomProgressDialog.showProDialog();
//                       var result;
//                       print("High Risk Option Pressed On LiveJobID = ${LiveJobID}");
//                       CurrentLocation().getCurrentLocation().then((value) async {
//                         Map<String, dynamic> reqData = {
//                           "organisation_id": UserPreferences.OrganizationId,
//                           "jobId": LiveJobID,
//                           "is_at_high_risk":
//                           (UserPreferences.isSessionHighRisk == false || UserPreferences.isSessionHighRisk == null)
//                               ? 1
//                               : 0,
//                           "lat": value!.longitude.toString(),
//                           "lng": value.longitude.toString(),
//                         };
//                         print("Request Data For High Risk: ${reqData}");
//                         try {
//                           GeneralResponse response = await AppUrl.apiService.high_risk_status(reqData);
//                           if (response.error == 0) {
//                             if (reqData['is_at_high_risk'] == 0) {
//                               print("HighRisk Value is 0");
//                               UserPreferences.setisSessionHighRisk(false);
//                               setState(() {
//                                 enableRisk = 0xFF9E9E9E;
//                                 enableActive = false;
//                               });
//                               CustomProgressDialog.hideProDialog();
//                               Navigator.of(context).pop();
//                             } else {
//                               print("HighRisk Value is 1");
//                               UserPreferences.setisSessionHighRisk(true);
//                               setState(() {
//                                 enableRisk = 0xff092d74;
//                                 enableActive = true;
//                               });
//                               CustomProgressDialog.hideProDialog();
//                               Navigator.of(context).pop();
//                             }
//                             result = {'status': true, 'message': response.message, 'data': response.data};
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text(result['message'])),
//                             );
//                           } else {
//                             result = {'status': false, 'message': response.message};
//                             Navigator.of(context).pop();
//                           }
//                           return result;
//                         } catch (err) {
//                           result = {'status': false, 'message': err.toString()};
//                           Navigator.of(context).pop();
//                           return result;
//                         }
//                       });
//                     },
//                     text: "Confirm"),
//               ],
//             )
//           ],
//         );
//       },
//     );
//   }
//
//   // [REPORTING] Camera
//   void capture_Image(BuildContext context, String sessionId) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//             content: Container(
//               height: 120,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FractionallySizedBox(
//                     widthFactor: 0.75,
//                     child: ElevatedButton.icon(
//                       icon: Icon(Icons.camera),
//                       onPressed: () {
//                         OpenPicker(ImageSource.camera, context, sessionId);
//                       },
//                       label: Text("Open Camera", style: TextStyle(fontSize: 12)),
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(CustomColor.primary),
//                           foregroundColor: MaterialStateProperty.all(CustomColor.white),
//                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
//                             // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
//                               borderRadius: BorderRadius.circular(10.0)))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   FractionallySizedBox(
//                     widthFactor: 0.75,
//                     child: ElevatedButton.icon(
//                         icon: Icon(Icons.photo_library_outlined),
//                         onPressed: () {
//                           OpenPicker(ImageSource.gallery, context, sessionId);
//                         },
//                         label: Text(
//                           "Take From Gallery",
//                           style: TextStyle(fontSize: 12),
//                         ),
//                         style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(CustomColor.primary),
//                             foregroundColor: MaterialStateProperty.all(CustomColor.white),
//                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
//                               // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
//                                 borderRadius: BorderRadius.circular(10.0))))),
//                   )
//                 ],
//               ),
//             )));
//   }
//
//   OpenPicker(ImageSource source, BuildContext context, String sessionId) async {
//     image = (await _picker.pickImage(source: source));
//
//     setState(() {
//       pickedImage = File(image!.path);
//       cameraImage = pickedImage!.readAsBytesSync();
//       _controller.text = "";
//       signatureController.clear();
//     });
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           backgroundColor: Colors.white,
//           insetPadding: EdgeInsets.all(10.0),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           content: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     "Report",
//                     style: TextStyle(color: CustomColor.primary, fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                       height: 150,
//                       width: 150,
//                       child: image != null
//                           ? Image.file(
//                         File(image!.path),
//                         fit: BoxFit.cover,
//                       )
//                           : SizedBox()),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         // border: new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.red)),
//                         labelText: 'Type notes',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   //signature
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Container(
//                         decoration: BoxDecoration(
//                           // image:  DecorationImage(
//                           //   image:  AssetImage("images/add.png"),
//                           // ),
//                           border: Border.all(color: CustomColor.notificationMessageColor),
//                         ),
//                         height: 150,
//                         child: Stack(
//                           children: [
//                             Signature(
//                               controller: signatureController, // width: 300,
//                               height: 150, backgroundColor: Colors.white,
//                             ),
//                             Container(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Signature",
//                                   style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
//                                 )),
//                           ],
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     alignment: Alignment.topLeft,
//                     child: ButtonWidget(
//                         btnHeight: 40,
//                         btnWidth: 80,
//                         btnColor: CustomColor.primary,
//                         onPressed: () {
//                           signatureController.clear();
//                         },
//                         text: "Clear"),
//                   ),
//
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             Row(
//               children: [
//                 ButtonWidget(
//                   btnWidth: MediaQuery.of(context).size.width * 0.4,
//                   btnHeight: 40,
//                   onPressed: () async {
//                     setState(() {
//                       isLoadingcamera = true;
//                     });
//
//                     signatureController.toPngBytes().then((value) async {
//                       Uint8List imageInUnit8List = value!;
//                       final tempDir = await getTemporaryDirectory();
//                       File file = await File('${tempDir.path}/signatureimage.png').create();
//                       file.writeAsBytesSync(imageInUnit8List);
//                       print("FILE IS ${file}");
//                       jobDeploymentUploadFile(
//                           UserPreferences.OrganizationId, pickedImage!, file, sessionId, _controller.text);
//                     });
//                   },
//                   text: "Submit",
//                   textColor: Colors.white,
//                   btnColor: CustomColor.secondary,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 ButtonWidget(
//                   btnHeight: 40,
//                   btnWidth: MediaQuery.of(context).size.width * 0.4,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   text: "Cancel",
//                   textColor: Colors.white,
//                   btnColor: CustomColor.subBtn,
//                 )
//               ],
//             )
//           ],
//         ));
//   }
//
//   Future<Map<String, dynamic>> jobDeploymentUploadFile(
//       String organisationId, File cameraImage, File file, String sessionId, String text) async {
//     // var name = '${ProvidersUtility.userProvider!.user.firstname} ${ProvidersUtility.userProvider!.user.lastname}';
//     // final tempDir = await getTemporaryDirectory();
//     // File getdeploymentImg = await File('${tempDir.path}/${name}.png').create();
//     // getdeploymentImg.writeAsBytesSync(cameraImage);
//     CurrentLocation().getCurrentLocation().then((value) async {
//       try {
//         final response = await AppUrl.apiService.jobDeploymentUploadimg(sessionId, int.parse(organisationId), 1,
//             cameraImage, file, value!.latitude.toString(), value.latitude.toString(), text);
//         print("[RESPONSE-jobDeploymentUploadimg()] ${response.toString()}");
//         if (response.error == 0) {
//           setState(() {
//             isLoadingcamera = false;
//           });
//           TopFunctions.showScaffold("${response.message}");
//           Navigator.pop(context);
//         }
//         return {'status': true, 'message': response.message};
//       } catch (err) {
//         return {'status': false, 'message': err.toString()};
//       }
//     });
//     return {'status': false, 'message': 'Image Sending Failed'};
//   }
//
//   // [REPORTING] Video
//   void record_video(BuildContext context, String sessionId) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//             content: Container(
//               height: 120,
//               child: Column(
//                 children: [
//                   FractionallySizedBox(
//                     widthFactor: 0.75,
//                     child: ElevatedButton.icon(
//                       icon: Icon(Icons.camera),
//                       onPressed: () {
//                         VideoPlay(ImageSource.camera, context, sessionId);
//                       },
//                       label: Text("Open Camera", style: TextStyle(fontSize: 12)),
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(CustomColor.primary),
//                           foregroundColor: MaterialStateProperty.all(CustomColor.white),
//                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
//                             // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
//                               borderRadius: BorderRadius.circular(10.0)))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   FractionallySizedBox(
//                     widthFactor: 0.75,
//                     child: ElevatedButton.icon(
//                         icon: Icon(Icons.photo_library_outlined),
//                         onPressed: () {
//                           VideoPlay(ImageSource.gallery, context, sessionId);
//                         },
//                         label: Text("Take From Gallery", style: TextStyle(fontSize: 12)),
//                         style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(CustomColor.primary),
//                             foregroundColor: MaterialStateProperty.all(CustomColor.white),
//                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
//                               // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
//                                 borderRadius: BorderRadius.circular(10.0))))),
//                   )
//                 ],
//               ),
//             )));
//   }
//
//   VideoPlay(ImageSource source, BuildContext context, String sessionId) async {
//     pickedVideo = (await _picker.pickVideo(source: source));
//     setState(() {
//       pickedImage = File(pickedVideo!.path);
//       cameraImage = pickedImage!.readAsBytesSync();
//       _controller.text = "";
//       signatureController.clear();
//     });
//     _videocontroller = VideoPlayerController.file(File(pickedVideo!.path));
//     _initializeVideoPlayerFuture = _videocontroller.initialize();
//     _videocontroller.setLooping(true);
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           backgroundColor: Colors.white,
//           insetPadding: EdgeInsets.all(10.0),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           content: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     "Report",
//                     style: TextStyle(color: CustomColor.primary, fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                     height: 150,
//                     width: 150,
//                     child: FutureBuilder(
//                       future: _initializeVideoPlayerFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           // If the VideoPlayerController has finished initialization, use
//                           // the data it provides to limit the aspect ratio of the video.
//                           return Container(height: 150, child: VideoPlayer(_videocontroller));
//                         } else {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: 10.0,
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         // border: new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.red)),
//                         labelText: 'Type notes',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   //signature
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Container(
//                         decoration: BoxDecoration(
//                           // image:  DecorationImage(
//                           //   image:  AssetImage("images/add.png"),
//                           // ),
//                           border: Border.all(color: CustomColor.notificationMessageColor),
//                         ),
//                         height: 150,
//                         child: Stack(
//                           children: [
//                             Signature(
//                               controller: signatureController, // width: 300,
//                               height: 150, backgroundColor: Colors.white,
//                             ),
//                             Container(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Signature",
//                                   style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
//                                 )),
//                           ],
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     alignment: Alignment.topLeft,
//                     child: ButtonWidget(
//                         btnHeight: 40,
//                         btnWidth: 80,
//                         btnColor: CustomColor.primary,
//                         onPressed: () {
//                           signatureController.clear();
//                         },
//                         text: "Clear"),
//                   ),
//
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             Row(
//               children: [
//                 ButtonWidget(
//                   btnWidth: MediaQuery.of(context).size.width * 0.4,
//                   btnHeight: 40,
//                   onPressed: () async {
//                     setState(() {
//                       isLoadingvideo = true;
//                     });
//
//                     signatureController.toPngBytes().then((value) async {
//                       Uint8List imageInUnit8List = value!;
//                       final tempDir = await getTemporaryDirectory();
//                       File file = await File('${tempDir.path}/signatureimage.png').create();
//                       file.writeAsBytesSync(imageInUnit8List);
//                       print("FILE IS ${file}");
//                       jobDeploymentUploadVideo(File(pickedVideo!.path), file, sessionId, _controller.text);
//                     });
//                   },
//                   text: "Submit",
//                   textColor: Colors.white,
//                   btnColor: CustomColor.secondary,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 ButtonWidget(
//                   btnHeight: 40,
//                   btnWidth: MediaQuery.of(context).size.width * 0.4,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   text: "Cancel",
//                   textColor: Colors.white,
//                   btnColor: CustomColor.subBtn,
//                 )
//               ],
//             )
//           ],
//         ));
//   }
//
//   Future<Map<String, dynamic>> jobDeploymentUploadVideo(
//       File video, File signature, String sessionId, String text) async {
//     CurrentLocation().getCurrentLocation().then((value) async {
//       try {
//         final response = await AppUrl.apiService.jobDeploymentUploadfile(
//             sessionId,
//             int.parse(UserPreferences.OrganizationId),
//             1,
//             video,
//             signature,
//             value!.latitude.toString(),
//             value.longitude.toString(),
//             text);
//         print("[RESPONSE-jobDeploymentUploadVideo()] ${response.toString()}");
//         if (response.error == 0) {
//           setState(() {
//             isLoadingvideo = false;
//           });
//           TopFunctions.showScaffold("${response.message}");
//           Navigator.pop(context);
//           Navigator.pop(context);
//         }
//         return {'status': true, 'message': response.message};
//       } catch (err) {
//         return {'status': false, 'message': err.toString()};
//       }
//     });
//     return {'status': false, 'message': 'Video Sending Failed'};
//   }
//
//   // [REPORTING] Current Location
//   Future<Map<String, dynamic>> logLocation(String sessionId) async {
//     print("Log location is is ${sessionId}");
//     CurrentLocation().getCurrentLocation().then((value) async {
//       setState(() {
//         locationSent++;
//         lastSent = DateFormat.yMd().add_jm().format(DateTime.now());
//       });
//       if (prefs.getString("locationsent") == null) {
//         prefs.setString("locationsent", locationSent.toString());
//         prefs.setString("Lastlocationsent", lastSent.toString());
//       } else {
//         prefs.setString("locationsent", (int.parse(prefs.getString("locationsent").toString()) + 1).toString());
//         prefs.setString("Lastlocationsent", lastSent.toString());
//       }
//       try {
//         final response = await AppUrl.apiService.logLocation({
//           "jobId": sessionId,
//           "bookType": "1",
//           "pin": "1234",
//           "lng": "67.1227526,16",
//           "lat": "24.9426693",
//           "organisation_id": UserPreferences.OrganizationId,
//           "position": "222",
//           "text": "log location"
//         });
//         if (response.error == 0) {
//           setState(() {
//             isLoadinglocation = false;
//           });
//           TopFunctions.showScaffold("${response.message}");
//         }
//         return {'status': true, 'message': response.message};
//       } catch (err) {
//         return {'status': false, 'message': err.toString()};
//       }
//     });
//     return {'status': false, 'message': 'Location Sending Failed'};
//   }
//
//   // [REPORTING] GPS
//   gps_reporting(BuildContext context) async {
//     CurrentLocation().getCurrentLocation().then((value) {
//       return showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//                 contentPadding: EdgeInsets.zero,
//                 backgroundColor: Colors.white, // insetPadding: EdgeInsets.all(10.0),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                 content: Container(
//                   width: MediaQuery.of(context).size.width * 1,
//                   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Column(
//                     // crossAxisAlignment: CrossAxisAlignment.stretch,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "GPS Status",
//                         style: TextStyle(fontWeight: FontWeight.bold, color: CustomColor.primary, fontSize: 16),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Text("Location Sent", style: TextStyle(color: Colors.black)),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           Text("${prefs.getString("locationsent") == null ? 0 : prefs.getString("locationsent")}",
//                               style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Last Location", style: TextStyle(color: Colors.black)),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           (value!.latitude == null && value.longitude == null)
//                               ? Text("Not Available",
//                               style: TextStyle(fontWeight: FontWeight.w500, color: CustomColor.primary))
//                               : Text("${value.latitude} , ${value.longitude}",
//                               style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black))
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Current Location", style: TextStyle(color: Colors.black)),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           Text("${value.latitude} , ${value.longitude}",
//                               style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black))
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Text("Last Seen", style: TextStyle(color: Colors.black)),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           Text(
//                               "${prefs.getString("Lastlocationsent") == null ? "Not Available " : prefs.getString("Lastlocationsent")}",
//                               style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black))
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.3,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             Navigator.pop(context);
//                           },
//                           child: Text("Okay"),
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all(CustomColor.primary),
//                               foregroundColor: MaterialStateProperty.all(CustomColor.white),
//                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
//                                 // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
//                                   borderRadius: BorderRadius.circular(10.0)))),
//                         ),
//                       )
//                     ],
//                   ),
//                 ));
//           });
//     });
//   }
//
//   // [REPORTING] Document
//   document_reporting(BuildContext context, String sessionId) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: [
//           'pdf',
//         ],
//         allowMultiple: false);
//     setState(() {
//       _controller.text = "";
//     });
//     PlatformFile documentFile = result!.files.first;
//     print("Document file ${result.files} ${documentFile.path!.split("/").last.split(".").last}");
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           backgroundColor: Colors.white,
//           insetPadding: EdgeInsets.all(10.0),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           content: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     "Report",
//                     style: TextStyle(color: CustomColor.primary, fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Icon(
//                     Icons.file_copy_outlined,
//                     color: CustomColor.primary,
//                     size: 52,
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Text("${documentFile.name}"),
//
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         // border: new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.red)),
//                         labelText: 'Type notes',
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   //signature
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Container(
//                         decoration: BoxDecoration(
//                           // image:  DecorationImage(
//                           //   image:  AssetImage("images/add.png"),
//                           // ),
//                           border: Border.all(color: CustomColor.notificationMessageColor),
//                         ),
//                         height: 150,
//                         child: Stack(
//                           children: [
//                             Signature(
//                               controller: signatureController, // width: 300,
//                               height: 150, backgroundColor: Colors.white,
//                             ),
//                             Container(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Signature",
//                                   style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
//                                 )),
//                           ],
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     alignment: Alignment.topLeft,
//                     child: ButtonWidget(
//                         btnHeight: 40,
//                         btnWidth: 80,
//                         btnColor: CustomColor.primary,
//                         onPressed: () {
//                           signatureController.clear();
//                         },
//                         text: "Clear"),
//                   ),
//
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             Row(
//               children: [
//                 ButtonWidget(
//                   btnWidth: MediaQuery.of(context).size.width * 0.4,
//                   btnHeight: 40,
//                   onPressed: () async {
//                     setState(() {
//                       isLoadingdocument = true;
//                     });
//
//                     signatureController.toPngBytes().then((value) async {
//                       Uint8List imageInUnit8List = value!;
//                       final tempDir = await getTemporaryDirectory();
//                       File signatureFile = await File('${tempDir.path}/signatureimage.png').create();
//                       signatureFile.writeAsBytesSync(imageInUnit8List);
//                       print("FILE IS ${documentFile}");
//                       jobDeploymentUploadDocument(
//                           File(documentFile.path!), signatureFile, sessionId, _controller.text);
//                     });
//                   },
//                   text: "Submit",
//                   textColor: Colors.white,
//                   btnColor: CustomColor.secondary,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 ButtonWidget(
//                   btnHeight: 40,
//                   btnWidth: MediaQuery.of(context).size.width * 0.4,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   text: "Cancel",
//                   textColor: Colors.white,
//                   btnColor: CustomColor.subBtn,
//                 )
//               ],
//             )
//           ],
//         ));
//   }
//
//   Future<Map<String, dynamic>> jobDeploymentUploadDocument(
//       File? document, File signature, String sessionId, String text) async {
//     CurrentLocation().getCurrentLocation().then((value) async {
//       try {
//         final response = await AppUrl.apiService.jobDeploymentUploadfile(
//             sessionId,
//             int.parse(UserPreferences.OrganizationId),
//             1,
//             document!,
//             signature,
//             value!.latitude.toString(),
//             value.longitude.toString(),
//             text);
//         print("jobDeploymentUploadDocument ${response.message}");
//         if (response.error == 0) {
//           setState(() {
//             isLoadingdocument = false;
//           });
//           Fluttertoast.showToast(
//               msg: "${response.message}",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.BOTTOM,
//               timeInSecForIosWeb: 1,
//               textColor: CustomColor.white,
//               backgroundColor: CustomColor.primary,
//               fontSize: 16.0);
//           Navigator.pop(context);
//         }
//         return {'status': true, 'message': response.message};
//       } catch (err) {
//         return {'status': false, 'message': err.toString()};
//       }
//     });
//
//     return {'status': false, 'message': ''};
//   }
//
//   // [REPORTING] Notes
//   text_reporting(BuildContext context, String sessionId) {
//     return showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           backgroundColor: Colors.white,
//           insetPadding: EdgeInsets.all(10.0),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//           content: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     "Report",
//                     style: TextStyle(color: CustomColor.primary, fontSize: 14, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Container(
//                       height: 150,
//                       decoration: BoxDecoration(
//                         // image:  DecorationImage(
//                         //   image:  AssetImage("images/add.png"),
//                         // ),
//                         border: Border.all(color: CustomColor.notificationMessageColor),
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           label: Text("Type notes"), border: InputBorder.none,
//                           // enabledBorder: null,
//                         ),
//                         keyboardType: TextInputType.multiline,
//                         textInputAction: TextInputAction.newline,
//                         minLines: 1,
//                         maxLines: 5,
//                         controller: _controller,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   //signature
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Container(
//                         decoration: BoxDecoration(
//                           // image:  DecorationImage(
//                           //   image:  AssetImage("images/add.png"),
//                           // ),
//                           border: Border.all(color: CustomColor.notificationMessageColor),
//                         ),
//                         height: 150,
//                         child: Stack(
//                           children: [
//                             Signature(
//                               controller: signatureController, // width: 300,
//                               height: 150, backgroundColor: Colors.white,
//                             ),
//                             Container(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Signature",
//                                   style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
//                                 )),
//                           ],
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     alignment: Alignment.topLeft,
//                     child: ButtonWidget(
//                         btnHeight: 40,
//                         btnWidth: 80,
//                         btnColor: CustomColor.primary,
//                         onPressed: () {
//                           signatureController.clear();
//                         },
//                         text: "Clear"),
//                   ),
//
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             Row(
//               children: [
//                 ButtonWidget(
//                   btnWidth: MediaQuery.of(context).size.width * 0.4,
//                   btnHeight: 40,
//                   onPressed: () async {
//                     setState(() {
//                       isLoadingnotes = true;
//                     });
//
//                     signatureController.toPngBytes().then((value) async {
//                       Uint8List imageInUnit8List = value!;
//                       final tempDir = await getTemporaryDirectory();
//                       File signatureFile = await File('${tempDir.path}/signatureimage.png').create();
//                       signatureFile.writeAsBytesSync(imageInUnit8List);
//                       Sampletext(sessionId, signatureFile);
//
//                       // jobDeploymentUploadDocument(File(documentFile.path!),signatureFile, sessionId, _controller.text);
//                     });
//                   },
//                   text: "Submit",
//                   textColor: Colors.white,
//                   btnColor: CustomColor.secondary,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 ButtonWidget(
//                   btnHeight: 40,
//                   btnWidth: MediaQuery.of(context).size.width * 0.4,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   text: "Cancel",
//                   textColor: Colors.white,
//                   btnColor: CustomColor.subBtn,
//                 )
//               ],
//             )
//           ],
//         ));
//   }
//
//   Future<Map<String, dynamic>> Sampletext(String sessionId, File signature) async {
//     CurrentLocation().getCurrentLocation().then((value) async {
//       try {
//         final response = await AppUrl.apiService.jobDeploymentUploadText(
//             sessionId,
//             int.parse(UserPreferences.OrganizationId),
//             1,
//             "text-only",
//             _controller.text,
//             signature,
//             value!.latitude.toString(),
//             value.longitude.toString());
//         if (response.error == 0) {
//           setState(() {
//             isLoadingnotes = false;
//           });
//           Fluttertoast.showToast(
//               msg: "${response.message}",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.BOTTOM,
//               timeInSecForIosWeb: 1,
//               textColor: CustomColor.white,
//               backgroundColor: CustomColor.primary,
//               fontSize: 16.0);
//           Navigator.pop(context);
//         }
//         return {'status': true, 'message': response.message};
//       } catch (err) {
//         return {'status': false, 'message': err.toString()};
//       }
//     });
//     return {'status': false, 'message': 'Failed To Send Text'};
//   }
//
//   // [REPORTING] Audio
//   Future startRecord() async {
//     if (!isRecorderReady) return;
//     await recorder.startRecorder(toFile: 'novusaudio.mp4', codec: Codec.aacMP4);
//   }
//
//   Future stopRecording(String sessionId) async {
//     if (!isRecorderReady) return;
//     try {
//       final path = await recorder.stopRecorder();
//       final tempDir = await getTemporaryDirectory();
//       final fileName = path!.split("/").last;
//       File convert_audioFile = await File('${tempDir.path}/${fileName}').create();
//       jobDeploymentUploadAudio(
//         sessionId,
//         convert_audioFile,
//       );
//     } catch (e) {
//       print("Exception is $e");
//     }
//   }
//
//   Future<Map<String, dynamic>> jobDeploymentUploadAudio(String sessionId, File audio) async {
//     CurrentLocation().getCurrentLocation().then((value) async {
//       setState(() {
//         isLoadingaudio = true;
//       });
//       try {
//         final response = await AppUrl.apiService.jobDeploymentUploadaudio(
//           sessionId,
//           int.parse(UserPreferences.OrganizationId),
//           1,
//           audio,
//           value!.latitude.toString(),
//           value.longitude.toString(),
//         );
//         print("[RESPONSE-jobDeploymentUploadAudio()] ${response.message}");
//         if (response.error == 0) {
//           print("AUDIO RESPONSE MESSAGE IS ${response.message}");
//           setState(() {
//             isLoadingaudio = false;
//           });
//           Fluttertoast.showToast(
//               msg: "${response.message}",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.BOTTOM,
//               timeInSecForIosWeb: 1,
//               textColor: CustomColor.white,
//               backgroundColor: CustomColor.primary,
//               fontSize: 16.0);
//         }
//         return {'status': true, 'message': response.message};
//       } catch (err) {
//         return {'status': false, 'message': err.toString()};
//       }
//     });
//     return {'status': false, 'message': 'Audio Upload Failed'};
//   }
// }