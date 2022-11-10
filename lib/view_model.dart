import 'package:flutter/material.dart';

import 'data_model.dart';

class ViewModel extends ChangeNotifier {
  List<DataModel> myList = [
    DataModel("Bmw 4.20 ", 3, 1200000),
    DataModel("Mercedes c200 ", 3, 1300000),
    DataModel("Audi A7 ", 1, 1600000),
    DataModel("Volvo XC90 ", 3, 3200000),
    DataModel("Volkswagen Passat", 4, 1000000),
    DataModel("Maserati", 3, 1300000),
  ];

  List<DataModel> basketList = [];
  List<int> indexList = [];
  bool isStockEmpty = false;
  int singleItemPrice = 0;
  int boughtAmount = 0;
  List<int> priceList = [];

  int get totalSpentAmount {
    var count = 0;

    for (var element in myList) {
      count = (element.productPrice! * element.productAmount!) + count;
    }
    return count;
  }

  void addToMYBasket(int index) {
    if (!basketList.contains(myList[index])) {
      basketList.add(myList[index]);
      indexList.add(index);
      print(indexList);
    }

    notifyListeners();
  }

  void changeProductAmount(int index) {
    if (myList[index].productAmount != 0) {
      myList[index].productAmount = myList[index].productAmount! - 1;
      myList[index].boughtAmount = myList[index].boughtAmount! + 1;
    }
    notifyListeners();
  }

  bool controlBool(int index, AnimationController controller) {
    print(index);
    if (myList[index].productAmount != 0) {
      return false;
    } else {
      controller.forward();
      return true;
    }
   
  }

  void controlPrice() {
    for (var element in basketList) {
      priceList.add(element.productPrice! * element.boughtAmount!);
    }
    print(priceList);
    notifyListeners();
  }

  void delete(int index) {
    myList[indexList[index]].productAmount =
        myList[indexList[index]].productAmount! +
            myList[indexList[index]].boughtAmount!;
    basketList[index].boughtAmount = 0;

    basketList.removeAt(index);
    indexList.removeAt(index);

    notifyListeners();
  }

  int calculateTotalPrice() {
    var total = 0;
    for (var element in basketList) {
      total = (element.productPrice! * element.boughtAmount!) + total;
    }
    return total;
  }
}
