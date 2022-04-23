
import '../../../../models/shop_app/login_model.dart';

abstract class ShopLoginStatus{}
class ShopLoginInitialState extends ShopLoginStatus{}
class ShopLoginLoadingState extends ShopLoginStatus{}
class ShopLoginSuccessState extends ShopLoginStatus{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);

}
class ShopLoginErrorState extends ShopLoginStatus{
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginStatus{}
