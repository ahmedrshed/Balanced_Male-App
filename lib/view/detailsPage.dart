import 'package:balanced_meal/combonent/myTextField.dart';
import 'package:balanced_meal/view/orderPage.dart';
import 'package:balanced_meal/viewModel/cubit.dart';
import 'package:balanced_meal/viewModel/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String? Gender;
TextEditingController weight = TextEditingController();
TextEditingController height = TextEditingController();
TextEditingController age = TextEditingController();

class Detailspage extends StatelessWidget {
  const Detailspage({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var cubit = Balance_Cubit.get(context);

    return BlocConsumer<Balance_Cubit, Balance_State>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Enter Your Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Gender",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null) {
                          return "required enter value";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Choose Your Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      value: Gender,
                      items:
                          ['male', 'female'].map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                      onChanged: (value) {
                        Gender = value;
                      },
                    ),

                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Weight",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    myTextField(
                      suffix: "kg",
                      hint: "Enter Your Weight",
                      controller: weight,
                      validator: (value) {
                        final weight = double.tryParse(value!);
                        if (weight == null || weight <= 0) {
                          return 'Please enter a valid weight';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Height",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    myTextField(
                      suffix: "cm",
                      hint: "Enter Your Height",
                      controller: height,
                      validator: (value) {
                        final height = double.tryParse(value!);
                        if (height == null || height <= 0) {
                          return 'Please enter a valid height';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Age",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    myTextField(
                      hint: "Enter Your Age",
                      controller: age,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "required enter value";
                        }
                        return null;
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: Container(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.orange,
                              ),
                            ),

                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                cubit.calcolate_calories(
                                  gender: Gender!,
                                  weight: weight.text,
                                  height: height.text,
                                  age: age.text,
                                );
                              }
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is Calculate_successfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Daily Calories Needed: ${cubit.calories.round()}'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const OrderPage(),
            ),
          );
        }
      },
    );
  }
}
