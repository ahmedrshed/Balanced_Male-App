import 'package:balanced_meal/data/dio.dart';
import 'package:balanced_meal/data/storag.dart';
import 'package:balanced_meal/viewModel/state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Balance_Cubit extends Cubit<Balance_State> {
  Balance_Cubit() : super(init_State());

  static Balance_Cubit get(context) => BlocProvider.of(context);

  double calories = 0;
  List VegetableList = [];
  List CarbList = [];
  List MeatList = [];
  List<Map<String, dynamic>> MyCart = [];
  List<Map<String, dynamic>> Cart = [];
  var totalPrice;
  var totalCals;

  void calcolate_calories({
    required String gender,
    required String weight,
    required String height,
    required String age,
  }) {
    double w = double.tryParse(weight) ?? 0;
    double h = double.tryParse(height) ?? 0;
    int ag = int.tryParse(age) ?? 0;
    if (gender == "male") {
      calories = ((666.47) + (13.75 * w) + (5 * h) - (6.75 * ag));
    } else if (gender == "female") {
      calories = ((655.1) + (9.56 * w) + (1.85 * h) - (4.67 * ag));
    }
    emit(Calculate_successfully());
  }

  void get_Data() async {
    emit(Loading_Data());

    await Storge.getData(
      collection: "Meat",
      onSuccess: () {
        MyCart.clear();
        Cart.clear();
        totalPrice = 0;
        totalCals = 0;
        MeatList.forEach((element) {
          if (element["mycart"] == true) {
            MyCart.add(element);
            Cart.add({
              "name": element["food_name"],
              "quantity": element["quantity"],
              "total_price": element["quantity"] * 12,
            });
          }
        });
        VegetableList.forEach((element) {
          if (element["mycart"] == true) {
            MyCart.add(element);
            Cart.add({
              "name": element["food_name"],
              "quantity": element["quantity"],
              "total_price": element["quantity"] * 12,
            });
          }
        });
        CarbList.forEach((element) {
          if (element["mycart"] == true) {
            MyCart.add(element);
            Cart.add({
              "name": element["food_name"],
              "quantity": element["quantity"],
              "total_price": element["quantity"] * 12,
            });
          }
        });

        MyCart.forEach((element) {
          totalPrice += (12 * element["quantity"]);
          totalCals += (element["calories"] * element["quantity"]);
        });
        print(totalPrice);
        emit(Get_Meat_Data());
      },
      myList: MeatList,
    );
    await Storge.getData(
      collection: "Carb",
      onSuccess: () {
        MyCart.clear();
        Cart.clear();
        totalPrice = 0;
        totalCals = 0;
        MeatList.forEach((element) {
          if (element["mycart"] == true) {
            MyCart.add(element);
            Cart.add({
              "name": element["food_name"],
              "quantity": element["quantity"],
              "total_price": element["quantity"] * 12,
            });
          }
        });
        VegetableList.forEach((element) {
          if (element["mycart"] == true) {
            MyCart.add(element);
            Cart.add({
              "name": element["food_name"],
              "quantity": element["quantity"],
              "total_price": element["quantity"] * 12,
            });
          }
        });
        CarbList.forEach((element) {
          if (element["mycart"] == true) {
            MyCart.add(element);
            Cart.add({
              "name": element["food_name"],
              "quantity": element["quantity"],
              "total_price": element["quantity"] * 12,
            });
          }
        });
        MyCart.forEach((element) {
          totalPrice += (12 * element["quantity"]);
          totalCals += (element["calories"] * element["quantity"]);
        });
        print(totalPrice);
        emit(Get_Carb_Data());
      },
      myList: CarbList,
    );
    await Storge.getData(
      collection: "Vegetable",
      onSuccess: () {
        MyCart.clear();
        Cart.clear();
        totalPrice = 0;
        totalCals = 0;
        MeatList.forEach((element) {
          if (element["mycart"] == true) {
            MyCart.add(element);
            Cart.add({
              "name": element["food_name"],
              "quantity": element["quantity"],
              "total_price": element["quantity"] * 12,
            });
          }
        });
        VegetableList.forEach((element) {
          if (element["mycart"] == true) {
            MyCart.add(element);
            Cart.add({
              "name": element["food_name"],
              "quantity": element["quantity"],
              "total_price": element["quantity"] * 12,
            });
          }
        });
        CarbList.forEach((element) {
          if (element["mycart"] == true) {
            MyCart.add(element);
            Cart.add({
              "name": element["food_name"],
              "quantity": element["quantity"],
              "total_price": element["quantity"] * 12,
            });
          }
        });
        MyCart.forEach((element) {
          totalPrice += (12 * element["quantity"]);
          totalCals += (element["calories"] * element["quantity"]);
        });

        emit(Get_Vegetable_Data());
      },
      myList: VegetableList,
    );
  }

  add_quantity({
    required String collection,
    required String doc,
    required int quantity,
  }) {
    emit(Loading_Data());
    if (quantity > 0) {
      Storge.updata_data(
        Collection: collection,
        doc: doc,
        data: {"mycart": true},
      );
    }

    Storge.updata_data(
      Collection: collection,
      doc: doc,
      data: {"quantity": quantity},
    ).then((value) {
      emit(change_quantity());
    });
  }

  minus_quantity({
    required String collection,
    required String doc,
    required int quantity,
  }) {
    emit(Loading_Data());
    if (quantity == 0) {
      Storge.updata_data(
        Collection: collection,
        doc: doc,
        data: {"mycart": false},
      );
    }
    Storge.updata_data(
      Collection: collection,
      doc: doc,
      data: {"quantity": quantity},
    ).then((value) {
      emit(change_quantity());
    });
  }

  void post_Data({required List items}) {
    DioHelper.confirm(items: items)
        .then((value) {
          emit(Confirm_Data());
        })
        .catchError((e) {
          print(e);
        });
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
