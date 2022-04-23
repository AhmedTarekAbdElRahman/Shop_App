import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../register_screen/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStatus>(
          listener: (context, state) {
            if(state is ShopLoginSuccessState){
              if(state.loginModel.status!){
                print(state.loginModel.message);
                print(state.loginModel.data!.token);
                CacheHelper.saveData(
                    key:'token',
                    value: state.loginModel.data!.token
                ).then((value) {
                  navigateAndFinish(context, ShopLayout());
                });
              }else{
                print(state.loginModel.message);
                showtoast(
                  text: state.loginModel.message!,
                  state: ToastStates.ERROR
                );
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              'login now to browse our hot offer',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please,enter your email address';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              onSubmit: (value){
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              isPassword: ShopLoginCubit.get(context).isPassword,
                              suffixPress: () {
                                ShopLoginCubit.get(context).changePasswordVisibility();
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please,enter your password';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => defaultButton(
                                width: 800,
                                background: defaultColor,
                                function: () {
                                  if(formKey.currentState!.validate()){
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                },
                                text: 'login',
                              ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account?'),
                                TextButton(
                                    onPressed: () {
                                      navigateTO(context, ShopRegisterScreen());
                                    },
                                    child: Text('REGISTER'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
