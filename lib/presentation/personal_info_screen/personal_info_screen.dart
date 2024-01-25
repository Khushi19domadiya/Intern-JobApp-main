import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/models/personal_information.dart';
import 'package:saumil_s_application/presentation/personal_info_screen/selectImage.dart';
import 'package:saumil_s_application/util/common_methos.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_text_form_field.dart';
import 'selectImage.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../user_repository/user_repository.dart';
import '../../util/colors.dart';
import '../settings_screen/settings_screen.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({Key? key}) : super(key: key);

  Uint8List? _image;

  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);

      _image = img;

  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userRepo = Get.put(UserRepository());

  var collection = FirebaseFirestore.instance.collection("personalinfo");
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(height: 32.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 24.h,
                        right: 24.h,
                        bottom: 5.v,
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              _image != null ?
                                  CircleAvatar(
                                      radius: 64,
                                      backgroundImage: MemoryImage(_image!),
                                  )
                              :
                              CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://icons.iconarchive.com/icons/papirus-team/papirus-status/512/avatar-default-icon.png'),
                              ),
                              Positioned(
                                child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                                bottom: -10,
                                left: 80,
                              ),
                            ],
                          ),
                          _buildPersonalInfoFirstName(context),
                          SizedBox(height: 18.v),
                          _buildPersonalInfoLastName(context),
                          SizedBox(height: 18.v),
                          _buildPersonalInfoEmail(context),
                          SizedBox(height: 18.v),
                          _buildPersonalInfoPhone(context),
                          SizedBox(height: 18.v),
                          _buildPersonalInfoLocation(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildSaveChanges(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgComponent1,
        margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
        onTap: () {
          onTapImage(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Personal Info"),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgEditSquare,
          margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoFirstName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("First Name", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.v),
        CustomTextFormField(
          controller: firstNameController,
          hintText: "Enter Your First Name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your first name';
            } else if (!value.startsWith(RegExp(r'[A-Z]'))) {
              return 'First name should start with a capital letter';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPersonalInfoLastName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Last Name", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.v),
        CustomTextFormField(
          controller: lastNameController,
          hintText: "Enter Your Last Name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your last name';
            } else if (!value.startsWith(RegExp(r'[A-Z]'))) {
              return 'Last name should start with a capital letter';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPersonalInfoEmail(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.v),
        CustomTextFormField(
          controller: emailController,
          hintText: "xyz@gmail.com",
          textInputType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!GetUtils.isEmail(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPersonalInfoPhone(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Phone ", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.v),
        CustomTextFormField(
          controller: phoneController,
          hintText: "9876543210",
          textInputType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            } else {
              // Use a regular expression to validate the phone number
              RegExp regex = RegExp(r'^[6-9]\d{9}$');
              if (!regex.hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPersonalInfoLocation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Address", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.v),
        CustomTextFormField(
          controller: locationController,
          hintText: "Enter your Address",
          textInputAction: TextInputAction.done,
          maxLines: 6,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSaveChanges(BuildContext context) {
    return CustomElevatedButton(
      text: "Save Changes",
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          // All fields are valid, proceed with saving
          saveProfileInfo(
            firstname: firstNameController.text,
            lastname: lastNameController.text,
            email: emailController.text,
            phoneno: phoneController.text,
            address: locationController.text,
          );

          // Redirect to the settings page only if all fields are valid
          Get.to(() => SettingsScreen());
        }
      },
      margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 44.v),
      buttonStyle: CustomButtonStyles.fillGrayTL24,
      buttonTextStyle: CustomTextStyles.titleMediumGray50001,
    );
  }

  Future<void> saveProfileInfo({
    required String firstname,
    required String lastname,
    required String email,
    required String phoneno,
    required String address,
  }) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      InfoModel profile = InfoModel(
        id: userId,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phoneno: int.tryParse(phoneno) ?? 0,
        address: address,
      );

      // Save the profile information to Firestore
      await FirebaseFirestore.instance
          .collection("personalinfo")
          .doc(userId)
          .set(profile.toJson());

      await CommonMethod()
          .getXSnackBar("Success", 'Profile Info Saved Successfully', success)
          .whenComplete(() => Get.to(() => SettingsScreen()));
    } catch (e) {
      await CommonMethod().getXSnackBar(
        "Error",
        'Profile Info Not Saved',
        red,
      );
    }
  }

  // Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }
}
