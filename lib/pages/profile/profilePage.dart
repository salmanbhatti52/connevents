import 'dart:convert';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/user-model.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/edit-profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final regFormKey = GlobalKey<FormState>();
  PermissionStatus? _permissionStatus;
  Profile profile=Profile();
  var currentPassword="";
  bool isCurrentPasswordObscure = true;
  bool isNewPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  var   newPassword1="";
  TextEditingController confirmPassword=TextEditingController();
  TextEditingController newPassword=TextEditingController();
  TextEditingController oldPassword=TextEditingController();
    String? imagePath;
    String? email;
    String name="";

    UserDetail? user= AppData().userdetail;
    String? hint;
    Future profileImageUpdate(String image) async {
      print("hsash");
      print(image);
            print("hsash");
            print(AppData().userdetail!.users_id);
      openLoadingDialog(context, "updating");
      try {
        final response = await DioService.post('update_profile_picture', {
          "userId": AppData().userdetail!.users_id,
          "profilePicture": image
        });
        if (response['status'] == 'success') {
          Profile profile = Profile.fromJson(response);
          var userData = response['data']['user'] as List;
          List<UserDetail> userDetail = userData.map<UserDetail>((e) =>
              UserDetail.fromJson(e)).toList();
          print(userDetail.first.toJson());
          AppData().userdetail = userDetail.first;
          print(profile.hint_flag);
          AppData().profile = profile;
          print(AppData().profile!.hint_flag);
          Navigator.pop(context);
          showSuccessToast(
              "Your Profile Picture has been Updated Successfully ${AppData()
                  .userdetail!.user_name}");
          CustomNavigator.pushReplacement(context, TabsPage());
        }
        else if (response['status'] == 'error') {
          showErrorToast(response['message']);
        }
      }
       catch(e){
      Navigator.of(context).pop();
      showErrorToast("Something happened or check Your Internet Connection");
    }
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hint= AppData().profile!.hint_flag;
    //     () async {
    //   _permissionStatus = await Permission.storage.status;
    //   if (_permissionStatus != PermissionStatus.granted) {
    //     PermissionStatus permissionStatus= await Permission.storage.request();
    //     setState(() {
    //       _permissionStatus = permissionStatus;
    //     });
    //   }
    // }();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.chevron_left,),
                  Text(' Back', style: TextStyle(color: globalGreen, fontSize: 16,),),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: globallightbg,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: regFormKey,
            child: Container(
              padding: EdgeInsets.all(padding * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      EditProfileImagePicker(
                      previousImage: AppData().userdetail!.profile_picture,
                        onImagePicked: (PickedFile value)async{
                             final   fileaa = value.readAsBytes();
                            this.imagePath = base64Encode(await fileaa);
                            print(imagePath);
                            profileImageUpdate(imagePath!);
                        },
                      ),
                      SizedBox(width: padding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppData().userdetail!.first_name! + " ${AppData().userdetail!.last_name!}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: globalBlack,),),
                          Text(AppData().userdetail!.user_name!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: globalGreen,overflow: TextOverflow.clip),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: padding * 1.5,),
                  Container(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name', style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600,),),
                        SizedBox(height: padding / 2,),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: globalLGray,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue: AppData().userdetail!.first_name! + " ${AppData().userdetail!.last_name!}"  ,
                            // validator: (val) => val!.isEmpty ? "Please Enter your First Name" : null,
                            onSaved: (val) =>setState(() => name = val!),
                            style: TextStyle(color: globalBlack, height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.person, color: globalGreen,),
                              hintText: 'Name',
                              hintStyle: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 14, height: 1.7, fontWeight: FontWeight.normal,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email', style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600,),),
                        SizedBox(height: padding / 2,),
                  user?.email == null ||  user!.email!.isEmpty ? Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: globalLGray,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                           // initialValue: AppData().userdetail!.email,
                         //   validator: (val) => val!.isEmpty ? "Please Enter your Email" : null,
                            onSaved: (val) =>setState(() =>email = val!),
                            style: TextStyle(color: globalBlack, height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: SvgPicture.asset('assets/icons/mail1.svg', fit: BoxFit.scaleDown, color: globalGreen,),
                              hintText: 'mail@example.com',
                              hintStyle: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 14, height: 1.7, fontWeight: FontWeight.normal,),
                            ),
                          ),
                        )

                      :
                      Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: globalLGray,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue: AppData().userdetail!.email,
                            enabled: false,
                          //  validator: (val) => val!.isEmpty ? "Please Enter your Email" : null,
                          //  onSaved: (val) =>setState(() =>user!.email = val!),
                            style: TextStyle(color: globalBlack, height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: SvgPicture.asset('assets/icons/mail1.svg', fit: BoxFit.scaleDown, color: globalGreen,),
                              hintText: 'mail@example.com',
                              hintStyle: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 14, height: 1.7, fontWeight: FontWeight.normal,),
                            ),
                          ),
                        )




                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User Name', style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600,),),
                        SizedBox(height: padding / 2,),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: globalLGray,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue: AppData().userdetail!.user_name,
                            enabled: false,
                            validator: (val) => val!.isEmpty ? "Please Enter your UserName" : null,
                            onSaved: (val) =>setState(() =>AppData().userdetail!.user_name = val!),
                            style: TextStyle(color: globalBlack, height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.person, color: globalGreen,),
                              hintText: 'example_user',
                              hintStyle: TextStyle(
                                color: globalBlack.withOpacity(0.5),
                                fontSize: 14,
                                height: 1.7,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: padding,),
                  Text('Change Password', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold,),),
                  SizedBox(height: padding * 2,),
                    Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Password', style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600,),),
                        SizedBox(height: padding / 2),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: globalLGray,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: oldPassword,
                           // initialValue: AppData().userdetail!.first_name,
                          validator: (val) {
                              if(val!.isNotEmpty  && newPassword.text.isEmpty && confirmPassword.text.isEmpty){
                                return "Please Input New Password or Confirm Password";
                              }
                              return null;
                          },
                            onSaved: (val) =>setState(() => currentPassword= val!),
                            obscureText: isCurrentPasswordObscure,
                            style: TextStyle(color: globalBlack, height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: SvgPicture.asset('assets/icons/lock.svg', fit: BoxFit.scaleDown, color: globalGreen,),
                              suffixIcon: IconButton(
                                onPressed: () =>setState(() =>isCurrentPasswordObscure = !isCurrentPasswordObscure ),
                                icon: SvgPicture.asset(isCurrentPasswordObscure  ? 'assets/icons/eye.svg'  : 'assets/icons/noeye.svg', width: 18,),
                              ),
                              hintText: 'Current Password',
                              hintStyle: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 14, height: 1.7, fontWeight: FontWeight.normal,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if(hint == "1")  Padding(
                    padding: const EdgeInsets.only(bottom:12.0),
                    child: Text("Your Temporary Password is 123456",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('New Password', style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600,),),
                        SizedBox(height: padding / 2,),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: globalLGray,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: newPassword,
                            onSaved: (val) =>setState(() =>newPassword1= val!),
                            obscureText: isNewPasswordObscure,
                            style: TextStyle(color: globalBlack, height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: SvgPicture.asset('assets/icons/lock.svg', fit: BoxFit.scaleDown, color: globalGreen,),
                              suffixIcon: IconButton(
                                onPressed: () =>setState(() =>isNewPasswordObscure = !isNewPasswordObscure),
                                icon: SvgPicture.asset(isNewPasswordObscure ? 'assets/icons/eye.svg' : 'assets/icons/noeye.svg', width: 18,),),
                              hintText: 'New Password',
                              hintStyle: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 14, height: 1.7, fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Confirm Password', style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600,),),
                        SizedBox(height: padding / 2,),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: globalLGray,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: confirmPassword,
                            obscureText: isConfirmPasswordObscure,
                            validator: (value){
                              if(confirmPassword.text!=newPassword.text){
                                  return "Password didn't match";
                              }
                              else return null;
                            },
                            style: TextStyle(color: globalBlack, height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: SvgPicture.asset('assets/icons/lock.svg', fit: BoxFit.scaleDown, color: globalGreen,),
                              suffixIcon: IconButton(
                                onPressed: () =>setState(() =>isConfirmPasswordObscure = !isConfirmPasswordObscure),
                                icon: SvgPicture.asset(isConfirmPasswordObscure ? 'assets/icons/eye.svg' : 'assets/icons/noeye.svg', width: 18,
                                ),
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 14, height: 1.7, fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: padding),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text('Cancel'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),),
                            ),
                          ),
                        ),
                        SizedBox(width: padding,),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextButton(
                              onPressed: () async{
                                  if (regFormKey.currentState!.validate()) {
                                    regFormKey.currentState!.save();
                                    openLoadingDialog(context, "updating..");
                                    var response = await DioService.post('update_profile', {
                                      "userId": AppData().userdetail!.users_id,
           if(email!="")              "userEmail":  email,
                                    if(name.isNotEmpty)
                                     "name": name.trimLeft(),
                                      "userOldPassword": currentPassword.isEmpty ? "" : currentPassword,
          if(newPassword1.isNotEmpty)  "userNewPassword": newPassword1,
if(confirmPassword.text.isNotEmpty)    "userConfirmPassword": confirmPassword.text
                                    });
                                    Navigator.pop(context);
                                    print(response);
                                    if(response['status']=='success') {
                                      var userData = response['data']['user'];
                                      Profile profile = Profile.fromJson(response);
                               List<UserDetail> userDetail = userData.map<UserDetail>((e) => UserDetail.fromJson(e)).toList();
                                         print("usersss ");
                                      print(profile.toJson());
                                         print("usersss ");
                                        AppData().userdetail = userDetail.first;
                                        AppData().profile = profile;
                                        print(AppData().userdetail!.toJson());
                                        showSuccessToast("Your Profile has been Updated");
                                        CustomNavigator.pushReplacement(context, TabsPage());
                                      // Navigator.pop(context);
                                    }
                                    else if(response['status']=='error')
                                    {
                                      showErrorToast(response['message']);
                                    }
                                  }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: globalGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text('Save'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
