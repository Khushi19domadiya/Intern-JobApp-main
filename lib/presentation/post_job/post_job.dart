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
  TextEditingController datePickerController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedRadio;
  String? _selectGender;
  List<String> _selectedItems = [];
  DateTime? selectedDate;
  String? _selectedOption;

  final userRepo = Get.put(UserRepository());

  @override
  Widget build(BuildContext context) {
    // Generate the document ID here
    String newDocumentId = FirebaseFirestore.instance.collection("postJob").doc().id;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 31.0),
                child: Column(
                  children: [
                    _buildInputField1(context),
                    SizedBox(height: 20.0),
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
                    _buildInputField(context),
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
        bottomNavigationBar: _buildContinueButton(context, newDocumentId),
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
          CustomTextFormField(
            controller: titleController,
            hintText: "Enter Job Title",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Job Title';
              } else if (!value.startsWith(RegExp(r'[A-Z]'))) {
                return 'Title should start with a capital letter';
              }
              return null;
            },
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the lowest salary';
              }
              // Convert the entered value to a double for comparison
              double salary = double.tryParse(value) ?? 0;
              if (salary < 0) {
                return 'Salary cannot be below 0';
              }
              if (value.length > 8) {
                return 'Salary cannot be more than 8 digits';
              }
              return null;
            },

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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the highest salary';
              }
              // Convert the entered value to a double for comparison
              double salary = double.tryParse(value) ?? 0;
              if (salary < 0) {
                return 'Salary cannot be below 0';
              }
              if (value.length > 8) {
                return 'Salary cannot be more than 8 digits';
              }
              return null;
            },
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
            maxLines: 6,
          ),
        ],
      ),
    );
  }

  String? _validateRadio() {
    if (_selectedRadio == null) {
      return 'Please select Job Type';
    }
    return null;
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
                    value: 'Full Time',
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
                    value: 'Part Time',
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
          if (_validateRadio() != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: Text(
              //   _validateRadio() ?? "",
              //   style: TextStyle(color: Colors.red),
              // ),
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

  String? _validateGender() {
    if (_selectGender == null) {
      return 'Please select Gender';
    }
    return null;
  }

  Widget _buildInputField(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Select a category", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.0),
          Container(
            width: double.infinity, // Set the width to fill the available space
            child: DropdownButton<String>(
              value: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
              items: <String>['Frontend', 'Backend', 'Database'] // Replace with your options
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
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
          if (_validateGender() != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: Text(
              //   _validateGender() ?? "",
              //   style: TextStyle(color: Colors.red),
              // ),

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
            textInputType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the experience';
              }
              // Use a regular expression to validate the numeric format
              RegExp regex = RegExp(r'^\d[0,50](\.\d[0,11])?$');
              // if (!regex.hasMatch(value)) {
              //   return 'Invalid experience format';
              // }
              return null;
            },
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
            textInputType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This is required';
              }
              return null;
            },
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
      firstDate: DateTime.now(), // Set the first date to the current date
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      if (picked.isBefore(DateTime.now())) {
        // Show an error message if the selected date is in the past
        CommonMethod().getXSnackBar("Error", "Please select a future date", red);
      } else {
        final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        setState(() {
          selectedDate = picked;
          datePickerController.text = formattedDate;
        });
      }
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

<<<<<<< HEAD
  Widget _buildContinueButton(BuildContext context) {



=======
  Widget _buildContinueButton(BuildContext context, String newDocumentId) {
>>>>>>> 2ab727349c9d1061f40b03ce2a3534336efe7eda
    return CustomElevatedButton(
      text: "POST",
      margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 40.v),
      onPressed: () async {
        // Validate the job type field
        if (_validateRadio() != null) {
          // If validation fails, show an error message
          CommonMethod().getXSnackBar("Error", _validateRadio() ?? "", red);
        } else if (_validateGender() != null) {
          // If validation fails, show an error message
          CommonMethod().getXSnackBar("Error", _validateGender() ?? "", red);
        }
        // Validate the select skills field
        else if (_selectedItems.isEmpty) {
          // If no skills are selected, show an error message
          CommonMethod().getXSnackBar(
              "Error", "Please select at least one skill", red);
        } else if (datePickerController.text.isEmpty) {
          // Show an error message if the deadline is empty
          CommonMethod().getXSnackBar(
              "Error", "Please select a deadline", red);
        }
        // Proceed with form validation if all previous validations pass
        else if (_formKey.currentState?.validate() ?? false) {
          // All fields are valid
          saveJobPost(
            id: newDocumentId, // Pass the document ID
            title: titleController.text,
            lowestsalary: lsalaryController.text,
            highestsalary: hsalaryController.text,
            address: addressController.text,
            experience: experienceController.text,
            about: aboutController.text,
            deadline: datePickerController.text,
            selectedSkills: _selectedItems,
            selectedOption: _selectedOption, // Pass the selected skills
          );

          // Redirect to the settings page only if all fields are valid
          Get.to(() => HomeContainerScreen());
        }
      },
    );
  }

  Future<void> saveJobPost({
    required String id, // Accept document ID as a parameter
    required String title,
    required String lowestsalary,
    required String highestsalary,
    required String address,
    required String experience,
    required String about,
    required String deadline,
    required List<String> selectedSkills,
    required String? selectedOption, // Add selected option parameter
  }) async {
    try {
      // Reference to the "postJob" collection
      CollectionReference jobCollection = FirebaseFirestore.instance.collection("postJob");

      User? currentUser = FirebaseAuth.instance.currentUser;

      PostJobModel job = PostJobModel(
        id: id, // Assign the document ID to the model
        title: title,
        lowestsalary: lowestsalary,
        highestsalary: highestsalary,
        address: address,
        experience: experience,
        about: about,
        deadline: deadline,
        jobType: _selectedRadio,
        gender: _selectGender,
        selectedSkills: selectedSkills,
        selectedOption: selectedOption, // Assign the selected option to the model
        userId: currentUser!.uid,
      );

      // Use the document ID as the ID for the document
      await jobCollection.doc(id).set(job.toJson());

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