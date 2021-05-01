import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Lets extends StatefulWidget {
  static const String id ='Lets_screen';
  @override
  _LetsState createState() => _LetsState();
}

class _LetsState extends State<Lets> {
  Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }
  double displayWidth(BuildContext context) {
    debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }
  var color2 = Color(0xffF2F9FC);
  var color1 = Color(0xFFFE9C1ED);
  var color3 = Color(0xFFCACEF1);
  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var grp_messages = new Map();
  List emergency_type_4 = [];
  List emergency_4=[];
  int emergency_4_number=0;
  bool verified =false;
  List group_members=[];
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
  accept_request(Index1){
    if(emergency_type_4[Index1][4]=='not accepted'){
      print(emergency_type_4[Index1][5]);
      firestoreInstance.collection("Group_Messages").doc(emergency_type_4[Index1][5]).update(
          {
            "acceptedBY":auth.currentUser.uid,
            "Status" :"accepted"
          }).then((_){
        print("success!");
      });
    }else(){
      print("already accepted");
    };

  }
  Future<String> createAlertDialog(BuildContext context,int Index1){
    print('${Index1}');
    TextEditingController customController =TextEditingController();
    return showDialog(context: context,builder:  (context){
      print('${Index1}');
      //print('${emergency_type_1[Index1]}');
      //print('${emergency_type_1[Index1][0]}');
      //print('${emergency_type_1[Index1][3]}');
      return AlertDialog(
        backgroundColor: color3,
        content:Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(emergency_type_4[Index1][0],style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    Text(emergency_type_4[Index1][3],style:TextStyle(fontSize: 20)),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Icon(Icons.message,color: Colors.white,size: 30,),
                        SizedBox(width: 10,),
                        Icon(Icons.call,color:Colors.white,size: 30,),                        ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.medical_services_outlined,size: 50,color:Colors.white,),
                  ],
                )
              ],
            ),
          ],
        ),
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              SizedBox(
                width: 125,
                height: 45,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5.0,
                    child: Text('Assist',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 23)),
                    color: color1,
                    onPressed: () {
                      accept_request(Index1);
                      Navigator.of(context).pop(customController.text.toString());
                    }
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
              ),
            ],
          ),


        ],
      );
    });

  }
  process_data(){
    grp_messages.forEach((key, value) {
      print(value["Emergency"]);
      if(value['Emergency'] == '4' && value['from_ID'] != auth.currentUser.uid && value['Status'] != 'accepted'&& verified == true){
        emergency_4.add(value["message"]);
        emergency_4.add(value["time"]);
        emergency_4.add(value["from_ID"]);
        emergency_4.add(value["from_name"]);
        emergency_4.add(value["Status"]);
        emergency_4.add(key);
        emergency_type_4.add(emergency_4);
        emergency_4=[];
        print(emergency_type_4);
      }
    });
    setState(() {
      emergency_4_number= emergency_type_4.length;
      print(emergency_4_number);
    });
  }
  @override
  void initState() {
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color2,
      appBar: AppBar(
        backgroundColor: color1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 15,),
            Center(child: Text("Lets Connect",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
            SizedBox(height: 15,),
            if(verified==true)
              Expanded(
              child: ListView.builder(
                  itemCount: emergency_4_number,
                  itemBuilder: (BuildContext ctxt, int Index){
                    return FlatButton(
                      onPressed: (){
                        createAlertDialog(context,Index).then((onValue){
                          print(onValue);
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: color1,
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('images/1.png',scale: 0.8,),
                                      SizedBox(width: displayWidth(context)*0.1,),
                                      Text(emergency_type_4[Index][0],style:TextStyle(fontSize: 18,color:Colors.white)),

                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.arrow_forward_sharp,color:Colors.white)
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
            if(verified==false)
              Expanded(child: Center(child: Text('No socializing requests'))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('images/6.png'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
