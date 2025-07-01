import 'package:balanced_meal/combonent/mycontainer.dart';
import 'package:balanced_meal/view/orderSummery.dart';
import 'package:balanced_meal/viewModel/cubit.dart';
import 'package:balanced_meal/viewModel/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = Balance_Cubit.get(context);
    return BlocConsumer<Balance_Cubit, Balance_State>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            title: Text(
              "Create your order",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Column(
              children: [
                Container(
                  height: 580,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Vegetables",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          height: 190,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.VegetableList.length,
                            itemBuilder: (context, index) {
                              return Mycontainer(
                                collection: "Vegetable",
                                doc: cubit.VegetableList[index]["id"],
                                quantity:
                                    cubit.VegetableList[index]["quantity"],
                                context,
                                image: cubit.VegetableList[index]["image_url"],
                                food_name:
                                    cubit.VegetableList[index]["food_name"],
                                calories:
                                    cubit.VegetableList[index]["calories"],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Meats",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          height: 190,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.MeatList.length,
                            itemBuilder: (context, index) {
                              return Mycontainer(
                                collection: "Meat",
                                doc: cubit.MeatList[index]["id"],
                                quantity: cubit.MeatList[index]["quantity"],
                                context,
                                image: cubit.MeatList[index]["image_url"],
                                food_name: cubit.MeatList[index]["food_name"],
                                calories: cubit.MeatList[index]["calories"],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Carb",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          height: 190,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.CarbList.length,
                            itemBuilder: (context, index) {
                              return Mycontainer(
                                collection: "Carb",
                                doc: cubit.CarbList[index]["id"],
                                quantity: cubit.CarbList[index]["quantity"],
                                context,
                                image: cubit.CarbList[index]["image_url"],
                                food_name: cubit.CarbList[index]["food_name"],
                                calories: cubit.CarbList[index]["calories"],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder:
                                    (BuildContext context) =>
                                        const Ordersummery(),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.orange,
                            ),
                            child: Center(
                              child: Text(
                                "Place order",
                                style: TextStyle(
                                  color: Colors.white,

                                  fontSize: 20,
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
        );
      },
      listener: (context, state) {},
    );
  }
}
