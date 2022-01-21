
import 'package:flutter/material.dart';

import 'nonprofit.dart';
import 'activity.dart';
class DonationActivity extends Activity{
  double dollars = 0.0;
  DonationActivity(String org, DateTime date,Icon i,double d):super(org,date,i)
  {
    
    this.dollars = d;
    this.summary = "You donated \$"+dollars.toStringAsPrecision(2)+" to "+this.org;
  }

  
  //final DateTime date;
  
}

