import 'dart:html';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'API.dart';
import 'dart:convert';

import 'TrainPage.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'interface',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.amber.shade300,
      ),
      home: const MyHomePage(title: 'interface'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  var validdrop = Text ("โปรดเลือกเดือน",
    // overflow: TextOverflow.fade,
    style:GoogleFonts.mitr(
      textStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0),
    ),
  );

  int _selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _text1 = TextEditingController();  //textediting
  final _text2 = TextEditingController();// controller
  bool _validate1 = false;
  bool _validate2= false;//variable to store the bool value
  bool _validate3= false;
  // final List<String> items = [
  //   'มกราคม 2566',
  //   'กุมภาพันธ์ 2566',
  //   'มีนาคม 2566',
  // ];
  String? _chosenValue;
  int index=0;
  String? selectedValue;
  String url='';
  String year='';
  var Data;
  String QueryText = '';

  String valueUs='';
  String valueOil='';
  String valueMonth='';
  String valueYear='';

  String month_fromexcel="";

  void _onItemTapped(int index) {
    setState(() async {

      url =
      "http://127.0.0.1:5000/excel_value";
      print(url);
      Data = await Getdata(url);
      var DecodedData = jsonDecode(Data);
      print('DecodedData $DecodedData');
      print('Data $Data');
      month_fromexcel = DecodedData.toString();
      print(month_fromexcel);



      _selectedIndex = index;
      print( _selectedIndex);
      if( _selectedIndex == 0){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
      }else if( _selectedIndex == 1){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrainPage()));
      }
    });
  }
  void dispose1() {
    _text1.dispose();
    super.dispose();
  }
  void dispose2() {
    _text2.dispose();
    super.dispose();
  }
  void _fetchData(BuildContext context, [bool mounted = true]) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('โปรดรอสักครู่',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.mitr(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0),
                    ),)
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await Future.delayed(const Duration(seconds: 5));

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (!mounted) return;
    Navigator.of(context).pop();


  }


  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    var now = new DateTime.now();
    var MONTHS = ["มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม"];

    final List<String> items = [];
    String formattedDateTime(int num) {
      DateTime now = new DateTime.now();
      var years = now.year+543;
      return MONTHS[now.month+num]+" "+years.toString();
    }

    String formattedDateOver(int num) {
      int count = now.year+543;
      // var new_year = new DateTime(2567, num);
      var year = count+1;
      // print("เดือน $num");
      //print(MONTHS[num]);
      return MONTHS[num-1]+" "+year.toString();
    }



    int count = now.month;
    int countYear = 1;
    var count_month=12;

    for(int i=0;i<count_month;++i) {
      count++;
      // print(count);

      if(count > 12){
        items.add(formattedDateOver(countYear));
        // print(countYear);
        countYear++;
      }else{
        items.add(formattedDateTime(i));

      }
    }
    return Scaffold(
      // appBar: AppBar(
      // title: Text('Soybean Forecast'),
      // ),
      backgroundColor: Color.fromRGBO(255, 194, 0, 0.15),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      children: [
                        Image.asset('asset/images/logo.png',
                          fit: BoxFit.fill,
                          height: 55,
                        ),
                        Expanded(
                          child: Text(
                            'ทำนายราคากากถั่วเหลืองล่วงหน้า',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 25.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: new BoxDecoration(
                      color: Colors.amber.shade300,
                      boxShadow: [new BoxShadow(blurRadius: 3.0)],
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              // alignment: Alignment.center,
                              height: 200,
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage('asset/images/banner2.png'),
                                      fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child:  Container(
                    alignment: Alignment.bottomCenter,
                    width: 685,
                    height: 390,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade300,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:35.0, left:35.0, right: 35.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 260,
                                  child: Expanded(
                                    child: Text('ราคากากถั่วเหลืองของสหรัฐอเมริกา ',style: GoogleFonts.mitr(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0),
                                    ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                FractionalTranslation(
                                  translation: Offset(0,0),
                                  child: SizedBox(
                                    height: 70,
                                    width: 150.0,
                                    child: TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)')),
                                        FilteringTextInputFormatter.deny(RegExp(r'^0+'), ),],
                                      style: GoogleFonts.mitr(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0),
                                      ),
                                      controller: _text1,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        labelStyle: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15.0),
                                        ),
                                        labelText: 'กรอกตัวเลข',
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        errorText: _validate1 ? 'โปรดกรอกช่องนี้' : null,
                                        // errorStyle: GoogleFonts.mitr(
                                        //   textStyle: TextStyle(
                                        //       color: Colors.red,
                                        //       fontSize: 12.0),
                                        // )
                                      ),

                                      onChanged: (value) {
                                        valueUs=value;
                                        setState(() {
                                          _text1.text.isEmpty ? _validate1 = true : _validate1 = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.0,),
                                Container(
                                  child: Text('ดอลลาร์สหรัฐ/ตัน',style: GoogleFonts.mitr(
                                    textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18.0),
                                  ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22), //distance textfield 1 & 2
                            child: Row(
                              children: [
                                Container(
                                  width: 170,
                                  child: Expanded(
                                    child: Text('ราคาน้ำมันดิบ ',style: GoogleFonts.mitr(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0),
                                    ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 95.0,),
                                FractionalTranslation(
                                  translation: Offset(0,0),
                                  child: SizedBox(
                                    height: 70,
                                    width: 150.0,
                                    child: TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)')),
                                        FilteringTextInputFormatter.deny(RegExp(r'^0+'), ),],
                                      style: GoogleFonts.mitr(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0),
                                      ),
                                      controller: _text2,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        labelStyle: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15.0),
                                        ),
                                        labelText: 'กรอกตัวเลข',
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        errorText: _validate2 ? 'โปรดกรอกช่องนี้' : null,
                                        // errorStyle: GoogleFonts.mitr(
                                        //   textStyle: TextStyle(
                                        //       color: Colors.red,
                                        //       fontSize: 12.0),
                                        // ),
                                      ),
                                      onChanged: (value) {
                                        valueOil=value;
                                        setState(() {
                                          _text2.text.isEmpty ? _validate2 = true : _validate2 = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.0,),
                                Container(
                                  child: Text('ดอลลาร์สหรัฐ/บาร์เรล',style: GoogleFonts.mitr(
                                    textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18.0),
                                  ),
                                  ),
                                ),
                              ],
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                                children: [
                                  Container(
                                    width: 230,
                                    child: Text('เลือกเดือนที่ต้องการทำนายผล ',style: GoogleFonts.mitr(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0),
                                    ),),
                                  ),
                                  SizedBox(width: 33.0,), //35
                                  Container(
                                    // decoration: BoxDecoration(color: Colors.grey.shade50,),
                                    height: 70,
                                    width: 150.0,
                                    child: Form(
                                      key: _formKey,
                                      child: DropdownButtonFormField(
                                        dropdownColor: Colors.white,
                                        isExpanded: true,
                                        isDense: true,
                                        // focusColor:Colors.white,
                                        style: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                            // overflow: TextOverflow.ellipsis,
                                              color: Colors.black,
                                              fontSize: 18.0),
                                        ),
                                        value: _chosenValue,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        // isDense: true,
                                        items: items.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text (value,
                                              // overflow: TextOverflow.fade,
                                              style:GoogleFonts.mitr(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            _validate3 = true;
                                            return "โปรดเลือกเดือน";
                                          }else{
                                            _validate3 = false;
                                          }
                                          return null;
                                        },
                                        hint:Text(
                                          "เลือกเดือน",
                                          style: GoogleFonts.mitr(
                                            textStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15.0),
                                          ),
                                        ),
                                        onChanged: (String? value) {

                                          final splitted = value?.split(' ');
                                          print(splitted![0]);
                                          switch(splitted[0]){
                                            case "มกราคม" : {valueMonth='1'; valueYear=splitted[1];} break;
                                            case "กุมภาพันธ์" : {valueMonth='2'; valueYear=splitted[1];}break;
                                            case "มีนาคม" : {valueMonth='3'; valueYear=splitted[1];} break;
                                            case "เมษายน" : {valueMonth='4'; valueYear=splitted[1];} break;
                                            case "พฤษภาคม" : {valueMonth='5'; valueYear=splitted[1];} break;
                                            case "มิถุนายน" : {valueMonth='6'; valueYear=splitted[1];} break;
                                            case "กรกฎาคม" : {valueMonth='7'; valueYear=splitted[1];} break;
                                            case "สิงหาคม" : {valueMonth='8'; valueYear=splitted[1];} break;
                                            case "กันยายน" : {valueMonth='9'; valueYear=splitted[1];} break;
                                            case "ตุลาคม" :{valueMonth='10'; valueYear=splitted[1];} break;
                                            case "พฤศจิกายน" : {valueMonth='11'; valueYear=splitted[1];} break;
                                            case "ธันวาคม" : {valueMonth='12'; valueYear=splitted[1];} break;
                                          }
                                          print('us $valueUs oil $valueOil month $valueMonth and year $valueYear');
                                          setState(() {
                                            _chosenValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 50,
                                      width: 120,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          // textStyle: TextStyle(fontSize: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState!.save();
                                          }
                                          _text1.text.isEmpty ? _validate1 = true : _validate1 = false;
                                          _text2.text.isEmpty ? _validate2 = true : _validate2= false;
                                          if(_validate2==false&&_validate1==false&&_validate3==false) {
                                            url =
                                            "http://127.0.0.1:5000/predict_model?Soybean_meal_US=$valueUs&Crude_Oil=$valueOil&New_Month=$valueMonth&Year=$valueYear";
                                            print(url);
                                            _fetchData(context);
                                            Data = await Getdata(url);
                                            var DecodedData = jsonDecode(Data);
                                            print('DecodedData $DecodedData');
                                            print('Data $Data');
                                            setState(() {
                                              QueryText = DecodedData.toString();

                                              print(QueryText);
                                            });
                                          }else{
                                            setState(() {
                                              _text1.text.isEmpty ? _validate1 = true : _validate1 = false;
                                              _text2.text.isEmpty ? _validate2 = true : _validate2= false;

                                            });
                                          }
                                          //  Navigator.of(context).pop();
                                        },
                                        child: Text("ทำนาย" ,style: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 685,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade300,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ผลลัพธ์การทำนายราคากากถั่วเหลืองนำเข้าไทย',style: GoogleFonts.mitr(
                            textStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0),
                          ),
                          ),
                          SizedBox(width: 94.0,),
                          Container(
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: SizedBox(
                                width: 200.0,
                                child: TextField(
                                  style: GoogleFonts.mitr(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0),
                                  ),
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    hintText:  QueryText,
                                    hintStyle: GoogleFonts.mitr(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text('บาท/กิโลกรัม',textAlign : TextAlign.center, style: GoogleFonts.mitr(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0),
                          ),
                          ),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'ทำนายราคา',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'เทรนโมเดล',
          ),
        ],
        selectedLabelStyle: GoogleFonts.mitr(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0),
          ),
        unselectedLabelStyle:  GoogleFonts.mitr(
          textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18.0),
        ),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}


