import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';



class PostModalSheet extends StatefulWidget {
  @override
  State<PostModalSheet> createState() {
    return _PostModalSheetState();
  }
}

class _PostModalSheetState extends State<PostModalSheet> {
  File? _imgFile;
  Position? CurrentPosition;
  String? userCity;
  void takeSnapshot() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.camera, // alternatively, use ImageSource.gallery
      maxWidth: 400,
    );
    if (img == null) return;
    setState(() {
      _imgFile = File(img.path); // convert it to a Dart:io file
    });
  }

  List<MediaFile> _selectedFiles = [];
  //XFile? _selectedImage;
  TextEditingController postController = TextEditingController();
  /*Future _pickImageFromGallery() async{
  //final returned_Image=  await ImagePicker().pickImage(source: ImageSource.gallery);
  
  setState(() {
    _selectedImage= XFile(returned_Image!.path);
  });
  }*/
  
  Future<String> getCity(Position? position)async {
    if (position == null) {
      return " ";
      
    }
    
    String city = '';
    final geoCode = GeoCode();
    final address = await geoCode.reverseGeocoding(
        latitude: position.latitude, longitude: position.longitude).then((value) =>city=value.city.toString() );
    log("Adress is:" + address.toString());
    userCity=city;
    return city;
  }

  @override
  Widget build(BuildContext context) {
    _determineLocation();

    //  getCity(CurrentPosition);
    log("Loacationnn:" + CurrentPosition.toString());
    if (CurrentPosition != null) {
      getCity(CurrentPosition!);
    }
    //getCity(CurrentPosition);
    return SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
             const Text(
                'Report and Address Food Insecurity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
             const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: postController,
                  minLines: 1,
                  maxLines: 30,
                  style:const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      focusColor: Colors.yellowAccent,
                      hintText:
                          'Describe the hunger-related issues you\'ve observed in your neighborhood.',
                      border: //InputBorder.none
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      /* List<MediaFile> mediaFiles =
                          await GalleryPicker.pickMedia(
                                  
                                  context: context, singleMedia: true) ??
                              [];
                          log(mediaFiles.toString());    
                      setState(() {
                        _selectedFiles = mediaFiles;
                      }
                      );

                      //_pickImageFromGallery();
                      */
                      takeSnapshot();
                    },
                    icon:const Icon(Icons.camera_alt),
                    iconSize: 30,
                  ),
                  /*IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.camera_alt),
                    iconSize: 30,
                  ),*/
                ],
              ),

              _imgFile != null
                  ? Image.file(
                      _imgFile!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    )
                  :const Text("No Image Selected"),
             const SizedBox(
                height: 20,
              ),

              // _selectedImage != null? Image.file(_selectedImage!): Text("No Image Selected"),
              FloatingActionButton(
        backgroundColor: Colors.blueAccent,                
  onPressed: () async {
    bool uploaded=await uploadToFirestore();
    if(uploaded){
      Navigator.pop(context);
    }
    else{
      log("Error uploading post");
    }
    log(CurrentPosition.toString());
  },
  child: Text(
    'Post',
    style: TextStyle(color: Colors.white),
  ),
),
              FutureBuilder<String>(
                future: getCity(CurrentPosition),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    //getCity(snapshot.data!);
                    return Text(snapshot.data.toString());
                  }
                  return Container();
                },
              )
            ],
          )),
    );
  }

  Future<bool> uploadToFirestore() async {
    String userCity = await getCity(CurrentPosition);
    try {
      String uploadUrl = await uploadToStorage(_imgFile!);
      if(postController.text.isNotEmpty){
        FirebaseFirestore.instance.collection("posts").add(
          {
            "caption": postController.text,
            "proof": uploadUrl,
            "userLocation": userCity,
            "userName": "Abhishek",
            "userMail": FirebaseAuth.instance.currentUser?.email,
          }
        );
        
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<Position> _determineLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    log('Location permissions are granted: ${Geolocator.getCurrentPosition()}');
    return await Geolocator.getCurrentPosition()
        .then((value) => CurrentPosition = value);
  }
  Future<String> uploadToStorage(File file)async{
    try {
                    final userID=FirebaseAuth.instance.currentUser?.uid;
                    final storageRef = FirebaseStorage.instance.ref();
                    final fileName=_imgFile!.path.split('/').last;
                    final timeSamp=DateTime.now().millisecondsSinceEpoch;
                    final uploadRef= storageRef.child("$userID/uploads/$timeSamp-$fileName");
                    await uploadRef.putFile(_imgFile!);
                    final url=await uploadRef.getDownloadURL();
                     log(url.toString());
                    return url.toString();
                   
                  } catch (e) {
                    log(e.toString());
                    return Future.error("Error uploading image");
                    
                  }
  }
}
