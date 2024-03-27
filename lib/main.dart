import 'package:ecommerce/core/cubit/user_cubit.dart';
import 'package:ecommerce/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/shop_view/shop_view_bloc.dart';
import 'package:ecommerce/features/shop/presentation/views/shop_view.dart';
import 'package:ecommerce/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) async {
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<ShopViewBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<CartBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<CategoryBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<SearchBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsSignIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true)
          .copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey, brightness: Brightness.dark),
      ),
      home: BlocSelector<UserCubit, UserState, bool>(
        selector: (state) {
          return state is UserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          return isLoggedIn ? const ShopView() : const LoginView();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
