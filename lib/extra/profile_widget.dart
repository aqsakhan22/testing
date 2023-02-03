// InkWell(
// onTap: () async{
// XFile? pickedFile = await imagePicker.pickImage(
// source: ImageSource.gallery,
// imageQuality: 65,
// );
// setState(() {
// _image = File(pickedFile!.path);
// });
// },
// child:
// ClipOval(child:   Material(
//
//
// // color: Colors.red,
// child: _image == null && sampleimage == ""  ?
// Image.asset("assets/sample.jpg", fit: BoxFit.cover, width: 64, height: 64,)
//
// : Image.file(File(_image!.path),width: 90,height: 90,fit: BoxFit.cover,),
// ),)
// ) ,