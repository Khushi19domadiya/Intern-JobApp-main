import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/model/user_model.dart';
import 'package:job_app/utils/firebase_functions.dart';
import 'package:job_app/widgets/custom_elevated_button.dart';
import 'package:job_app/widgets/custom_text_form_field.dart';
import '../home_container_screen/home_container_screen.dart';

class ApplyJobScreen extends StatefulWidget {
  final String jobId;
  final String jobTitle;
  final String? postUserId;

  ApplyJobScreen({required this.jobId, this.postUserId, required this.jobTitle});

  @override
  _ApplyJobScreenState createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController frameOneController = TextEditingController();
  // User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  File? cvFile;

  Future<void> _submitApplication() async {
    if (cvFile != null) {
      isLoading.value = true;
      try {
        String cvFileName = 'cv_${userModel!.userId}.pdf';

        // print("userId form firebase: $userId");
        // Add the status field to the user table

        /// Need to verify
        //await FirebaseFirestore.instance.collection('Users').doc(user?.uid).update({'status': 0});

        Reference storageReference = FirebaseStorage.instance.ref().child('cv_files/$cvFileName');
        UploadTask uploadTask = storageReference.putFile(cvFile!);
        await uploadTask.whenComplete(() => print('CV Uploaded'));

        String downloadURL = await storageReference.getDownloadURL();

        // Get a reference to the 'job_applications' collection
        CollectionReference jobApplications = FirebaseFirestore.instance.collection('job_applications');
        // CollectionReference jobApplicationsWithStatus = FirebaseFirestore.instance.collection('Applications');

        // Add a new document to the 'job_applications' collection
        DocumentReference docRef = await jobApplications.add({
          'full_name': fullNameController.text,
          'email': emailController.text,
          'website_portfolio': frameOneController.text,
          'cv_url': downloadURL,
          'curDate': DateTime.now().toString(),
          'timestamp': FieldValue.serverTimestamp(),
          'userId': userModel!.userId,
          "status" : 2,
          'jobId':widget.jobId
        });

        /*DocumentReference docRefStatus = await jobApplicationsWithStatus.add({
          'cv_url': downloadURL,
          'curDate': DateTime.now().toString(),
          'userId': userModel!.userId,
          "status" : 2,
          'jobId':widget.jobId
        });*/

        var docApplyCount = FirebaseFirestore.instance.collection('postJob').doc(widget.jobId);

        FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(docApplyCount);

          // if (!snapshot.exists) {
          //   throw Exception("Document does not exist!"); // Handle case where document does not exist
          // }

          if (snapshot.data() is Map<String, dynamic> && (snapshot.data() as Map<String, dynamic>).containsKey('applyCount')) {
            var applyCount = snapshot.get('applyCount') ?? 0; // Get current apply count or default to 0
            applyCount++; // Increment apply count

            transaction.update(docApplyCount, {'applyCount': applyCount}); // Update document with new apply count
          } else {

            transaction.update(docApplyCount, {'applyCount': 1}); //
          }

        });

        var userData = await FirebaseFirestore.instance.collection('Users').doc(widget.postUserId).get();
        Dio dio = Dio();
        var url = 'https://fcm.googleapis.com/fcm/send';
//queryParameters will the parameter required by your API.
//In my case I had to send the headers also, which we can send using //Option parameter in request. Here are my headers Map:
        var headers = {'Content-type': 'application/json; charset=utf-8',"Authorization" : "key=AAAA1QAzqrM:APA91bEEnfurICv3y2DkrX1qZRk0gUUHjkv-VH8UVpb2MBNzpMfdx50Xo3_LZCrTGaA6j89mFZfSB7NOyntJAUME-wxHSO5oqFb0SvuBlMw5b56YE_Yv3858xmrp3Ub5eSXcncRV4b_p"};
        var responce = await dio.post(url,
          data:  {
            "notification": {
              "title": "Job App",
              "body": "${fullNameController.text} was recently applied in ${widget.jobTitle} job",
              "sound": "default"
            },
            "priority": "High",
            "to": "${userData.data()!["token"]}",

          },
          options: Options(
              headers: headers
          ),);
        if(responce.statusCode == 200){
          print("-dfdf----${responce.data.toString}");
        }
        // Now update the document with the job ID
        await docRef.update({'id': docRef.id});
        // await docRefStatus.update({'id': docRefStatus.id});

        print('Job application data stored successfully');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Application submitted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
        isLoading.value = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeContainerScreen()),
        );
      } catch (error) {
        print('Error uploading CV or storing data: $error');
        isLoading.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting application. Please try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Apply Job'),
        ),
        body: FutureBuilder<UserModel?>(
          future: AppFunctions().getUserData(FirebaseAuth.instance.currentUser!.uid.toString()),
          builder: (context, snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: SizedBox(
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                );
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  userModel = snapshot.data!;
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _buildPersonalInfoFullName(context),
                                SizedBox(height: 18.0),
                                _buildPersonalInfoEmail(context),
                                SizedBox(height: 18.0),
                                _buildPersonalInfoWebsite(context),
                                SizedBox(height: 18.0),
                                _buildCvFields(context),
                                SizedBox(height: 16.0),
                                SizedBox(height: 120.0),
                                _buildContinueButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: isLoading.stream,
                          builder: (context, snapshot) {
                            return isLoading.value ?   Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black.withOpacity(.3),
                              child: Center(child: CircularProgressIndicator()),
                            ) : SizedBox();
                          }
                      ),
                    ],
                  );
            }

          },
        ),

      ),
    );
  }


  // Widget _buildPersonalInfoFullName(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text("Full Name", style: theme.textTheme.titleSmall),
  //       SizedBox(height: 9.0  ),
  //       CustomTextFormField(
  //         controller: fullNameController,
  //         hintText: user!.displayName.toString(),
  //       ),
  //     ],
  //   );
  // }



  Widget _buildPersonalInfoFullName(BuildContext context) {
    fullNameController.text = "${userModel!.fname} ${userModel!.lname}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Full Name", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.0),
        CustomTextFormField(
          controller: fullNameController,
          readOnly: true,
          // hintText: "${userModel!.fname} ${userModel!.lname}", // Set combined name as hint text
        ),
      ],
    );
    /*return FutureBuilder<DocumentSnapshot>(
      future: user?.uid != null ? FirebaseFirestore.instance.collection('Users').doc(user?.uid).get() : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while fetching data
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('User data not found');
        }

        // Check if the 'fname' field exists in the document
        bool fnameExists = snapshot.data!.get('fname') != null;

        // Extract first name and last name from user data
        String firstName = fnameExists ? snapshot.data!.get('fname') : 'Unknown';
        String lastName = fnameExists ? snapshot.data!.get('lname') : 'Unknown';

        // Combine first name and last name
        String fullName = '$firstName $lastName';
        print("userId firebase: $fullName");

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full Name", style: theme.textTheme.titleSmall),
            SizedBox(height: 9.0),
            CustomTextFormField(
              controller: fullNameController,
              readOnly: true,
              hintText: fullName, // Set combined name as hint text
            ),
          ],
        );
      },
    );*/
  }


  Widget _buildPersonalInfoEmail(BuildContext context) {
    emailController.text = userModel!.email!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.0),
        CustomTextFormField(
          controller: emailController,
          // hintText: userModel!.email.toString(),
          readOnly: true,
        ),
      ],
    );
  }

  // Widget _buildPersonalInfoWebsite(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text("Website, Blog, or Portfolio", style: theme.textTheme.titleSmall),
  //       SizedBox(height: 9.0),
  //       CustomTextFormField(
  //         controller: frameOneController,
  //         hintText: "Website, Blog, or Portfolio",
  //         validator: (value) {
  //           if (value == null || value.isEmpty) {
  //             return 'Please enter your Website, Blog, or Portfolio name';
  //           }
  //           return null;
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _buildPersonalInfoWebsite(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Website, Blog, or Portfolio", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.0),
        CustomTextFormField(
          controller: frameOneController,
          hintText: "Website, Blog, or Portfolio",
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter your Website, Blog, or Portfolio name';
          //   }
          //
          //   bool isValidUrl = RegExp(
          //     r'^(?:http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?'
          //     r'[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*\.[a-zA-Z]{2,}(?:\/[^\s]*)?$',
          //   ).hasMatch(value);
          //   if (!isValidUrl) {
          //     return 'Please enter a valid website URL';
          //   }
          //   return null;
          // },
        ),
      ],
    );
  }

  Widget _buildCvFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upload CV", style: theme.textTheme.titleSmall),
        SizedBox(height: 7.v),
        DottedBorder(
          color: appTheme.gray300,
          padding: EdgeInsets.only(left: 1.h, top: 1.v, right: 1.h, bottom: 1.v),
          strokeWidth: 1.h,
          radius: Radius.circular(24),
          dashPattern: [6, 6],
          child: GestureDetector(
            onTap: () async {
              FilePickerResult? result;
              try {
                result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );
              } on Exception catch (e) {
                print('File picker error: $e');
              }
              if (result != null && result.files.isNotEmpty) {
                setState(() {
                  cvFile = File(result?.files.first.path ?? '');
                });
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 124.h, vertical: 39.v),
              decoration: AppDecoration.outlineGray300.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgCloudUpload1,
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    "Upload File",
                    style: CustomTextStyles.titleSmallSemiBold,
                  ),
                  if (cvFile != null)
                    Text(
                      'Selected CV: ${cvFile!.path}',
                      style: TextStyle(color: Colors.black),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return CustomElevatedButton(
      text: 'Continue',
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          await _submitApplication();
        }
      },
    );
  }
}
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:job_app/core/app_export.dart';
// import 'package:job_app/models/user_model.dart';
// import 'package:job_app/presentation/home_container_screen/home_container_screen.dart';
// import 'package:job_app/widgets/custom_elevated_button.dart';
// import 'package:job_app/widgets/custom_text_form_field.dart';
//
// class ApplyJobScreen extends StatefulWidget {
//   final String jobId;
//   final String jobTitle;
//   final String? postUserId;
//
//   ApplyJobScreen({required this.jobId, this.postUserId, required this.jobTitle});
//
//   @override
//   _ApplyJobScreenState createState() => _ApplyJobScreenState();
// }
//
// class _ApplyJobScreenState extends State<ApplyJobScreen> {
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController frameOneController = TextEditingController();
//   User? user = FirebaseAuth.instance.currentUser;
//
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   RxBool isLoading = false.obs;
//   File? cvFile;
//
//   Future<void> _uploadCV() async {
//     if (cvFile != null) {
//       isLoading.value = true;
//       try {
//         String userId = user?.uid ?? 'unique_user_id';
//         String cvFileName = 'cv_$userId.pdf';
//
//         Reference storageReference = FirebaseStorage.instance.ref().child('cv_files/$cvFileName');
//         UploadTask uploadTask = storageReference.putFile(cvFile!);
//         await uploadTask.whenComplete(() => print('CV Uploaded'));
//
//         String downloadURL = await storageReference.getDownloadURL();
//
//         // Get a reference to the 'job_applications' collection
//         CollectionReference jobApplications = FirebaseFirestore.instance.collection('job_applications');
//
//         // Add a new document to the 'job_applications' collection
//         DocumentReference docRef = await jobApplications.add({
//           'full_name': fullNameController.text,
//           'email': emailController.text,
//           'website_portfolio': frameOneController.text,
//           'cv_url': downloadURL,
//           'timestamp': FieldValue.serverTimestamp(),
//           'userId': user?.uid,
//           'jobId':widget.jobId
//         });
//
//         var docApplyCount = FirebaseFirestore.instance.collection('postJob').doc(widget.jobId);
//
//         FirebaseFirestore.instance.runTransaction((transaction) async {
//           DocumentSnapshot snapshot = await transaction.get(docApplyCount);
//
//           // if (!snapshot.exists) {
//           //   throw Exception("Document does not exist!"); // Handle case where document does not exist
//           // }
//
//           if (snapshot.data() is Map<String, dynamic> && (snapshot.data() as Map<String, dynamic>).containsKey('applyCount')) {
//             var applyCount = snapshot.get('applyCount') ?? 0; // Get current apply count or default to 0
//             applyCount++; // Increment apply count
//
//             transaction.update(docApplyCount, {'applyCount': applyCount}); // Update document with new apply count
//           } else {
//
//             transaction.update(docApplyCount, {'applyCount': 1}); //
//           }
//
//         });
//
//         // Now update the document with the job ID
//         await docRef.update({'id': docRef.id});
//
//         // Update the status field in the user table to "P"
//         await FirebaseFirestore.instance.collection('Users').doc(user?.uid).update({'status': 'P'});
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Application submitted successfully!'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         isLoading.value = false;
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeContainerScreen()),
//         );
//       } catch (error) {
//         print('Error uploading CV or storing data: $error');
//         isLoading.value = false;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error submitting application. Please try again later.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Apply Job'),
//         ),
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       _buildPersonalInfoFullName(context),
//                       SizedBox(height: 18.0),
//                       _buildPersonalInfoEmail(context),
//                       SizedBox(height: 18.0),
//                       _buildPersonalInfoWebsite(context),
//                       SizedBox(height: 18.0),
//                       _buildCvFields(context),
//                       SizedBox(height: 16.0),
//                       SizedBox(height: 100.0),
//                       _buildContinueButton(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             StreamBuilder(
//                 stream: isLoading.stream,
//                 builder: (context, snapshot) {
//                   return isLoading.value ?   Container(
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.black.withOpacity(.3),
//                     child: Center(child: CircularProgressIndicator()),
//                   ) : SizedBox();
//                 }
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPersonalInfoFullName(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Full Name", style: theme.textTheme.titleSmall),
//         SizedBox(height: 9.0),
//         CustomTextFormField(
//           controller: fullNameController,
//           hintText: "Enter Your Full Name",
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your full name';
//             } else if (!value.startsWith(RegExp(r'[A-Z]'))) {
//               return 'First character should start with a capital letter';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPersonalInfoEmail(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Email", style: theme.textTheme.titleSmall),
//         SizedBox(height: 9.0),
//         CustomTextFormField(
//           controller: emailController,
//           hintText: "xyz@gmail.com",
//           readOnly: false,
//           textInputType: TextInputType.emailAddress,
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your email';
//             } else if (!GetUtils.isEmail(value)) {
//               return 'Please enter a valid email address';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPersonalInfoWebsite(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Website, Blog, or Portfolio", style: theme.textTheme.titleSmall),
//         SizedBox(height: 9.0),
//         CustomTextFormField(
//           controller: frameOneController,
//           hintText: "Website, Blog, or Portfolio",
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter your Website, Blog, or Portfolio name';
//             }
//
//             bool isValidUrl = RegExp(
//               r'^(?:http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?'
//               r'[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*\.[a-zA-Z]{2,}(?:\/[^\s]*)?$',
//             ).hasMatch(value);
//             if (!isValidUrl) {
//               return 'Please enter a valid website URL';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCvFields(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Upload CV", style: theme.textTheme.titleSmall),
//         SizedBox(height: 7.v),
//         DottedBorder(
//           color: appTheme.gray300,
//           padding: EdgeInsets.only(left: 1.h, top: 1.v, right: 1.h, bottom: 1.v),
//           strokeWidth: 1.h,
//           radius: Radius.circular(24),
//           dashPattern: [6, 6],
//           child: GestureDetector(
//             onTap: () async {
//               FilePickerResult? result;
//               try {
//                 result = await FilePicker.platform.pickFiles(
//                   type: FileType.custom,
//                   allowedExtensions: ['pdf'],
//                 );
//               } on Exception catch (e) {
//                 print('File picker error: $e');
//               }
//               if (result != null && result.files.isNotEmpty) {
//                 setState(() {
//                   cvFile = File(result?.files.first.path ?? '');
//                 });
//               }
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 124.h, vertical: 39.v),
//               decoration: AppDecoration.outlineGray300.copyWith(
//                 borderRadius: BorderRadiusStyle.roundedBorder24,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CustomImageView(
//                     imagePath: ImageConstant.imgCloudUpload1,
//                     height: 40.adaptSize,
//                     width: 40.adaptSize,
//                   ),
//                   SizedBox(height: 8.v),
//                   Text(
//                     "Upload File",
//                     style: CustomTextStyles.titleSmallSemiBold,
//                   ),
//                   if (cvFile != null)
//                     Text(
//                       'Selected CV: ${cvFile!.path}',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContinueButton() {
//     return CustomElevatedButton(
//       text: 'Continue',
//       onPressed: () async {
//         if (_formKey.currentState?.validate() ?? false) {
//           await _uploadCV();
//         }
//       },
//     );
//   }
// }
