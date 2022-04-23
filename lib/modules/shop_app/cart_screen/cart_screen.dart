import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';

import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import '../product_descriptions/product_descriptions.dart';
class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {

          // var model=ShopCubit.get(context).cartModel!.data!.cartItems![index].product.;
          return Scaffold(
            appBar: AppBar(
                title: Text('Your Cart'.toUpperCase()),
            ),
            body: ConditionalBuilder(
              condition: state is! ShopLoadingGetCartState,
              builder: (context) => Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListView.separated(
                        itemBuilder: (context, index) => cartItems(context,index),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: ShopCubit.get(context).cartModel!.data!.cartItems!.length
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text(
                            'the total Price is  ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${ShopCubit.get(context).cartModel!.data!.total!.round()}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: defaultColor
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
  Widget cartItems(context,index)=> InkWell(
    onTap: (){
      navigateTO(context, ProductDescription(index: index));
    },
    child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 120.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage(ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.image!),
                          width: 120,
                          height: 120,
                        ),

                        if(ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.discount!=0) Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0),
                            color: Colors.red,
                            child: Text(
                              'DISCOUNT',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white),
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.0,
                            height: 1.3,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              '${ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.price!.round()}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: defaultColor),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            if(ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.discount!=0)Text(
                                '${ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.oldPrice!.round()}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.grey,
                                    decoration:
                                    TextDecoration.lineThrough),
                              ),
                            Spacer(),
                            IconButton(

                                onPressed: (){

                                  ShopCubit.get(context).changeFavorites(ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.id!);

                                  print(ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.id);

                                },



                                icon: CircleAvatar(

                                  radius: 15.0,

                                  backgroundColor:ShopCubit.get(context).favorites[ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.id]! ?defaultColor:Colors.grey,

                                  child: Icon(

                                    Icons.favorite_border,

                                    size: 14.0,

                                    color: Colors.white,

                                  ),

                                )

                            ),
                            IconButton(

                              onPressed: (){

                                ShopCubit.get(context).changeCart(ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.id!);

                                print(ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.id);

                              },
                                icon: CircleAvatar(

                                  radius: 15.0,

                                  backgroundColor:ShopCubit.get(context).cart[ShopCubit.get(context).cartModel!.data!.cartItems![index].product!.id]! ?defaultColor:Colors.grey,

                                  child: Icon(

                                    Icons.shopping_cart,

                                    size: 14.0,

                                    color: Colors.white,

                                  ),

                                )
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),

    ),
  );
}
