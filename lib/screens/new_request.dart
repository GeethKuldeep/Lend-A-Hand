import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewRequest extends StatefulWidget {
  @override
  _NewRequestState createState() => _NewRequestState();
}

class Request {
  int id;
  String message;

  Request(this.id, this.message);

  static List<Request> getrequests() {
    return <Request>[
      Request(1, 'Medical Emergency'),
      Request(2, 'Safety & Security'),
      Request(3, 'Daily Essentials'),
      Request(4, 'Lets Connect'),
    ];
  }
}

class _NewRequestState extends State<NewRequest> {
  var color1 = Color(0xFFF2F9FC);
  var color2 = Color(0xFFFE9C1ED);
  var color3 = Color(0xFFFD3AAEA);
  var color4 = Color(0xFFFA99CF0);
  final FocusNode _UsernameFocusNode = FocusNode();
  final TextEditingController _UsernameController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  int Emergency;
  String username;
  String GRPID;
  var _formkey = GlobalKey<FormState>();


  List<Request> _companies = Request.getrequests();
  List<DropdownMenuItem<Request>> _dropdownMenuItems;
  Request _selectedrequest;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedrequest = _dropdownMenuItems[3].value;
    getdata();
    super.initState();
  }

  List<DropdownMenuItem<Request>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Request>> items = [];
    for (Request company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.message),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Request selectedrequest) {
    setState(() {
      _selectedrequest = selectedrequest;
      extract_emergency();
    });
    print(_selectedrequest.message);
  }
  extract_emergency(){
    setState(() {
      if(_selectedrequest.message =='Medical Emergency'){
        setState(() {
          Emergency = 1;
          print('Updated ${Emergency}');
        });
      }
      if(_selectedrequest.message =='Safety & Security'){
        setState(() {
          Emergency = 2;
          print('Updated ${Emergency}');
        });
      }
      if(_selectedrequest.message =='Daily Essentials'){
        setState(() {
          Emergency = 3;
          print('Updated ${Emergency}');
        });
      }if(_selectedrequest.message =='Lets Connect'){
        setState(() {
          Emergency = 4;
          print('Updated ${Emergency}');
        });
      }

    });
  }
  getdata()async{
    await firestoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        if(result['ID'] == auth.currentUser.uid ){
          setState(() {
            username= result['username'];
            print(username);
            GRPID = result['Groups'][0];
            print(GRPID);

          });
        }

      });
    });
  }
  upload_request()async {
    if (Emergency != null) {
      await firestoreInstance.collection("Group_Messages").add(
          {
            "Emergency": "${Emergency}",
            "from_ID" :auth.currentUser.uid,
            "from_name":username,
            "group":GRPID,
            "message":_UsernameController.text,
            "time":Timestamp.now(),
            "Status":"not accepted",
            "acceptedBY":""

          }).then((value) {
        print(value.id);
      });
    }
    else () {
      print("Enter the category");
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: color1,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Place a Request",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: color2,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Category',
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: DropdownButton(
                        iconSize: 35,
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        dropdownColor: color2,
                        elevation: 100,
                        underline: Container(
                          height: 2,
                          color: color2,
                        ),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        value: _selectedrequest,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: color3,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Add Details',
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Form(
                              key: _formkey,
                              child: TextFormField(
                                style: GoogleFonts.rambla(color: Colors.black,fontSize: 20),
                                maxLines: 4,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.multiline,
                                cursorColor: Colors.black,
                                key: ValueKey("UserName"),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter details';
                                  }
                                  return null;
                                },
                                controller: _UsernameController,
                                focusNode: _UsernameFocusNode,
                                decoration: InputDecoration(
                                  labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 13),
                                  contentPadding: const EdgeInsets.all(8.0),
                                  errorBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                      color: color3,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: color3,
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: color3,
                                      width: 5.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  errorStyle: TextStyle(
                                    color: color3,
                                    fontSize: 20,
                                  ),
                                ),
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 125,
                                    height: 40,
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        color: color4,
                                        child: Text("Add",
                                            style: TextStyle(
                                                fontSize: 25, color: Colors.white)),
                                        onPressed: () {
                                          if (_formkey.currentState.validate() == true) {
                                            upload_request();
                                            print("Uplaoded");
                                            _UsernameController.clear();
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
