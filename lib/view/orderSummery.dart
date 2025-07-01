import 'package:balanced_meal/combonent/mycontainer.dart';
import 'package:balanced_meal/data/dio.dart';
import 'package:balanced_meal/viewModel/cubit.dart';
import 'package:balanced_meal/viewModel/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Ordersummery extends StatelessWidget {
  const Ordersummery({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = Balance_Cubit.get(context);
    return BlocConsumer<Balance_Cubit, Balance_State>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text("Order Summery"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.MyCart.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Container(
                        height: 100,
                        width: 500,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 150,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    cubit.MyCart[index]["image_url"],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  cubit.MyCart[index]["food_name"],
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${cubit.MyCart[index]["calories"]} Cal",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("\$${price}"),
                                Container(
                                  width: 90,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cubit.add_quantity(
                                            collection:
                                                cubit
                                                    .MyCart[index]["categories"],
                                            doc: cubit.MyCart[index]["id"],
                                            quantity:
                                                cubit
                                                    .MyCart[index]["quantity"] +
                                                1,
                                          );
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.orange,
                                          radius: 15,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${cubit.MyCart[index]["quantity"]}",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cubit.minus_quantity(
                                            collection:
                                                cubit
                                                    .MyCart[index]["categories"],
                                            doc: cubit.MyCart[index]["id"],
                                            quantity:
                                                (cubit.MyCart[index]["quantity"] -
                                                    1),
                                          );
                                          print(cubit.MyCart[index]);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.orange,
                                          radius: 15,
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cals",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "${cubit.totalCals} Cal out of ${cubit.calories.round()} cal",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "\$${cubit.totalPrice}",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          cubit.post_Data(items: cubit.Cart);
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
                              "Confirm",
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
        );
      },
      listener: (context, state) {
        if (state is Confirm_Data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Order confirmed successfully 🎉"),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 500),
            ),
          );
        }
      },
    );
  }
}
