import 'package:balanced_meal/viewModel/cubit.dart';
import 'package:flutter/material.dart';

int price = 12;
Widget Mycontainer(
  context, {
  required String image,
  required String food_name,
  required int calories,

  required String collection,
  required int quantity,
  required String doc,
}) {
  var cubit = Balance_Cubit.get(context);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // لون الظل
            spreadRadius: 2, // مدى انتشار الظل
            blurRadius: 7, // نعومة الظل
            offset: Offset(0, 3), // موقع الظل (أفقي, عمودي)
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 190,
      width: 170,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(food_name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text("$calories Cal", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${price}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                quantity == 0
                    ? Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            cubit.add_quantity(
                              collection: collection,
                              doc: doc,
                              quantity: quantity + 1,
                            );
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                    : Container(
                      width: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.add_quantity(
                                collection: collection,
                                doc: doc,
                                quantity: quantity + 1,
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
                            "${quantity}",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.minus_quantity(
                                collection: collection,
                                doc: doc,
                                quantity: quantity - 1,
                              );
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
          ),
        ],
      ),
    ),
  );
}
