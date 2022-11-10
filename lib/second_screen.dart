import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_try/view_model.dart';

class SecondView extends StatefulWidget {
  const SecondView({
    Key? key,
  }) : super(key: key);

  @override
  State<SecondView> createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView> {
  @override
  Widget build(BuildContext context) {
    var viewModel = ViewModel();
    var modelWatcher = context.watch<ViewModel>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Sepetim"),
        leading: IconButton(
            onPressed: () {
              print(modelWatcher.myList[5].boughtAmount);
              print(modelWatcher.myList[5].productAmount);
              print(modelWatcher.myList[5].productName);
              print(modelWatcher.myList[5].productPrice);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: ((context, index) => const Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                )),
            itemCount: modelWatcher.basketList.length,
            itemBuilder: (context, index) {
              return Consumer<ViewModel>(builder: ((context, value, child) {
                var unitPrice = value.basketList[index].productPrice! *
                    value.basketList[index].boughtAmount!;
                return ListTile(
                    title: Text(
                        "Araç ismi : ${value.basketList[index].productName}"),
                    subtitle: Text("Fiyat : $unitPrice"),
                    trailing: Column(
                      children: [
                        Text(
                            "Alınan adet : ${value.basketList[index].boughtAmount}"),
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                modelWatcher.delete(index);
                              },
                              icon: const Icon(
                                Icons.delete,
                              )),
                        )
                      ],
                    ));
              }));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer(builder: ((context, value, child) {
                var total = modelWatcher.calculateTotalPrice();
                return Text(
                  ' ${total.toString()}Tl',
                  style: TextStyle(
                      color: Colors.green.withGreen(200),
                      fontFamily: 'Urbanist',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                );
              })),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {},
                  child: const Text(
                    'Buy',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
