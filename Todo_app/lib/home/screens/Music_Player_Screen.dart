// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_file_manager/flutter_file_manager.dart';
// import 'package:path_provider_ex/path_provider_ex.dart';
// //import package files

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyAudioList(),
//     );
//   }
// }

// //apply this class on home: attribute at MaterialApp()
// class MyAudioList extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MyAudioList(); //create state
//   }
// }

// class _MyAudioList extends State<MyAudioList> {
//   var files;

//   void getFiles() async {
//     //asyn function to get list of files
//     List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
//     var root = storageInfo[0]
//         .rootDir; //storageInfo[1] for SD card, geting the root directory
//     var fm = FileManager(root: Directory(root)); //
//     files = await fm.filesTree(
//         excludedPaths: ["/storage/emulated/0/Android"],
//         extensions: ["mp3"] //optional, to filter files, list only mp3 files
//         );
//     setState(() {}); //update the UI
//   }

//   @override
//   void initState() {
//     getFiles(); //call getFiles() function on initial state.
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title: Text("Audio File list from Storage"),
//             backgroundColor: Colors.redAccent),
//         body: files == null
//             ? Text("Searching Files")
//             : ListView.builder(
//                 //if file/folder list is grabbed, then show here
//                 itemCount: files?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   return Card(
//                       child: ListTile(
//                     title: Text(files[index].path.split('/').last),
//                     leading: Icon(Icons.audiotrack),
//                     trailing: Icon(
//                       Icons.play_arrow,
//                       color: Colors.redAccent,
//                     ),
//                     onTap: () {
//                       // you can add Play/push code over here
//                     },
//                   ));
//                 },
//               ));
//   }
// }
