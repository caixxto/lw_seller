import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_seller/ui/home_screen/home_screen.dart';
import 'package:lw_seller/ui/seller_screen/bloc/seller_bloc.dart';
import 'package:lw_seller/ui/seller_screen/seller_screen.dart';

void main() async {
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SellerBloc(),
          ),
        ],
        child: const MyApp(),

      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SellerScreen(),
    );
  }
}


