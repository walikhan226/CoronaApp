import 'package:coronaapp/covidbloc.dart';
import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'corvidrepo.dart';
import 'covidmodel.dart';
import 'corvidrepo.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[900],
        body: BlocProvider(

         create: (context) => CovidBloc(CovidRepo()),
          child: SearchPage(),
        
        
        ),
      )
    );
  }
}




class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final covidBloc = BlocProvider.of<CovidBloc>(context);
    var cityController = TextEditingController();
  
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[


        // Center(
        //     child: Container(
        //       child: FlareActor("assets/WorldSpin.flr", fit: BoxFit.contain, animation: "roll",),
        //       height: 300,
        //       width: 300,
        //     )
        // ),



        BlocBuilder<CovidBloc, CovidState>(
          builder: (context, state){
            if(state is CovidIsNotSearched)
              return Container(
                padding: EdgeInsets.only(left: 32, right: 32,),
                child: Column(
                  children: <Widget>[
                    Text("Search Weather", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),),
                    Text("Instanly", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white70),),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: cityController,

                      decoration: InputDecoration(

                        prefixIcon: Icon(Icons.search, color: Colors.white70,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                style: BorderStyle.solid
                            )
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                style: BorderStyle.solid
                            )
                        ),

                        hintText: "City Name",
                        hintStyle: TextStyle(color: Colors.white70),

                      ),
                      style: TextStyle(color: Colors.white70),

                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        onPressed: (){

                          covidBloc.add(FetchCovid(cityController.text));
                        
                        },
                        color: Colors.lightBlue,
                        child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

                      ),
                    )

                  ],
                ),
              );
            else if(state is CovidIsLoaded)
              return Center(child : CircularProgressIndicator());
            else if(state is CovidIsLoaded)
              return ShowWeather(state.getCovid, cityController.text);
            else
              return Text("Error",style: TextStyle(color: Colors.white),);
          },
        )

      ],
    );
  }
}

class ShowWeather extends StatelessWidget {
  CovidModel covid;
  final county;

  ShowWeather(this.covid, this.county);

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.only(right: 32, left: 32, top: 10),
          child: Column(
            children: <Widget>[
              Text(county,style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),

              Text(covid.confirmed.toString()+"",style: TextStyle(color: Colors.white70, fontSize: 50),),
              Text("Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(covid.deaths.toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
                      Text("Min Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(covid.confirmed.toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
                      Text("Max Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: (){
                    BlocProvider.of<CovidBloc>(context).add(ResetCovid());
                  },
                  color: Colors.lightBlue,
                  child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

                ),
              )
            ],
          )
      );
  }
}



