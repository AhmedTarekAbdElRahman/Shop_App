

import '../../../models/shop_app/change_cart_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/login_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorsCategoriesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoriteModel model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopChangeFavoritesState extends ShopStates{}
class ShopErrorsChangeFavoritesState extends ShopStates{}
class ShopSuccessFavoritesState extends ShopStates{}
class ShopErrorsFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetUserDataState extends ShopStates{
  final ShopLoginModel? loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}
class ShopErrorsGetUserDataState extends ShopStates{}
class ShopLoadingGetUserDataState extends ShopStates{}
class ShopSuccessUpdateUserDataState extends ShopStates{
  final ShopLoginModel? loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}
class ShopErrorsUpdateUserDataState extends ShopStates{}
class ShopLoadingUpdateUserDataState extends ShopStates{}

class ShopSuccessChangeCartState extends ShopStates{
  final ChangeCartModel model;

  ShopSuccessChangeCartState(this.model);
}
class ShopChangeCartState extends ShopStates{}
class ShopErrorsChangeCartState extends ShopStates{}
class ShopSuccessCartState extends ShopStates{}
class ShopErrorsCartState extends ShopStates{}
class ShopLoadingGetCartState extends ShopStates{}