import 'package:flutter/material.dart';
import 'nonprofit.dart';
import 'activity.dart';
class VolunteeringActivity extends Activity{
  int hours = 0;
  
  VolunteeringActivity(String org, DateTime date,Icon i,int hours):super(org,date,i)
  {
    
    this.hours = hours;
    this.summary = "You volunteered for "+this.hours.toString()+" hours for "+this.org;
  }

  
  //final DateTime date;
  
}

