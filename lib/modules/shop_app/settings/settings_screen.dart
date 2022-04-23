import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model=ShopCubit.get(context).userModel!;
        nameController.text=model.data!.name!;
        phoneController.text=model.data!.phone!;
        emailController.text=model.data!.email!;
        return ConditionalBuilder(
          condition:ShopCubit.get(context).userModel!=null ,
          builder:(context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)LinearProgressIndicator(),
                    SizedBox(
                     height:20,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        validate:(String? value){
                          if(value!.isEmpty){
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix:Icons.person
                    ),
                    SizedBox(
                      height:20,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate:(String? value){
                          if(value!.isEmpty){
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        label: 'Email',
                        prefix:Icons.email
                    ),
                    SizedBox(
                      height:20,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate:(String? value){
                          if(value!.isEmpty){
                            return 'number must not be empty';
                          }
                          return null;
                        },
                        label: 'Number',
                        prefix:Icons.phone
                    ), SizedBox(
                      height:20,
                    ),
                    defaultButton(
                      function: (){
                        if(formKey.currentState!.validate()){
                          ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }

                      },
                      text: 'UPdate'.toUpperCase(),
                      background: defaultColor,
                      width:double.infinity,
                    ),
                    SizedBox(
                      height:20,
                    ),
                    defaultButton(
                      function: (){
                          signOut(context);
                          },
                      text: 'Logout',
                      background: defaultColor,
                      width:double.infinity,
                    )
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
