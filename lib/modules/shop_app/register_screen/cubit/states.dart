
import '../../../../models/shop_app/login_model.dart';

abstract class ShopRegisterStatus{}
class ShopRegisterInitialState extends ShopRegisterStatus{}
class ShopRegisterLoadingState extends ShopRegisterStatus{}
class ShopRegisterSuccessState extends ShopRegisterStatus{
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);

}
class ShopRegisterErrorState extends ShopRegisterStatus{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStatus{}
