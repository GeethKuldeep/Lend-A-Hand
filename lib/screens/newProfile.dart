import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';

import '../landing_page.dart';

class newProfile extends StatefulWidget {
  @override
  _newProfileState createState() => _newProfileState();
}

class _newProfileState extends State<newProfile> {
  TextEditingController custom1Controller =TextEditingController();
  TextEditingController custom2Controller =TextEditingController();
  final _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  List teams=[];
  bool there= false;
  String GrpId;
  List user_grps=[];
  bool teamthere =false;
  String teamcode;
  var data = new Map();
  var teamuid = Uuid();
  String username =" ";
  var _formkey = GlobalKey<FormState>();
  int toogle =0;
  var grp_messages = new Map();
  List requests_type = [];
  List emergency_1=[];
  int requests_type_number=0;
  List accepted_type = [];
  List emergency_2=[];
  int accepted_type_number=0;
  bool verified =false;
  List group_members=[];
  Color color3 = Color(0xFFFE9C1ED);
  Color color1 = Color(0xffA99CF0);
  Color color2 = Color(0xffF2F9FC);
  Color color4 = Color(0xffCACEF1);
  Color color5 = Color(0xffE9C1ED);
  Color color6 = Color(0xffD3AAEA);
  Color color7 = Color(0xff93DEF1);
  var list = [
    Color(0xff93DEF1),
    Color(0xffA99CF0),
    Color(0xffD3AAEA),
    Color(0xffE9C1ED)
  ];
  Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }
  double displayWidth(BuildContext context) {
    debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }

  Future<String> createAlertDialog(BuildContext context){
    TextEditingController customController =TextEditingController();
    return showDialog(context: context,builder:  (context){
      return AlertDialog(
        title: Text("Enter details",style:TextStyle(color:Colors.blue)),
        content:Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter the Group name',
                contentPadding: const EdgeInsets.all(8.0),
                errorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: color1,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color1,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color1,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                errorStyle: TextStyle(
                  color: color1,
                ),
              ),
              autocorrect: false,
              keyboardType: TextInputType.text,
              controller: custom2Controller,
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5.0,
                  child: Text('Create',style:TextStyle(color:Colors.black)),
                  color: color1,
                  onPressed: () {
                    create_team();
                    Navigator.of(context).pop(customController.text.toString());
                    createAlertDialog_teamcode(context);

                  }
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.18,
              ),
            ],
          ),

        ],
      );
    });

  }

  Future<String> createAlertDialog_teamcode(BuildContext context){
    return showDialog(context: context,builder:  (context){
      return AlertDialog(
        title: Text("Your Teamcode is ${teamcode}",style:TextStyle(color:Colors.blue)),
      );
    });

  }

  Future<String> createAlertDialog_display(BuildContext context){
    return showDialog(context: context,builder:  (context){
      return AlertDialog(
        backgroundColor: color4,
        title: Center(child: Text("Join a Community",style:TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold))),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formkey,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter a valid code';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    style: GoogleFonts.rambla(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: ' Enter the code',
                      contentPadding: const EdgeInsets.all(8.0),

                      errorBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: color1,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),

                      focusColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: color1,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),


                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: color1,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),

                      errorStyle: TextStyle(
                          color: Colors.white,fontSize: 15
                      ),
                    ),
                    autocorrect: false,
                    controller: custom1Controller,

                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 40,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: color1,
                    child: Text('Join',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight:FontWeight.bold),),
                    onPressed: (){
                      if (_formkey.currentState.validate() == true) {
                        jointeam();
                        print(teams);
                        print(data);
                        Navigator.of(context).pop(custom1Controller.text.toString());
                      }

                    }),
              ),

            ],
          ),
        ),
      );
    });

  }

  getdata()async{
    await firestoreInstance.collection("Group_Messages").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        grp_messages[result.id]=result.data();
      });
      print(grp_messages);
    });
    await firestoreInstance.collection("GroupInfo").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        group_members= result.data()["members"];
        print("HELP");
        print("Group members are ${group_members}");
        print("PLEASE");

      });
      //print(grp_messages);
    });
    verify();
    process_data();
    //print(emergency_type_1);
  }

  process_data(){
    grp_messages.forEach((key, value) {
      //print(value["Emergency"]);
      if(value['from_ID'] == auth.currentUser.uid && verified == true){
        emergency_1.add(value["Emergency"]);
        emergency_1.add(value["message"]);
        emergency_1.add(value["from_ID"]);
        emergency_1.add(value["from_name"]);
        requests_type.add(emergency_1);
        emergency_1=[];
        print("hello");
        print(requests_type);
        print("hello");
      }
      if(value['acceptedBY'] == auth.currentUser.uid&& verified == true ){
        emergency_2.add(value["Emergency"]);
        emergency_2.add(value["message"]);
        emergency_2.add(value["from_ID"]);
        emergency_2.add(value["from_name"]);
        accepted_type.add(emergency_2);
        emergency_2=[];
        print("hello");
        print(accepted_type);
        print("hello");
      }
    });
    setState(() {
      accepted_type_number= accepted_type.length;
      print(accepted_type_number);
    });
    setState(() {
      requests_type_number= requests_type.length;
      print(requests_type_number);
    });
  }

  verify(){
    for(var i=0;i<group_members.length;i++){
      if(auth.currentUser.uid == group_members[i]){
        setState(() {
          verified =true;
        });
      }
    }
  }

  get_teams_data()async{
    await firestoreInstance.collection("GroupInfo").get().then((querySnapshot)  {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        setState(() {
          GrpId= result['GrpID'];
          teams.add(result['GrpID']);
          print(result['members']);
          data[GrpId]= result['members'];
          print('hello');
          print(data);
        });
      });
    });
    await firestoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        if(result['ID'] == auth.currentUser.uid ){
          setState(() {
            username= result['username'];
            for(var i =0 ;i< result['Groups'].length;i++){
              user_grps.add(result['Groups'][i]);
              print("fresh ${user_grps}");
            }
          });
        }

      });
    });
    await firestoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if(result['ID'] == auth.currentUser.uid){

        }
        print(result.data());
      });
    });

  }

  jointeam(){
    for(var i=0;i< teams.length;i++){
      if(custom1Controller.text == teams[i]){
        for(var j =0 ;j< data[custom1Controller.text].length;j++){
          if( auth.currentUser.uid== data[custom1Controller.text][j])
          {
            setState(() {
              there = true;
            });
            print('Already there');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Already joined !'),
              ),
            );
          }
        }
        for(var i=0;i< user_grps.length;i++){
          if(custom1Controller.text == user_grps[i]){
            setState(() {
              teamthere=true;
            });
          }
        }
        if(there == false && teamthere ==false){
          setState(() {
            data[custom1Controller.text].add(auth.currentUser.uid);
            user_grps.add(custom1Controller.text);
          });
          print(user_grps);
          print('user added to team ${custom1Controller.text}');
          update_user_in_teams();
          //print('members array updated in firestore to ${teammembers}');
        }
      }
    }
  }

  update_user_in_teams(){

    firestoreInstance.collection("users").doc(auth.currentUser.uid).update({"Groups": user_grps}).then((_) {
      print("Sucessfully added grp to user ${auth.currentUser.uid}");
    });
    firestoreInstance.collection("GroupInfo").doc(custom1Controller.text).update({"members": data[custom1Controller.text]  }).then((_) {
      print("Sucessfully added member to grp ${custom1Controller.text}");
    });
  }

  create_team() async{
    create_teamcode();
    firestoreInstance.collection("GroupInfo").doc(teamcode).set(
        {
          "GrpID" : teamcode,
          "adminID" : auth.currentUser.uid,
          "adminName" : username,
          "createdAt" : Timestamp.now(),
          'groupName':custom2Controller.text,
          'members': [auth.currentUser.uid],
          "recent_messages" : {}
        }).then((_)async{
      setState(() {
        user_grps.add(teamcode);
      });
      await firestoreInstance.collection("users").doc(auth.currentUser.uid).update({"Groups": user_grps}).then((_) {
        print("Sucessfully added new grp ${teamcode} to user ${auth.currentUser.uid}");
      });
      print("success!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Group created successfully"),
        ),
      );
    });



  }

  create_teamcode(){
    var result = teamuid.v1();
    int startIndex = 0;
    int endIndex = 7;
    setState(() {
      teamcode = result.substring(startIndex, endIndex);
    });

    print(teamcode);
  }

  @override
  void initState() {
    get_teams_data();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color2,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: color1,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(55),
                          bottomRight: Radius.circular(55))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 78.0),
                                child: IconButton(
                                    icon: Icon(Icons.group_add,size: 45,),
                                    color: Colors.white,
                                    iconSize: 30,
                                    onPressed: () async{
                                      createAlertDialog_display(context);

                                    }),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                  height: 95,
                                  width: 95,
                                  child: Image.asset('images/2.png')),
                              Text(
                                username,
                                style: TextStyle(
                                    fontSize: 28, color: Colors.white),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 78.0),
                                child: IconButton(
                                    icon: Icon(Icons.logout,size:35),
                                    color: Colors.white,
                                    iconSize: 30,
                                    onPressed: () async{
                                      await _auth.signOut();
                                      Navigator.pushReplacementNamed(context, LandingPage.id);
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if(verified==true)
                      Text(
                        'LEGO Community',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    if(verified==false)
                      Text(
                        'Join a Community',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ToggleSwitch(
                      minWidth: 80.0,
                      minHeight: 28,
                      cornerRadius: 10.0,
                      fontSize: 12,
                      activeBgColor: color1,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.white,
                      inactiveFgColor: color1,
                      labels: ['community', 'request'],
                      onToggle: (index) {
                        setState(() {
                          toogle =index;
                        });

                        print('switched to: $toogle');
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: 15,
                ),
                if(toogle == 0)
                  if(verified==true)
                    Expanded(
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext ctxt, int Index) {
                            return FlatButton(
                              onPressed: (){
                                Navigator.pushReplacementNamed(context, LandingPage.id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color:  color3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, bottom: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset('images/1.png',scale: 0.8,),
                                        Text(
                                          'LEGO Community',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(Icons.arrow_forward_sharp,color: Colors.white,)

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                if(verified==false)
                  Expanded(child: Center(child: Text('No Communities'))),
                if(toogle == 1)
                  if(verified==true)
                    Expanded(
                      child: ListView.builder(
                          itemCount: requests_type_number,
                          itemBuilder: (BuildContext ctxt, int Index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color:list[Index],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              if(requests_type[Index][0]== "1")
                                                Icon(Icons.medical_services_outlined,size:35,color:Colors.white),
                                              if(requests_type[Index][0]== "2")
                                                Icon(Icons.local_fire_department,size:35,color:Colors.white),
                                              if(requests_type[Index][0]== "3")
                                                Icon(Icons.add_shopping_cart,size:35,color:Colors.white),
                                              if(requests_type[Index][0]== "4")
                                                Image.asset('images/1.png',scale: 0.8,),
                                              SizedBox(width: displayWidth(context)*0.1,),
                                              Text(
                                                requests_type[Index][1],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Icon(Icons.arrow_forward_sharp,color: Colors.white,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );

                          }),
                    ),
                if(verified==false)
                  Expanded(child: Center(child: Text('No Communities'))),

              ],
            ),
            Positioned(
              top: 150,
              left: 12,
              right: 12,
              child: Container(
                width: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white ,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.5,right: 8.5,top: 5,bottom: 5),
                            child: Column(
                              children: [
                                Text(
                                  '${requests_type_number}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Requested',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white ,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.5,right: 8.5,top: 5,bottom: 5),
                            child: Column(
                              children: [
                                Text(
                                  '${accepted_type_number}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Assisted',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white ,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.5,right: 8.5,top: 5,bottom: 5),
                            child: Column(
                              children: [
                                Text(
                                  '35',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Points',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        FlatButton(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: color1 ,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.5,right: 8.5,top: 5,bottom: 5),
                              child: Column(
                                children: [
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Rank',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
