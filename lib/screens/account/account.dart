import 'package:flutter/material.dart';
import 'file:///D:/Study/DoAn2/project_papillio/lib/components/appbar.dart';
import 'package:project_papillio/components/header.dart';
import 'package:project_papillio/components/rounded_button.dart';
import 'package:project_papillio/components/text_field_container.dart';
import 'package:project_papillio/models/user.dart';
import 'package:project_papillio/services/storage_services.dart';
import 'package:project_papillio/services/user_services.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String newFirstName='', newLastName='', newPhoneNum='', newProfilePhoto='',
      newJob='', newWorkplace='';

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context) ?? null;
    final size = MediaQuery.of(context).size;

    if (newFirstName.isEmpty)
      newFirstName = userData.firstName;
    if (newLastName.isEmpty)
      newLastName = userData.lastName;
    if (newPhoneNum.isEmpty)
      newPhoneNum = userData.phoneNum;
    if (newJob.isEmpty)
      newJob = userData.job;
    if (newWorkplace.isEmpty)
      newWorkplace = userData.workplace;

    if (userData != null)
      return Scaffold(
        appBar: appBar('Profile'),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Header(height: MediaQuery.of(context).size.height * 0.3 + 15),
            Container(
              margin: EdgeInsets.only(top: 150),
              height: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: materialColor[50],
                borderRadius: BorderRadius.only(topRight: Radius.circular(35),
                    topLeft: Radius.circular(35),
              ),
            ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 55),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: TextFieldContainer(
                            color: materialColor[150],
                            size: size.width * 0.4,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  newFirstName = value;
                                  print(newFirstName);
                                  print(newLastName);
                                });
                              },
                              initialValue: userData.firstName,
                              cursorColor: materialColor[500],
                              decoration: InputDecoration(
                                hintText: 'First name',
                                border: InputBorder.none,
                              ),
                            )
                          ),
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                        ),
                        Padding(
                          child: TextFieldContainer(
                              color: materialColor[150],
                              size: size.width * 0.4,
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    newLastName = value;
                                    print(newFirstName);
                                    print(newLastName);
                                  });
                                },
                                initialValue: userData.lastName,
                                cursorColor: materialColor[500],
                                decoration: InputDecoration(
                                  hintText: 'Last name',
                                  border: InputBorder.none,
                                ),
                              )
                          ),
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: TextFieldContainer(
                              color: materialColor[150],
                              size: size.width * 0.4,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) { setState(() => newPhoneNum = value );},
                                initialValue: userData.phoneNum,
                                cursorColor: materialColor[500],
                                decoration: InputDecoration(
                                  hintText: 'Phone number',
                                  border: InputBorder.none,
                                ),
                              )
                          ),
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                        ),
                        Padding(
                          child: TextFieldContainer(
                              color: materialColor[150],
                              size: size.width * 0.4,
                              child: TextFormField(
                                onChanged: (value) { setState(() => newJob = value );},
                                initialValue: userData.job,
                                cursorColor: materialColor[500],
                                decoration: InputDecoration(
                                  hintText: 'Occupation',
                                  border: InputBorder.none,
                                ),
                              )
                          ),
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                        ),
                      ],
                    ),
                    Padding(
                      child: TextFieldContainer(
                          color: materialColor[150],
                          size: size.width * 0.84,
                          child: TextFormField(
                            onChanged: (value) { setState(() => newWorkplace = value );},
                            initialValue: userData.workplace,
                            cursorColor: materialColor[500],
                            decoration: InputDecoration(
                              hintText: 'Workplace',
                              border: InputBorder.none,
                            ),
                          )
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                          child: RoundedButton(
                            color: Colors.grey,
                            text: 'Cancel',
                            size: size.width * 0.4,
                            onPress: () { Navigator.pop(context); },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                          child: RoundedButton(
                            color: materialColor[500],
                            text: 'Save',
                            size: size.width * 0.4,
                            onPress: () async {
                              await UserServices(uid: userData.uid).createUserData(newFirstName, newLastName, newPhoneNum, newJob, newWorkplace, null, 'u', 'a');
                              print('hmmm');
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 70,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/icons/profile.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              )
            ),
          ],
        ),
      );
    else {
      return Scaffold();
    }
  }
}

