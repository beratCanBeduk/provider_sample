import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_try/data_model.dart';
import 'package:provider_try/second_screen.dart';
import 'package:provider_try/view_model.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ViewModel();
    var modeReader = context.read<ViewModel>();
    var modelWatcher = context.watch<ViewModel>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Text("Toplam Değer : ${viewModel.totalSpentAmount}")),
        actions: [
          Consumer<ViewModel>(
              builder: (context, value, child) =>
                  Text("${value.basketList.length}")),
          Consumer<ViewModel>(
              builder: (context, value, child) => IconButton(
                  onPressed: () {
                    if (value.basketList.isEmpty) {
                      print("Başarısız");
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const SecondView())));
                    }
                  },
                  icon: const Icon(Icons.shopping_basket)))
        ],
      ),
      body: ListView.separated(
          itemCount: viewModel.myList.length,
          separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
          itemBuilder: (context, index) {
            DataModel data = viewModel.myList[index];
            TextStyle style = const TextStyle(
                color: Colors.black,
                fontFamily: "urbanist",
                fontWeight: FontWeight.bold,
                fontSize: 20);
            return Consumer<ViewModel>(
                builder: (context, value, child) => ListTile(
                    title: Text(
                      "Araç İsmi : ${value.myList[index].productName!}",
                      style: style,
                    ),
                    subtitle: Text(
                      "Araç Fiyatı : ${modelWatcher.myList[index].productPrice.toString()}",
                      style: style,
                    ),
                    leading: Text(
                      "Stok : ${modelWatcher.myList[index].productAmount.toString()}",
                      style: style,
                    ),
                    trailing: GestureDetector(
                        onTap: () {
                          modeReader.addToMYBasket(index);
                          modeReader.changeProductAmount(index);
                          modeReader.controlBool(index, animationController);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 2000),
                          width:
                              modeReader.controlBool(index, animationController)
                                  ? 30
                                  : 50,
                          height:
                              modeReader.controlBool(index, animationController)
                                  ? 30
                                  : 50,
                          curve: Curves.fastOutSlowIn,
                          child:
                              modeReader.controlBool(index, animationController)
                                  ? const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                        ))));
          }),
    );
  }
}
