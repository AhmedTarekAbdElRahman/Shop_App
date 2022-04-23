import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import '../../../models/shop_app/cart_models.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_cart_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_models.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/favourites/favourites_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget>bottomScreen=[
    ProductScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];
  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }
  HomeModel? homeModel;
  Map<int,bool?>favorites={};
  Map<dynamic,bool?>cart={};
  void getHomeData(){
    emit(ShopLoadingState());
    DioHelper.getData(url: HOME,token: token).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element){
        favorites.addAll({
          element.id!:element.inFavorites!,
        });
      });
      homeModel!.data!.products.forEach((element){
        cart.addAll({
          element.id!:element.inCart!,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  CategoriesModel? categoriesModel;
  void getCategoriesModel(){
    DioHelper.getData(url: GET_CATEGORIES,token: token,).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorsCategoriesState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorites(int productID){
    favorites[productID]=!favorites[productID]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {
          'product_id':productID,
        }
    ).then((value){
      changeFavoriteModel=ChangeFavoriteModel.fromJson(value.data);
      if(!changeFavoriteModel!.status!)favorites[productID]=!favorites[productID]!;
      else getFavoritesModel();
      emit(ShopSuccessChangeFavoritesState(changeFavoriteModel!));
    }).catchError((error){
      favorites[productID]=!favorites[productID]!;
      emit(ShopErrorsChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesModel(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES,token: token,).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);

      emit(ShopSuccessFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorsFavoritesState());
    });
  }

  ChangeCartModel? changeCartModel;
  void changeCart(int productID){
    cart[productID]=!cart[productID]!;
    emit(ShopChangeCartState());
    DioHelper.postData(
        url: CARTS,
        token: token,
        data: {
          'product_id':productID,
        }
    ).then((value){
      changeCartModel=ChangeCartModel.fromJson(value.data);
      print(value.data);
      if(!changeCartModel!.status!)cart[productID]=!cart[productID]!;
      else getCartModel();
      emit(ShopSuccessChangeCartState(changeCartModel!));
    }).catchError((error){
      cart[productID]=!cart[productID]!;
      emit(ShopErrorsChangeCartState());
    });
  }

  CartModel? cartModel;
  void getCartModel(){
    emit(ShopLoadingGetCartState());
    DioHelper.getData(url: CARTS,token: token,).then((value) {
      cartModel=CartModel.fromJson(value.data);

      emit(ShopSuccessCartState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorsCartState());
    });
  }


  ShopLoginModel? userModel;
  void getUserData(){
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(url: PROFILE,token: token,).then((value) {
      userModel=ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessGetUserDataState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorsGetUserDataState());
    });
  }

  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
  }){
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone
        },).then((value) {
      userModel=ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorsUpdateUserDataState());
    });
  }

}