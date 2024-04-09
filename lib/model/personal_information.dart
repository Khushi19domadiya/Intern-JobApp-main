/*class InfoModel  {
  final String? id;
  final String firstname;
  final String lastname;
  final String email;
  final int phoneno;
  final String address;

  InfoModel({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneno,
    required this.address,
  });
  toJson(){
    return{
      "id":id,
      "First Name":  firstname,
      "Last Name" : lastname,
      "Email": email,
      "Phone No." : phoneno,
      "Adress": address,
    };
  }
}*/

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:job_app/model/user_model.dart';
import 'package:job_app/util/colors.dart';
import 'package:job_app/util/common_methos.dart';


final FirebaseStorage _storage = FirebaseStorage.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  /*Future<String> uploadImage(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() => print('Image Uploaded'));

      return await storageReference.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<String> uploadImageToFirebaseStorage(String imagePath) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageReference.putFile(File(imagePath));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  }*/

  Future<String> uploadImage(File imageFile) async {
    String fileName = basename(imageFile.path);
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);

    await uploadTask.whenComplete(() => print('Image uploaded successfully'));


    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addOrUpdateUserData(UserModel userModel) async {
    log('-----addOrUpdateUserData------');
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    // Check if the user document already exists
    DocumentSnapshot userSnapshot = await users.doc(userModel.userId).get();

    // Convert UserModel object to a map without null values
    Map<String, dynamic> userDataMap = userModel.toUpdateMap();
    log(("------userDataMap----->> ${userDataMap.toString()}"));
    if (userSnapshot.exists) {
      // User document exists, update the username field
      await users.doc(userModel.userId).update(userModel.toMap());
    } else {
      // User document doesn't exist, create a new document
      await users.doc(userModel.userId).set(userModel.toMap());
    }
    CommonMethod()
        .getXSnackBar("Success", "Profile upadate successfully", success);
  }

  /*Future<String> saveDate({
    // void int id,
    required String userId,
    required String fname,
    required String lname,
    required String email,
    required String phonenumber,
    required String address,
    required File file,
  }) async {
    log("----saveProfileCalledInside-----");

    CommonMethod().getXSnackBar("Wait", "Upload Process", lightPurpelColor);

    String resp = " Some Error Occurred";
    // try{
    if (fname.isNotEmpty ||
        lname.isNotEmpty ||
        email.isNotEmpty ||
        phonenumber.isNotEmpty ||
        address.isNotEmpty) {
      log("----file-----${file.path}");
      // String imageUrl = await uploadImageToStorage('profileImage', file);
      // log("----imageUrl-----${imageUrl}");
      String imageUrl = await uploadImage(File(file.path));
      log("----imageUrl-----${imageUrl}");

      await _firestore.collection('Users').add({
        // 'id': id,
        'fname': fname,
        'lname': lname,
        'email': email,
        'phonenumber': phonenumber,
        'address': address,
        'imageLink': imageUrl,
      });

      CommonMethod()
          .getXSnackBar("Success", "Profile upadate successfully", success);

      resp = 'Success';
      // }
      // }
      // catch(err){
      //   resp = err.toString();
    }
    return resp;
  }*/
}

