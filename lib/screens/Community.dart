
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'Daily.dart';
import 'Lets.dart';
import 'Medical.dart';
import 'Safety.dart';



class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

  var color1 = Color(0xFFF2F9FC);
  var color2 = Color(0xFFFA99CF0);
  var color3 = Color(0xFFF93DEF1);
  var color4 = Color(0xFFFD3AAEA);
  var color5 = Color(0xFFFE9C1ED);
  var color6 = Color(0xFFFCACEF1);
  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var grp_messages = new Map();
  List emergency_type_1 = [];
  List emergency_1=[];
  List emergency_type_2 = [];
  List emergency_2=[];
  List emergency_type_3 = [];
  List emergency_3=[];
  List emergency_type_4 = [];
  List emergency_4=[];
  int emergency_1_and_2 = 0;
  int emergency_1_number = 0;
  int emergency_2_number = 0;
  int emergency_3_number = 0;
  int emergency_4_number = 0;
  int accepted = 0;
  List group_members=[];
  List emergency_type_1_2 = [];
  List emergency_1_2=[];
  List acceptedrequests=[];
  List acceptedrequets_type=[];
  var data;
  bool verified =false;

  Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }
  double displayWidth(BuildContext context) {
    debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }

  @override
  void initState() {

    getdata();
    super.initState();
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
  getdata()async{
    await firestoreInstance.collection("Group_Messages").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        grp_messages[result.id]=result.data();
      });
      //print(grp_messages);
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
      print(value["Emergency"]);
      if(value['acceptedBY']==auth.currentUser.uid && verified == true ){
        acceptedrequests.add(value["message"]);
        acceptedrequests.add(value["from_name"]);
        acceptedrequets_type.add(acceptedrequests);
        acceptedrequests=[];
        print(acceptedrequets_type);
      }
      if(value['Emergency'] == '1'&& value['from_ID'] != auth.currentUser.uid && value['Status'] != 'accepted'&& verified == true ){
        emergency_1.add(value["message"]);
        emergency_1.add(value["time"]);
        emergency_1.add(value["from_ID"]);
        emergency_1.add(value["from_name"]);
        emergency_type_1.add(emergency_1);
        emergency_1=[];
        print(emergency_type_1);
      }
      if(value['Emergency'] == '2'&& value['from_ID'] != auth.currentUser.uid && value['Status'] != 'accepted'&& verified == true ){
        emergency_2.add(value["message"]);
        emergency_2.add(value["time"]);
        emergency_2.add(value["from_ID"]);
        emergency_2.add(value["from_name"]);
        emergency_type_2.add(emergency_2);
        emergency_2=[];
        print(emergency_type_2);
      }
      if(value['Emergency'] == '3'&& value['from_ID'] != auth.currentUser.uid && value['Status'] != 'accepted'&& verified == true ){
        emergency_3.add(value["message"]);
        emergency_3.add(value["time"]);
        emergency_3.add(value["from_ID"]);
        emergency_3.add(value["from_name"]);
        emergency_type_3.add(emergency_3);
        emergency_3=[];
        print(emergency_type_3);
      }
      if(value['Emergency'] == '4'&& value['from_ID'] != auth.currentUser.uid && value['Status'] != 'accepted'&& verified == true ){
        emergency_4.add(value["message"]);
        emergency_4.add(value["time"]);
        emergency_4.add(value["from_ID"]);
        emergency_4.add(value["from_name"]);
        emergency_type_4.add(emergency_4);
        emergency_4=[];
        print(emergency_type_4);
      }
      if(value['Emergency'] == '1' || value['Emergency'] =='2' ){
        if(value['from_ID'] != auth.currentUser.uid && value['Status'] != 'accepted'&& verified == true ){
          emergency_1_2.add(value["Emergency"]);
          emergency_1_2.add(value["message"]);
          emergency_1_2.add(value["time"]);
          emergency_1_2.add(value["from_ID"]);
          emergency_1_2.add(value["from_name"]);
          emergency_type_1_2.add(emergency_1_2);
          emergency_1_2=[];
          print(emergency_type_1_2);
        }

      }
    });
    setState(() {
      emergency_1_and_2= emergency_type_1.length + emergency_type_2.length;
      print(emergency_1_and_2);
    });
    setState(() {
      emergency_1_number= emergency_type_1.length ;
      print(emergency_1_number);
    });setState(() {
      emergency_2_number= emergency_type_2.length ;
      print(emergency_2_number);
    });
    setState(() {
      emergency_3_number= emergency_type_3.length ;
      print(emergency_3_number);
    });
    setState(() {
      emergency_4_number= emergency_type_4.length ;
      print(emergency_4_number);
    });
    setState(() {
      accepted= acceptedrequets_type.length ;
      print(accepted);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body:  SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(verified == true)
                  Center(child: Text(
                      "LEGO Community",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                if(verified == false)
                  Center(child: Text(
                      "Join a Community",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),

                SizedBox(height: displayWidth(context)*0.04,),
                if(verified == true)
                  Expanded(
                    flex:2,
                    child: ListView.builder(
                        itemCount: emergency_1_and_2,
                        itemBuilder: (BuildContext ctxt, int Index){
                          return FlatButton(
                            onPressed: (){
                              if(emergency_type_1_2[Index][0] == '1'){
                                Navigator.pushNamed(context, Medical.id);
                              }else{
                                Navigator.pushNamed(context, Safety.id);
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: emergency_type_1_2[Index][0] == '1' ? color2 : color3,
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(emergency_type_1_2[Index][0] == '1' ?  Icons.medical_services_outlined : Icons.local_fire_department,size:35,color:Colors.white ),
                                            SizedBox(width: displayWidth(context)*0.1,),
                                            Text(emergency_type_1_2[Index][0] == '1' ? emergency_type_1_2[Index][1] : emergency_type_1_2[Index][1],style:TextStyle(fontSize: 18,color:Colors.white)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(Icons.arrow_forward_sharp,color:Colors.white),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                if(verified == false)
                  Expanded(child: Center(child: Text('No Important Requests'))),
                Text("Accepted Requests",style:TextStyle(fontSize: 25)),
                SizedBox(height: 15,),
                if(verified == true)
                  Expanded(
                    flex:1,
                    child: ListView.builder(
                        itemCount: accepted,
                        itemBuilder: (BuildContext ctxt, int Index){
                          return  Padding(
                            padding: const EdgeInsets.only(left:100.0,right: 100.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(acceptedrequets_type[Index][0],style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                        SizedBox(height: 10,),
                                        Text(acceptedrequets_type[Index][1],style:TextStyle(fontSize: 12)),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Icon(Icons.message,color: color6,),
                                            SizedBox(width: 10,),
                                            Icon(Icons.call,color:color6),                        ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(Icons.medical_services_outlined,size: 50,color:color6),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );


                        }
                    ),
                  ),
                if(verified == false)
                  Expanded(child: Center(child: Text('No Accepted Requests'))),
                Text("Community Requests",style:TextStyle(fontSize: 25)),
                SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: 185,
                              height: 145,
                              child: FlatButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, Medical.id);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${emergency_1_number}',style:TextStyle(color: color6)),
                                            Icon(Icons.notifications,color: color6,)
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Row(
                                          children: [
                                            Text("Medical\nEmergency",style:TextStyle(color: color2,fontWeight: FontWeight.bold,fontSize: 15))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25,),
                            SizedBox(
                              width: 185,
                              height: 145,
                              child: FlatButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, Daily.id);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${emergency_3_number}',style:TextStyle(color: color6)),
                                            Icon(Icons.notifications,color: color6,)
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Row(
                                          children: [
                                            Text("Daily\nEssentials",style:TextStyle(color: color4,fontWeight: FontWeight.bold,fontSize: 15))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 185,
                              height: 145,
                              child: FlatButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, Safety.id);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${emergency_2_number}',style:TextStyle(color: color6)),
                                            Icon(Icons.notifications,color: color6,)
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Row(
                                          children: [

                                            Text("Safety\n&Security",style:TextStyle(color: color3,fontWeight: FontWeight.bold,fontSize: 15))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25,),
                            SizedBox(
                              width: 185,
                              height: 145,
                              child: FlatButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, Lets.id);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${emergency_4_number}',style:TextStyle(color: color6)),
                                            Icon(Icons.notifications,color:color6)
                                          ],
                                        ),
                                        SizedBox(height: 15,),
                                        Row(
                                          children: [
                                            Text("Lets\nConnect",style:TextStyle(color: color5,fontWeight: FontWeight.bold,fontSize: 15))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }
}
