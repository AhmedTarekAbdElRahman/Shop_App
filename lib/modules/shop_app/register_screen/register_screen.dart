import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStatus>(
        listener:(context, state) {
          if(state is ShopRegisterSuccessState){
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
          return  Scaffold(
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'register now to browse our hot offer',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please,enter your name';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please,enter your email';
                            }
                          },
                          label: 'Email',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (value){},
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPress: () {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
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
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please,enter your phone number';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            width: 800,
                            background: defaultColor,
                            function: () {
                              if(formKey.currentState!.validate()){
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
