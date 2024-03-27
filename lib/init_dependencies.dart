import 'package:ecommerce/core/cubit/user_cubit.dart';
import 'package:ecommerce/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:ecommerce/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecommerce/features/auth/domain/usecases/get_current_user.dart';
import 'package:ecommerce/features/auth/domain/usecases/google_sign_in.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce/features/shop/data/datasource/shop_remote_data_source.dart';
import 'package:ecommerce/features/shop/data/repository/shop_repository_impl.dart';
import 'package:ecommerce/features/shop/domain/repository/shop_repository.dart';
import 'package:ecommerce/features/shop/domain/usecases/add_to_cart_usecase.dart';
import 'package:ecommerce/features/shop/domain/usecases/get_all_products_usecase.dart';
import 'package:ecommerce/features/shop/domain/usecases/get_products_by_category_usecase.dart';
import 'package:ecommerce/features/shop/domain/usecases/get_user_cart.dart';
import 'package:ecommerce/features/shop/domain/usecases/remove_from_cart_usecase.dart';
import 'package:ecommerce/features/shop/domain/usecases/search_products_usecase.dart';
import 'package:ecommerce/features/shop/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/shop_view/shop_view_bloc.dart';
import 'package:ecommerce/secrets/supabase_keys.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependencies.main.dart';