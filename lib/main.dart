import 'package:balanced_meal/view/welcomePage.dart';
import 'package:balanced_meal/viewModel/cubit.dart';
import 'package:balanced_meal/viewModel/state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Balance_Cubit()..get_Data(),
      child: BlocConsumer<Balance_Cubit, Balance_State>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            home: Welcomepage(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
