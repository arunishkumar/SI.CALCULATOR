import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator',
      home: Scaffold(
        appBar: AppBar(title: Text("Simple Interest Calculator",),backgroundColor: Colors.amberAccent,
        ),
        body: Container(
          child: ListView(children: <Widget>[
            bankimageasset(),
            prin()
          ],
          ),
        ),
      ),
    ),
  );
}

class bankimageasset extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage=AssetImage('bankimage/bank.png');
    Image image=Image(image: assetImage,width: 250.0,height: 250.0,
    );
    return Container(child: image,);
  }
  
}

class prin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _prin();
  }

}

class _prin extends State<prin>{
  var _formkey=GlobalKey<FormState>();
  var _currencies=["Rupees","Dollars"];
  var _currentitemselected="Rupees";
  TextEditingController principalcontroller=TextEditingController();
  TextEditingController interestcontroller=TextEditingController();
  TextEditingController termcontroller=TextEditingController();
  var displaytext='';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child:Column(children: <Widget>[Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: principalcontroller,
        keyboardType: TextInputType.number,
        validator: (String value){
          if(value.isEmpty){
            return "Please enter principal amount";
          }
        },
        decoration: InputDecoration(
          labelText: "Principal",
          hintText: "Enter Principal e.g 10000",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)
          )
        ),
    )
    
      ),Padding(
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          controller: interestcontroller,
          keyboardType: TextInputType.number,
          validator: (String value){
            if(value.isEmpty){
              return "Enter rate of interest";
            }
          },
          decoration: InputDecoration(
            labelText: "Interest Rate",
            hintText: "Rate Of Interest e.g 10%",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0)
            )
          ),
      ),
      ),
      Padding(padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child:Row(children: <Widget>[
      Expanded(child: TextFormField(
        controller: termcontroller,
        keyboardType: TextInputType.number,
        validator: (String value){
          if(value.isEmpty){
            return "Enter time period";
          }
        },
        decoration: InputDecoration(
          labelText: "Term",
          hintText: "Time in Years",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)
          )
        ),
        ),),Container(width: 20.0,),
        Expanded(child: DropdownButton<String>(
          items: _currencies.map((String dropdownstringitem){
            return DropdownMenuItem<String>(
              value: dropdownstringitem,
              child: Text(dropdownstringitem)
            );
          }).toList(),
          onChanged: (String newvalueselected){
            setState(() {
             this._currentitemselected=newvalueselected; 
            });
          },
          value: _currentitemselected,
        ),) 
      ],
      ) 
        ), 
      Padding(padding: EdgeInsets.all(10.0),
      child: Row(children: <Widget>[
        Expanded(child: RaisedButton(
          color: Colors.limeAccent,
          child: Text("CALCULATE",style: TextStyle(fontStyle: FontStyle.italic),),
          onPressed: (){
            setState(() {
              if(_formkey.currentState.validate()){
                this.displaytext=calculateinterest();
              }
              
            });
          },
        ),
        ), 
        Expanded(child: RaisedButton(
          color: Colors.limeAccent,
          child: Text("RESET",style: TextStyle(fontStyle: FontStyle.italic),),
          onPressed: (){
            setState(() {
             reset(); 
            });
          },
        ),) 
      ],
      ),
      ),
      Padding(padding: EdgeInsets.all(10.0),
      child: Text(this.displaytext),)
    ],
    ),
    );
  }
  String calculateinterest(){
    double principal=double.parse(principalcontroller.text);
    double interest=double.parse(interestcontroller.text);
    double term=double.parse(termcontroller.text);
     
    double totalinterest=(principal*interest*term)/100;
    String result="Total interest will be $totalinterest $_currentitemselected";
    return result;
    
    }
void reset(){
      principalcontroller.text="";
      interestcontroller.text="";
      termcontroller.text="";
      displaytext='';
      _currentitemselected=_currencies[0];
    }
}