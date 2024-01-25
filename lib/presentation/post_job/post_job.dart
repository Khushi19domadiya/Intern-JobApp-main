import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/home_container_screen/home_container_screen.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_text_form_field.dart';
import 'package:saumil_s_application/presentation/apply_job_popup_dialog/apply_job_popup_dialog.dart';

import '../../models/user_model.dart';
import '../../user_repository/user_repository.dart';
import '../../util/colors.dart';
import '../../util/common_methos.dart';


class PostJob extends StatefulWidget {
  const PostJob({Key? key}) : super(key: key);

  @override
  _PostJobState createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {
  TextEditingController titleController = TextEditingController();
  TextEditingController lsalaryController = TextEditingController();
  TextEditingController hsalaryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController datePickerController= TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedRadio;
  String? _selectGender;

  List<String> _selectedItems = [];

  DateTime? selectedDate;


  final userRepo = Get.put(UserRepository());

  var collection = FirebaseFirestore.instance.collection("personalinfo");
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 31.v),
                child: Column(
                  children: [
                    _buildInputField1(context),
                    SizedBox(height: 20.v),
                    _buildInputField2(context),
                    SizedBox(height: 20.v),
                    _buildInputField3(context),
                    SizedBox(height: 20.v),
                    _buildInputField4(context),
                    SizedBox(height: 20.v),
                    _buildInputField5(context),
                    SizedBox(height: 20.v),
                    _buildInputField6(context),
                    SizedBox(height: 20.v),
                    _buildInputField7(context),
                    SizedBox(height: 20.v),
                    _buildInputField8(context),
                    SizedBox(height: 20.v),
                    _buildInputField9(context),
                    SizedBox(height: 20.v),
                    _buildDatePicker(context),
                    SizedBox(height: 1.v),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildContinueButton(context),
      ),
    );
  }

  Widget _buildInputField1(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(            controller: titleController,
            hintText: "Enter Job Title",
          ),
        ],
      ),
    );
  }

  Widget _buildInputField2(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Lowest Salary", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
            controller: lsalaryController,
            hintText: "Enter your lowest salary",
            textInputType: TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField3(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Highest Salary", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
            controller: hsalaryController,
            hintText: "Enter your highest salary",
            textInputType: TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField4(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Address", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
            controller: addressController,
            hintText: "address",
            textInputType: TextInputType.text,
            maxLines: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField5(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Job Type", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Radio(
                    value: 'Full Time', // Change value to string
                    groupValue: _selectedRadio,
                    onChanged: (value) {
                      _handleRadioValueChange(value.toString());
                    },
                  ),
                  Text('Full Time'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'Part Time', // Change value to string
                    groupValue: _selectedRadio,
                    onChanged: (value) {
                      _handleRadioValueChange(value.toString());
                    },
                  ),
                  Text('Part Time'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField6(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Select Skills", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.0),
          InkWell(
            onTap: () {
              _showMultiSelect(context);
            },
            child: InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Your Skills"),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  void _showMultiSelect(BuildContext context) async {
    List<String> items = [
      'HTML',
      'CSS',
      'JavaScript',
      'Python',
      'Java',
      'C',
      'C++',
      'PHP',
      'Flutter',
      'Node JS',
      'React Native',
      'Kotlin/Java(Android)',
      'Swift(IOS)',
      'MySQL',
    ];

    List<bool> selectedItems = List.generate(items.length, (index) => _selectedItems.contains(items[index]));

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void _handleCheckboxChange(int index, bool value) {
              setState(() {
                selectedItems[index] = value;
                if (value) {
                  _selectedItems.add(items[index]);
                } else {
                  _selectedItems.remove(items[index]);
                }
              });
            }

            return AlertDialog(
              title: Text("Select Skills"),
              content: Container(
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      title: Text(items[index]),
                      value: selectedItems[index],
                      onChanged: (bool? value) {
                        if (value != null) {
                          _handleCheckboxChange(index, value);
                        }
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog without returning a value
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildInputField7(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Gender", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Radio(
                    value: 'Male', // Change value to string
                    groupValue: _selectGender,
                    onChanged: (value) {
                      _handleGender(value.toString());
                    },
                  ),
                  Text('Male'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'Female', // Change value to string
                    groupValue: _selectGender,
                    onChanged: (value) {
                      _handleGender(value.toString());
                    },
                  ),
                  Text('Female'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildInputField8(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Experience", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
            controller: experienceController,
            hintText: "Experience",
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField9(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
            controller: aboutController,
            hintText: "About",
            textInputType: TextInputType.emailAddress,
            maxLines: 4,
          ),
          SizedBox(height: 1.v),
        ],
      ),
    );
  }


  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        selectedDate = picked;
        datePickerController.text = formattedDate;
      });
    }
  }

  @override
  Widget _buildDatePicker(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 8.0),
            child: Text("Deadline", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: InkWell(
              onTap: () => _selectDate(),
              child: Container(
                height: 48.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        datePickerController.text,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(Icons.calendar_today, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildContinueButton(BuildContext context) {
    return CustomElevatedButton(
        text: "POST",
        margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 40.v),
        onPressed: () async {
          saveJobPost(
            title: titleController.text,
            lowestsalary: lsalaryController.text,
            highestsalary: hsalaryController.text,
            address: addressController.text,
            experience: experienceController.text,
            about: aboutController.text,
            deadline: datePickerController.text,
            selectedSkills: _selectedItems, // Pass the selected skills
          );

          // Redirect to the settings page only if all fields are valid
          Get.to(() => HomeContainerScreen());
        }
    );
  }

  Future<void> saveJobPost({
    required String title,
    required String lowestsalary,
    required String highestsalary,
    required String address,
    required String experience,
    required String about,
    required String deadline,
    required List<String> selectedSkills, // Add this parameter for selected skills
  }) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      postjobModel job = postjobModel(
        id: userId,
        title: title,
        lowestsalary: lowestsalary,
        highestsalary: highestsalary,
        address: address,
        experience: experience,
        about: about,
        deadline: deadline,
        jobType: _selectedRadio,
        gender: _selectGender,
        selectedSkills: selectedSkills, // Include the selected skills
      );

      // Save the profile information to Firestore
      await FirebaseFirestore.instance
          .collection("postJob")
          .doc(userId)
          .set(job.toJson());

      await CommonMethod()
          .getXSnackBar("Success", 'Job posted successfully', success)
          .whenComplete(() => Get.to(() => HomeContainerScreen()));
    } catch (e) {
      await CommonMethod().getXSnackBar(
        "Error",
        'Job not posted',
        red,
      );
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 51.v,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgComponent1,
        margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 14.v),
        onTap: () {
          onTapImage(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Post Job"),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgComponent3,
          margin: EdgeInsets.fromLTRB(16.h, 13.v, 16.h, 14.v),
        ),
      ],
    );
  }

  // Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  // Displays a dialog with the [ApplyJobPopupDialog] content.
  onTapContinueButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: ApplyJobPopupDialog(),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.only(left: 0),
      ),
    );
  }

  // Handle radio button value changes
  void _handleRadioValueChange(String value) {
    setState(() {
      _selectedRadio = value;
    });
  }

  void _handleGender(String value) {
    setState(() {
      _selectGender = value;
    });
  }
}