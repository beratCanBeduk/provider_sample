import 'package:flutter/material.dart';

class DataModel {
  final String? productName;
  int? productAmount;
  final int? productPrice;
  int? boughtAmount;


  DataModel(
    this.productName,
    this.productAmount,
    this.productPrice,
    
  ) : boughtAmount = 0;
}
