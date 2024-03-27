part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

initDependencies() async {
  //widgets flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = await Supabase.initialize(
    url: projectUrl,
    anonKey: apiKey,
    debug: true,
  );
  serviceLocator.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );

  //init core
  _initCore();

  //init auth
  _initAuth();

  //init shop
  _initShop();
}

//init core
_initCore() {
  serviceLocator
      //user cubit
      .registerLazySingleton(
    () => UserCubit(),
  );
}

//init auth
_initAuth() {
  serviceLocator
    //auth remote data source
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    //auth repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDatasource: serviceLocator(),
      ),
    )
    //google sign in usecase
    ..registerFactory(
      () => GoogleSignInUsecase(
        authRepository: serviceLocator(),
      ),
    )
    //get current user usecase
    ..registerFactory(
      () => GetCurrentUser(
        authRepository: serviceLocator(),
      ),
    )
    //signout usecase
    ..registerFactory(
      () => SignOutUsecase(
        authRepository: serviceLocator(),
      ),
    )
    //auth bloc
    ..registerLazySingleton(
      () => AuthBloc(
        googleSignInUsecase: serviceLocator(),
        userCubit: serviceLocator(),
        getCurrentUser: serviceLocator(),
        signOutUsecase: serviceLocator(),
      ),
    );
}

//init shop
_initShop() {
  serviceLocator
    //shop remote data source
    ..registerFactory<ShopRemoteDatasource>(
      () => ShopRemoteDatasourceImpl(
        client: serviceLocator(),
      ),
    )
    //shop repository
    ..registerFactory<ShopRepository>(
      () => ShopRepositoryImpl(
        shopRemoteDatasource: serviceLocator(),
      ),
    )
    //add to cart usecase
    ..registerFactory(
      () => AddToCartUsecase(
        shopRepository: serviceLocator(),
      ),
    )
    //get all products usecase
    ..registerFactory(
      () => GetAllProductsUsecase(
        shopRepository: serviceLocator(),
      ),
    )
    //get products by usecase
    ..registerFactory(
      () => GetProductsByCategoryUsecase(
        shopRepository: serviceLocator(),
      ),
    )
    //get user cart usecase
    ..registerFactory(
      () => GetUserCartUsecase(
        shopRepository: serviceLocator(),
      ),
    )
    //remove from cart usecase
    ..registerFactory(
      () => RemoveFromCartUsecase(
        shopRepository: serviceLocator(),
      ),
    )
    //search products usecase
    ..registerFactory(
      () => SearchProductsUsecase(
        shopRepository: serviceLocator(),
      ),
    )
    //category bloc
    ..registerLazySingleton(
      () => CategoryBloc(
        getProductsByCategoryUsecase: serviceLocator(),
      ),
    )
    //shop view bloc
    ..registerLazySingleton(
      () => ShopViewBloc(
        getAllProductsUsecase: serviceLocator(),
      ),
    )
    //search bloc
    ..registerFactory(
      () => SearchBloc(
        searchProductsUsecase: serviceLocator(),
      ),
    )
    //cart view bloc
    ..registerFactory(
      () => CartBloc(
        getUserCartUsecase: serviceLocator(),
        addToCartUsecase: serviceLocator(),
        removeFromCartUsecase: serviceLocator(),
        userCubit: serviceLocator(),
      ),
    );
}
